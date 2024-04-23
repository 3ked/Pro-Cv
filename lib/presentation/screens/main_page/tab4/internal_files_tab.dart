import 'dart:io';
import 'package:cv_pdf/presentation/resources/routes_manager.dart';

import '../../../common/service/ad_helper.dart';
import '../../../resources/assets_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../resources/color_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_manager/controller/file_manager_controller.dart' as con;
import 'package:file_manager/file_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../data/data_source/local_data_source.dart';
import '../../../resources/strings_manager.dart';
import '../../../widgets/show_snack_bar.dart';

class InternalFilesTab extends StatefulWidget {
  const InternalFilesTab({Key? key}) : super(key: key);

  @override
  State<InternalFilesTab> createState() => _InternalFilesTabState();
}

class _InternalFilesTabState extends State<InternalFilesTab> {
  final con.FileManagerController controller = con.FileManagerController();
  final _keyRefresh = GlobalKey<RefreshIndicatorState>();
  List<FileSystemEntity> entities = [];
  InterstitialAd? _interstitialAd;
  bool isTouching = false;

  @override
  void initState() {
    getFiles();
    createInterstitialAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FileManager(
      controller: controller,
      builder: (context, _) {
        return RefreshIndicator(
          key: _keyRefresh,
          onRefresh: () => getFiles(),
          child: entities.isNotEmpty
              ? ListView.builder(
                  itemCount: entities.length,
                  itemBuilder: (context, index) {
                    FileSystemEntity entity = entities[index];

                    return checkIsPdfFile(entity)
                        ? Slidable(
                            key: UniqueKey(),
                            startActionPane: ActionPane(
                              motion: const StretchMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: ((context) async {
                                    if (!FileManager.isDirectory(entity)) {
                                      // share file
                                      Share.shareFiles([entity.path]);
                                    }
                                  }),
                                  backgroundColor: ColorManager.grey,
                                  icon: Icons.share,
                                  label: AppStrings.share.tr(),
                                ),
                                SlidableAction(
                                  onPressed: ((context) async {
                                    // delete a folder or file
                                    showConfirmDaialog(entity);
                                  }),
                                  backgroundColor: ColorManager.error,
                                  icon: Icons.delete,
                                  label: AppStrings.delete.tr(),
                                ),
                              ],
                            ),
                            endActionPane: ActionPane(
                              motion: const StretchMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: ((_) async {
                                    // rename folder or file
                                    await changeName(entity: entity);
                                  }),
                                  backgroundColor: ColorManager.green,
                                  icon: Icons.drive_file_rename_outline,
                                  label: AppStrings.rename.tr(),
                                ),
                              ],
                            ),
                            child: Card(
                              child: ListTile(
                                leading: FileManager.isFile(entity)
                                    ? Icon(
                                        Icons.picture_as_pdf,
                                        color: Theme.of(context).iconTheme.color,
                                      )
                                    : Icon(
                                        Icons.folder,
                                        color: Theme.of(context).iconTheme.color,
                                      ),
                                title: Text(FileManager.basename(entity, false),
                                    style: Theme.of(context).textTheme.bodyLarge),
                                subtitle: subtitle(entity),
                                onTap: () async {
                                  if (FileManager.isDirectory(entity)) {
                                    // open the folder
                                    controller.openDirectory(entity);
                                  } else {
                                    showInterstitialAd();
                                    // open the file
                                    Navigator.pushNamed(context, Routes.pdfViewerRoute,
                                        arguments: entity);
                                  }
                                },
                              ),
                            ),
                          )
                        : Container();
                  },
                )
              : GestureDetector(
                  onTapDown: (_) {
                    setState(() {
                      isTouching = true;
                    });
                    getFiles();
                  },
                  onTapUp: (_) {
                    setState(() {
                      isTouching = false;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          isTouching ? Theme.of(context).colorScheme.primary : Colors.transparent,
                    ),
                    child: SvgPicture.asset(
                      ImageAssets.noData,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
        );
      },
    );
  }

  Future<void> getFiles() async {
    if (this.entities.isNotEmpty) {
      await Future.delayed(const Duration(milliseconds: 1000));
    }
    _keyRefresh.currentState?.show();
    Directory dir = await LocalDataSourceImpl().getLocalPath;
    List<FileSystemEntity> entities = dir.listSync();
    if (this.entities != entities) {
      setState(() {
        this.entities = entities;
      });
    }
  }

  Widget subtitle(FileSystemEntity entity) {
    return FutureBuilder<FileStat>(
      future: entity.stat(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (entity is File) {
            int size = snapshot.data!.size;

            return Text(FileManager.formatBytes(size),
                style: Theme.of(context).textTheme.bodySmall);
          }
          return Text("${snapshot.data!.modified}".substring(0, 10),
              style: Theme.of(context).textTheme.bodySmall);
        } else {
          return const Text("");
        }
      },
    );
  }

  bool checkIsPdfFile(FileSystemEntity entity) {
    String extension = entity.path.split('/').last.split('.').last;
    if (extension == "pdf") {
      return true;
    }
    return false;
  }

  Future<void> changeName({
    required FileSystemEntity entity,
  }) async {
    String? name;
    Directory dir = await LocalDataSourceImpl().getLocalPath;
    String path = dir.path;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: AlertDialog(
              title: Text(AppStrings.renameCVFile.tr(),
                  style: Theme.of(context).textTheme.displayLarge),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    onChanged: (fileName) => name = fileName,
                    decoration: InputDecoration(
                      hintText: AppStrings.pdfName.tr(),
                      labelText: AppStrings.pdfName.tr(),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (name != null) {
                        for (int i = 0; i < entities.length; i++) {
                          if (FileManager.basename(entities[i], false) == "$name.pdf") {
                            FocusManager.instance.primaryFocus?.unfocus();
                            showSnackBar(context, AppStrings.changeName);
                            return;
                          }
                        }
                        Navigator.pop(context);
                        if (FileManager.isDirectory(entity)) {
                          // rename a folder
                          await entity.rename("$path/$name");
                          showSnackBar(context, AppStrings.renameDone);
                          getFiles();
                        } else {
                          // rename a file
                          await entity.rename("$path/$name.pdf");
                          showSnackBar(context, AppStrings.renameDone);
                          getFiles();
                        }
                      }
                    },
                    child: Text(AppStrings.ok.tr(), style: Theme.of(context).textTheme.bodySmall),
                  )
                ],
              ),
            ),
          );
        });
  }

  void showConfirmDaialog(FileSystemEntity entity) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title:
                Text(AppStrings.confirmDelete.tr(), style: Theme.of(context).textTheme.bodyLarge),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      if (FileManager.isDirectory(entity)) {
                        // delete a folder
                        await entity.delete(recursive: true);
                        showSnackBar(context, AppStrings.deleteDone);
                        getFiles();
                      } else {
                        // delete a file
                        Navigator.pop(context);
                        await entity.delete();
                        showSnackBar(context, AppStrings.deleteDone);
                        getFiles();
                      }
                    },
                    child: Text(AppStrings.ok.tr(), style: Theme.of(context).textTheme.bodySmall)),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(AppStrings.back.tr(), style: Theme.of(context).textTheme.bodySmall))
              ],
            ),
          );
        });
  }

  void createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) => _interstitialAd = ad,
        onAdFailedToLoad: (LoadAdError error) => _interstitialAd = null,
      ),
    );
  }

  void showInterstitialAd() {
    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          createInterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          createInterstitialAd();
        },
      );
      _interstitialAd!.show();
      _interstitialAd = null;
    }
  }

  @override
  void dispose() {
    entities.clear();
    super.dispose();
  }
}
