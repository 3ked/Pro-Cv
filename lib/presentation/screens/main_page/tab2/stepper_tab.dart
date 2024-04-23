import 'package:cv_pdf/presentation/common/service/ad_helper.dart';
import 'package:cv_pdf/presentation/resources/routes_manager.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../app/variables.dart';

class StepperTab extends StatefulWidget {
  const StepperTab({Key? key}) : super(key: key);

  @override
  State<StepperTab> createState() => _StepperTabState();
}

class _StepperTabState extends State<StepperTab> {
  int currentStep = 0;
  List<String> languageCVList = [AppStrings.arabic.tr(), AppStrings.english.tr()];
  List<String> certificateTypeList = [
    AppStrings.collegeDegree.tr(),
    AppStrings.highSchool.tr(),
    AppStrings.skillbased.tr()
  ];
  String? selectedLanguage = AppStrings.arabic.tr();
  String? selectedCertificateType = AppStrings.collegeDegree.tr();
  InterstitialAd? _interstitialAd;
  @override
  void initState() {
    createInterstitialAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isLastStep = currentStep == getSteps().length - 1;
    return Column(
      children: [
        Expanded(
          child: Stepper(
              steps: getSteps(),
              onStepTapped: (step) {
                setState(() {
                  currentStep = step;
                });
              },
              currentStep: currentStep,
              onStepContinue: () {
                if (isLastStep) {
                  showInterstitialAd();
                  // send data to server
                  Navigator.pushNamed(context, Routes.addCVRoute,
                      arguments: buildCertificateSelected());
                } else {
                  setState(() => currentStep += 1);
                }
              },
              onStepCancel: () {
                currentStep == 0 ? null : setState(() => currentStep -= 1);
              },
              controlsBuilder: (BuildContext context, ControlsDetails details) {
                return Container(
                  margin: EdgeInsets.only(top: AppMargin.m8H),
                  child: Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                              onPressed: details.onStepContinue,
                              child: Text(
                                  isLastStep ? AppStrings.confirm.tr() : AppStrings.next.tr(),
                                  style: Theme.of(context).textTheme.bodyLarge))),
                      SizedBox(
                        width: AppSize.s10W,
                      ),
                      if (currentStep != 0)
                        Expanded(
                            child: ElevatedButton(
                                onPressed: details.onStepCancel,
                                child: Text(AppStrings.back.tr(),
                                    style: Theme.of(context).textTheme.bodyLarge))),
                    ],
                  ),
                );

                // }
              }),
        ),
        ElevatedButton(
          child: Text(AppStrings.reset.tr(), style: Theme.of(context).textTheme.bodyLarge),
          onPressed: () {
            setState(() {
              currentStep = 0;
              selectedLanguage = languageCVList[0];
              selectedCertificateType = certificateTypeList[0];
            });
          },
        ),
      ],
    );
  }

  List<Step> getSteps() => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title:
              Text(AppStrings.selectLanguage.tr(), style: Theme.of(context).textTheme.displayLarge),
          content: Padding(
            padding: EdgeInsets.all(AppPadding.p8SP),
            child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppSize.s8R),
                        borderSide: BorderSide(width: AppSize.s1SP))),
                value: selectedLanguage,
                items: languageCVList
                    .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: Theme.of(context).textTheme.bodySmall,
                        )))
                    .toList(),
                onChanged: (item) {
                  setState(() {
                    selectedLanguage = item;
                  });
                }),
          ),
        ),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: Text(AppStrings.selectCertificate.tr(),
              style: Theme.of(context).textTheme.displayLarge),
          content: Padding(
              padding: EdgeInsets.all(AppPadding.p8SP),
              child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppSize.s8R),
                          borderSide: BorderSide(width: AppSize.s1SP))),
                  value: selectedCertificateType,
                  items: certificateTypeList
                      .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: Theme.of(context).textTheme.bodySmall,
                          )))
                      .toList(),
                  onChanged: (item) {
                    setState(() {
                      selectedCertificateType = item;
                    });
                  })),
        ),
        Step(
          isActive: currentStep >= 2,
          title: Text(AppStrings.complete.tr(), style: Theme.of(context).textTheme.displayLarge),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Text(
                    "${AppStrings.language.tr()} :  ",
                    style: Theme.of(context).textTheme.bodyLarge,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(selectedLanguage ?? "", style: Theme.of(context).textTheme.bodyLarge)
                ],
              ),
              const Divider(),
              Row(
                children: [
                  Text(
                    "${AppStrings.certificate.tr()} :  ",
                    style: Theme.of(context).textTheme.bodyLarge,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(selectedCertificateType ?? "", style: Theme.of(context).textTheme.bodyLarge)
                ],
              ),
              const Divider(),
            ],
          ),
        ),
      ];

  String buildCertificateSelected() {
    if (selectedLanguage == languageCVList[0]) {
      switch (certificateTypeList.indexOf(selectedCertificateType!)) {
        case 0:
          return certificateList[0];
        case 1:
          return certificateList[1];
        case 2:
          return certificateList[2];
      }
    } else if (selectedLanguage == languageCVList[1]) {
      switch (certificateTypeList.indexOf(selectedCertificateType!)) {
        case 0:
          return certificateList[3];
        case 1:
          return certificateList[4];
        case 2:
          return certificateList[5];
      }
    }
    return certificateList[0];
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
}
