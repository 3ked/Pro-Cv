// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cv_pdf/presentation/widgets/rate_app_init_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../resources/routes_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/values_manager.dart';
import '../../../widgets/change_language_app.dart';
import '../../../widgets/change_theme_button_widget.dart';
import '../../../widgets/show_snack_bar.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({Key? key}) : super(key: key);

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: AppSize.s20H,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.p28W),
            child: Text(
              AppStrings.settings.tr(),
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
          const Divider(),
          SizedBox(
            height: AppSize.s20H,
          ),
          ListTile(
            leading: Icon(
              Icons.sunny,
              color: Theme.of(context).iconTheme.color,
            ),
            title: Text(
              AppStrings.theme.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          const ChangeThemeButtonWidget(),
          ListTile(
            leading: Icon(
              Icons.language,
              color: Theme.of(context).iconTheme.color,
            ),
            title: Text(
              AppStrings.changeLanguage.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          const ChangeLanguageApp(),
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
          RateAppInitWidget(
            builder: (rateMyApp) => ListTile(
              leading: Icon(
                Icons.star_outlined,
                color: Theme.of(context).iconTheme.color,
              ),
              title: Text(
                AppStrings.rateApp.tr(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              onTap: () {
                rateMyApp.showStarRateDialog(
                  context,
                  title: AppStrings.titleRate.tr(),
                  message: AppStrings.messageRate.tr(),
                  starRatingOptions: const StarRatingOptions(initialRating: 4),
                  actionsBuilder: (context, star) => actionsBuilder(context, star, rateMyApp),
                );
              },
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.share_outlined,
              color: Theme.of(context).iconTheme.color,
            ),
            title: Text(
              AppStrings.shareApp.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            onTap: () {
              Share.share(AppStrings.msgShar.tr());
            },
          ),
          SizedBox(
            height: AppSize.s20H,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.p28W),
            child: Text(
              AppStrings.communication.tr(),
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
          const Divider(),
          SizedBox(
            height: AppSize.s20H,
          ),
          ListTile(
            leading: Icon(
              Icons.call,
              color: Theme.of(context).iconTheme.color,
            ),
            title: Text(
              AppStrings.contactUs.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            onTap: () => Navigator.pushNamed(context, Routes.contactUsRoute),
          ),
          ListTile(
            leading: Icon(
              Icons.privacy_tip_outlined,
              color: Theme.of(context).iconTheme.color,
            ),
            title: Text(
              AppStrings.privacy.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            onTap: () async {
              final Uri _url = Uri(
                scheme: "https",
                host: "pro-cv-pdf.blogspot.com",
                path: "/p/terms-and-privacy-policy.html",
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
            },
          ),
          ListTile(
            leading: Icon(
              Icons.info_outline_rounded,
              color: Theme.of(context).iconTheme.color,
            ),
            title: Text(
              AppStrings.appInfo.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            onTap: () => Navigator.pushNamed(context, Routes.appInfoRoute),
          ),
          SizedBox(
            height: AppSize.s100H,
          )
        ],
      ),
    );
  }

  List<Widget> actionsBuilder(BuildContext context, double? star, RateMyApp rateMyApp) =>
      star == null
          ? [buildCancelButton(context, rateMyApp)]
          : [buildOkButton(rateMyApp), buildCancelButton(context, rateMyApp)];

  Widget buildOkButton(RateMyApp rateMyApp) {
    //return RateMyAppRateButton(rateMyApp, text: AppStrings.ok.tr());
    return TextButton(
        onPressed: () {
          Navigator.of(context).pop();
          //LaunchReview.launch(androidAppId: "com.pro_cv.pdf");
          openUrl(context: context, scheme: "https", host: "pro-cv.uptodown.com", path: "/android");
        },
        child: Text(AppStrings.ok.tr()));
  }

  Widget buildCancelButton(BuildContext context, RateMyApp rateMyApp) =>
      RateMyAppNoButton(rateMyApp, text: AppStrings.back.tr());

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
