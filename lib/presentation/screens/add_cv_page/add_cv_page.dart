import 'dart:io';
import 'package:cv_pdf/presentation/common/logic/cubit/cv_format/cv_format_cubit.dart';
import 'package:cv_pdf/presentation/common/logic/cubit/cv_list/cv_list_cubit.dart';
import 'package:cv_pdf/presentation/common/logic/cubit/cv_theme/cv_theme_cubit.dart';
import 'package:cv_pdf/presentation/common/logic/cubit/font/font_cubit.dart';

import '../../../domain/models/models.dart';
import '../../common/logic/cubit/drop_down_selected/drop_down_selected_cubit.dart';
import '../../resources/color_manager.dart';
import '../../resources/constants_manager.dart';
import '../../resources/routes_manager.dart';
import 'widgets/certificate_selected.dart';
import 'widgets/dialog_pdf_name.dart';
import 'widgets/save_list.dart';
import '../../widgets/show_snack_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../../../app/app_prefs.dart';
import 'widgets/expansion_panel_widget.dart';
import '../../../app/variables.dart';
import '../../../data/data_source/local_data_source.dart';
import '../../common/cv_generator/cv_pdf_generator.dart';
import '../../resources/assets_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';

enum Menu { itemOne, itemTwo }

class AddCvPage extends StatefulWidget {
  const AddCvPage({Key? key}) : super(key: key);

  @override
  State<AddCvPage> createState() => _AddCvPageState();
}

class _AddCvPageState extends State<AddCvPage> {
  List<TextEditingController> myController = List.generate(13, (index) => TextEditingController());
  //List<int> listTextFormat = [15, 5, 5, 5, 5, 5, 5, 5];
  final _formKey = GlobalKey<FormState>();
  File? image;
  Image? imagePrefs;
  bool isChanged = false;
  String photoFile = "";
  List<String> certificateTypeList = [
    AppStrings.arCollegeDegree.tr(),
    AppStrings.arHighSchool.tr(),
    AppStrings.arSkillbased.tr(),
    AppStrings.enCollegeDegree.tr(),
    AppStrings.enHighSchool.tr(),
    AppStrings.enSkillbased.tr(),
  ];

  @override
  void initState() {
    setState(() {
      isChanged = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final file = ModalRoute.of(context)!.settings.arguments as dynamic;
    checkFile(file);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Expanded(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      stackWidget(file, context),
                      ListTile(
                        leading: Icon(
                          Icons.color_lens,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        title: Text(
                          AppStrings.cvTheme.tr(),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        onTap: () => Navigator.pushNamed(context, Routes.cvThemeRoute),
                      ),
                      if (file is Arguments) dropDownWidget(file, context),
                      expansionPanelList(context, cvList(file)),
                      SizedBox(
                        height: AppSize.s300H,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            buttonsRow(file, context),
          ],
        ),
      ),
    );
  }

  void checkFile(file) {
    if (file != null && file is Arguments && !isChanged) {
      if (file.cvfile!.image.isNotEmpty) {
        imagePrefs = AppPreferences.imageFromBase64String(file.cvfile!.image);
      }
      if (context.read<DropDownSelectedCubit>().state == null) {
        myController[0].text = file.cvfile!.fullName;
        myController[1].text = file.cvfile!.profile;
        myController[2].text = file.cvfile!.phoneNumber;
        myController[3].text = file.cvfile!.emailAddress;
        myController[4].text = file.cvfile!.website;
        myController[5].text = file.cvfile!.homeAdress;
        myController[6].text = file.cvfile!.ageAndMaritalStatus;
        myController[7].text = file.cvfile!.languages;
        myController[8].text = file.cvfile!.achievements;
        myController[9].text = file.cvfile!.interestsAndHobbies;
        myController[10].text = file.cvfile!.workExperience;
        myController[11].text = file.cvfile!.educationalQualifications;
        myController[12].text = file.cvfile!.personalExperienceAndSkills;
        context.read<CvFormatCubit>().toggleCvFormat(file.cvfile!.cvFormat);
      }
    }
  }

  Padding buttonsRow(file, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppPadding.p8H),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BlocBuilder<CvFormatCubit, CvFormatState>(
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () async {
                  FocusManager.instance.primaryFocus?.unfocus();
                  final cv = Cvfile(
                      state.cvFormat,
                      file != null &&
                              !isChanged &&
                              file is Arguments &&
                              file.cvfile!.image.isNotEmpty
                          ? file.cvfile!.image
                          : photoFile,
                      myController[0].text,
                      myController[1].text,
                      myController[2].text,
                      myController[3].text,
                      myController[4].text,
                      myController[5].text,
                      myController[6].text,
                      myController[7].text,
                      myController[8].text,
                      myController[9].text,
                      myController[10].text,
                      myController[11].text,
                      myController[12].text);
                  if (file is String) {
                    final pdf = await CVPdfGenerator().generate(
                      cvFile: cv,
                      cvFormat: state.cvFormat,
                      cvCertificate: file,
                      pageValue: context.read<CvThemeCubit>().state.pageValue,
                      fontValue: context.read<CvThemeCubit>().state.fontValue,
                      font: context.read<FontCubit>().state,
                    );

                    buildDialogPdfName(contextPage: context, pdf: pdf);
                  }
                  if (file is Arguments) {
                    if (context.read<DropDownSelectedCubit>().state == null) {
                      showSnackBar(context, AppStrings.selectCertificate);
                    } else {
                      final pdf = await CVPdfGenerator().generate(
                        cvFile: cv,
                        cvFormat: state.cvFormat,
                        cvCertificate: buildCertificateSelected(
                            context.read<DropDownSelectedCubit>().state ??
                                AppStrings.arCollegeDegree.tr(),
                            certificateTypeList),
                        pageValue: context.read<CvThemeCubit>().state.pageValue,
                        fontValue: context.read<CvThemeCubit>().state.fontValue,
                        font: context.read<FontCubit>().state,
                      );
                      buildDialogPdfName(contextPage: context, pdf: pdf);
                    }
                  }
                },
                child: Column(children: [
                  Text(AppStrings.saveAsPdf.tr(), style: Theme.of(context).textTheme.bodySmall),
                  const Icon(
                    Icons.picture_as_pdf,
                  ),
                ]),
              );
            },
          ),
          BlocBuilder<CvListCubit, CvListState>(
            builder: (context, state) {
              return BlocBuilder<CvFormatCubit, CvFormatState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () async {
                      final cv = Cvfile(
                          state.cvFormat,
                          file != null &&
                                  !isChanged &&
                                  file is Arguments &&
                                  file.cvfile!.image.isNotEmpty
                              ? file.cvfile!.image
                              : photoFile,
                          myController[0].text,
                          myController[1].text,
                          myController[2].text,
                          myController[3].text,
                          myController[4].text,
                          myController[5].text,
                          myController[6].text,
                          myController[7].text,
                          myController[8].text,
                          myController[9].text,
                          myController[10].text,
                          myController[11].text,
                          myController[12].text);
                      if (file is String) {
                        final pdf = await CVPdfGenerator().generate(
                          cvFile: cv,
                          cvFormat: context.read<CvFormatCubit>().state.cvFormat,
                          cvCertificate: file,
                          pageValue: context.read<CvThemeCubit>().state.pageValue,
                          fontValue: context.read<CvThemeCubit>().state.fontValue,
                          font: context.read<FontCubit>().state,
                        );
                        final cvPdf = await LocalDataSourceImpl().saveDocument(pdf: pdf);
                        openPdf(context, cvPdf);
                      }
                      if (file is Arguments) {
                        if (context.read<DropDownSelectedCubit>().state == null) {
                          showSnackBar(context, AppStrings.selectCertificate);
                        } else {
                          final pdf = await CVPdfGenerator().generate(
                            cvFile: cv,
                            cvFormat: context.read<CvFormatCubit>().state.cvFormat,
                            cvCertificate: buildCertificateSelected(
                                context.read<DropDownSelectedCubit>().state ??
                                    AppStrings.arCollegeDegree.tr(),
                                certificateTypeList),
                            pageValue: context.read<CvThemeCubit>().state.pageValue,
                            fontValue: context.read<CvThemeCubit>().state.fontValue,
                            font: context.read<FontCubit>().state,
                          );
                          final cvPdf = await LocalDataSourceImpl().saveDocument(pdf: pdf);
                          openPdf(context, cvPdf);
                        }
                      }
                    },
                    child: Column(children: [
                      Text(AppStrings.preview.tr(), style: Theme.of(context).textTheme.bodySmall),
                      const Icon(
                        Icons.file_open,
                      ),
                    ]),
                  );
                },
              );
            },
          ),
          BlocBuilder<CvListCubit, CvListState>(
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () async {
                  FocusManager.instance.primaryFocus?.unfocus();
                  var cvFormat = CvFormat(
                    fullNameFontSize: context.read<CvFormatCubit>().state.cvFormat.fullNameFontSize,
                    profileLine: context.read<CvFormatCubit>().state.cvFormat.profileLine,
                    languagesLines: context.read<CvFormatCubit>().state.cvFormat.languagesLines,
                    achievementsLines:
                        context.read<CvFormatCubit>().state.cvFormat.achievementsLines,
                    interestsAndHobbiesLines:
                        context.read<CvFormatCubit>().state.cvFormat.interestsAndHobbiesLines,
                    workExperienceLines:
                        context.read<CvFormatCubit>().state.cvFormat.workExperienceLines,
                    educationalQualificationsLines:
                        context.read<CvFormatCubit>().state.cvFormat.educationalQualificationsLines,
                    personalExperienceAndSkillsLines: context
                        .read<CvFormatCubit>()
                        .state
                        .cvFormat
                        .personalExperienceAndSkillsLines,
                  );
                  if (file != null && file is Arguments) {
                    buildSaveEditList(
                        state, file, context, image, myController, file, cvFormat, isChanged);
                  } else {
                    buildSaveList(state, context, image, myController, cvFormat);
                  }

                  showSnackBar(context, AppStrings.saveDone);
                },
                child: Column(children: [
                  Text(AppStrings.save.tr(), style: Theme.of(context).textTheme.bodySmall),
                  const Icon(
                    Icons.save,
                  ),
                ]),
              );
            },
          ),
        ],
      ),
    );
  }

  ExpansionPanelList expansionPanelList(BuildContext context, List<Item> cvList) {
    return ExpansionPanelList(
      expandedHeaderPadding:
          EdgeInsets.symmetric(vertical: AppPadding.p8H, horizontal: AppPadding.p8W),
      expansionCallback: ((index, isExpanded) {
        setState(() => cvList[index].isExpanded = !isExpanded);
      }),
      children: cvList.map((item) => expansionPanelWidget(item, context, myController)).toList(),
    );
  }

  Center dropDownWidget(file, BuildContext context) {
    return Center(child: BlocBuilder<DropDownSelectedCubit, String?>(
      builder: (context, state) {
        return DropdownButtonFormField<String>(
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSize.s8R),
                    borderSide: BorderSide(width: AppSize.s1SP, color: ColorManager.error))),
            value: state,
            items: certificateTypeList
                .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: Theme.of(context).textTheme.bodyLarge,
                    )))
                .toList(),
            onChanged: (item) {
              setState(() {
                context.read<DropDownSelectedCubit>().toggleSelected(value: item!);
              });
            });
      },
    ));
  }

  Stack stackWidget(file, BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        ClipOval(
          child: file != null && !isChanged && file is Arguments && file.cvfile!.image.isNotEmpty
              ? imagePrefs
              : image != null
                  ? Image.file(
                      image!,
                      fit: BoxFit.contain,
                      width: AppSize.s300R,
                      height: AppSize.s300R,
                    )
                  : Image.asset(
                      ImageAssets.emptyProfile,
                      fit: BoxFit.contain,
                      width: AppSize.s300R,
                      height: AppSize.s300R,
                    ),
        ),
        Positioned(
          bottom: AppSize.s0,
          right: AppSize.s20W,
          child: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            radius: AppSize.s40R,
            child: PopupMenuButton<Menu>(
              child: Icon(
                Icons.menu,
                color: Theme.of(context).iconTheme.color,
                size: AppSize.s50SP,
              ),
              onSelected: (Menu item) {
                if (item == Menu.itemOne) {
                  setState(() {
                    image = null;
                    if (file != null) {
                      isChanged = true;
                    }
                  });
                }
                if (item == Menu.itemTwo) {
                  _buildImageDialog();
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
                PopupMenuItem(
                    value: Menu.itemOne,
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete_forever_outlined,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        SizedBox(
                          width: AppSize.s10W,
                        ),
                        Expanded(
                            child: Text(AppStrings.deletePhoto.tr(),
                                style: Theme.of(context).textTheme.bodySmall)),
                      ],
                    )),
                PopupMenuItem(
                    value: Menu.itemTwo,
                    child: Row(
                      children: [
                        Icon(
                          Icons.add_a_photo_outlined,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        SizedBox(
                          width: AppSize.s10W,
                        ),
                        Expanded(
                            child: Text(AppStrings.changePhoto.tr(),
                                style: Theme.of(context).textTheme.bodySmall)),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _buildImageDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(AppStrings.titleAlertDialog.tr()),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () => pickImage(ImageSource.camera),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(AppPadding.p8SP),
                        child: Icon(
                          Icons.camera,
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                      Text(AppStrings.camera.tr()),
                    ],
                  ),
                ),
                Divider(
                  thickness: AppSize.s1SP,
                ),
                InkWell(
                  onTap: () => pickImage(ImageSource.gallery),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(AppPadding.p8SP),
                        child: Icon(
                          Icons.image,
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                      Text(AppStrings.gallery.tr()),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image != null) {
        _cropImage(image.path);
        Navigator.pop(context);
      } else {
        Navigator.pop(context);
      }
    } on PlatformException catch (e) {
      showSnackBar(context, "Failed to pick image : $e");
    }
  }

  void _cropImage(String filePath) async {
    try {
      final croppedImage = await ImageCropper().cropImage(sourcePath: filePath);
      if (croppedImage == null) return;

      final imageTemporary = File(croppedImage.path);

      photoFile = croppedImage.path;

      setState(() {
        image = imageTemporary;
        isChanged = true;
      });
    } on PlatformException catch (e) {
      showSnackBar(context, "Failed to pick image : $e");
    }
  }

  void openPdf(BuildContext context, File file) =>
      Navigator.pushNamed(context, Routes.pdfViewerRoute, arguments: file);

  List<Item> cvList(file) {
    String? cvType = file is String
        ? file
        : file is Arguments
            ? buildCertificateSelected(
                context.read<DropDownSelectedCubit>().state ?? AppStrings.arCollegeDegree.tr(),
                certificateTypeList)
            : null;
    switch (cvType) {
      case AppConstants.arCollegeDegree:
        return cvCollegeDegree;
      case AppConstants.enCollegeDegree:
        return cvCollegeDegree;
      case AppConstants.arHighSchool:
        return cvHighSchool;
      case AppConstants.enHighSchool:
        return cvHighSchool;
      case AppConstants.arSkillbased:
        return cvSkillBased;
      case AppConstants.enSkillbased:
        return cvSkillBased;
      default:
        return cvCollegeDegree;
    }
  }
}
