import 'package:cv_pdf/presentation/resources/color_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../resources/assets_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';
import '../../widgets/show_snack_bar.dart';

class AppInfoPage extends StatelessWidget {
  const AppInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Pro CV",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              AppStrings.version.tr(),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: AppPadding.p15H),
              child: CircleAvatar(
                radius: AppSize.s105R,
                backgroundColor: ColorManager.darkGrey,
                child: CircleAvatar(
                  radius: AppSize.s100R,
                  backgroundImage: const AssetImage(ImageAssets.logo),
                ),
              ),
            ),
            Text(
              AppStrings.allRightsReserved.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (newContext) {
                      return Dialog(
                          child: Row(
                        children: [
                          // whatsapp
                          IconButton(
                            onPressed: () {
                              openUrl(
                                  context: context,
                                  scheme: "https",
                                  host: "wa.me",
                                  path: "/message/BHZRKQVH5I4YB1");
                            },
                            icon: const Icon(Icons.whatsapp),
                          ),
                          // telegram
                          IconButton(
                            onPressed: () {
                              openUrl(
                                  context: context,
                                  scheme: "https",
                                  host: "t.me",
                                  path: "/EngAliJoher");
                            },
                            icon: const Icon(Icons.telegram),
                          ),
                          // facebook
                          IconButton(
                            onPressed: () {
                              openUrl(
                                  context: context,
                                  scheme: "https",
                                  host: "m.me",
                                  path: "/3Li.jhr");
                            },
                            icon: const Icon(Icons.facebook),
                          ),
                          // website
                          IconButton(
                            onPressed: () {
                              openUrl(
                                  context: context,
                                  scheme: "https",
                                  host: "engalijoher.blogspot.com");
                            },
                            icon: const Icon(Icons.blur_circular_outlined),
                          ),
                          // gmail
                          IconButton(
                            onPressed: () {
                              openUrl(
                                  context: context,
                                  scheme: "mailto",
                                  path: "eng.alijoher@gmail.com");
                            },
                            icon: const Icon(Icons.email),
                          ),
                        ],
                      ));
                    });
              },
              child: Text(" ${AppStrings.nameDev.tr()}\n${AppStrings.conectDev.tr()}",
                  style: TextStyle(color: Theme.of(context).colorScheme.primary)),
            ),
          ],
        ),
      ),
    );
  }

  void openUrl(
      {required BuildContext context, required String? scheme, String? host, String? path}) async {
    final Uri _url = Uri(
      scheme: scheme,
      host: host,
      path: path,
    );
    try {
      if (await canLaunchUrl(_url)) {
        await launchUrl(
          _url,
          mode: LaunchMode.externalApplication,
          webViewConfiguration: const WebViewConfiguration(
            enableJavaScript: false,
            enableDomStorage: false,
          ),
        );
      } else {
        throw "${AppStrings.notLaunch.tr()} $_url";
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
