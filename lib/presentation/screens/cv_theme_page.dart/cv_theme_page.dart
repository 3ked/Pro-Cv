import 'package:cv_pdf/presentation/common/logic/cubit/cv_theme/cv_theme_cubit.dart';
import 'package:cv_pdf/presentation/common/logic/cubit/font/font_cubit.dart';
import 'package:cv_pdf/presentation/resources/assets_manager.dart';
import 'package:cv_pdf/presentation/resources/color_manager.dart';
import 'package:cv_pdf/presentation/resources/constants_manager.dart';
import 'package:cv_pdf/presentation/widgets/show_snack_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../../resources/font_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';

enum Menu {
  itemOne,
  itemTwo,
  itemThree,
  itemFour,
  itemFive,
  itemSex,
  itemSeven,
}

class CvThemePage extends StatefulWidget {
  const CvThemePage({Key? key}) : super(key: key);

  @override
  State<CvThemePage> createState() => _CvThemePageState();
}

class _CvThemePageState extends State<CvThemePage> {
  final List<TextEditingController> _myController =
      List.generate(16, (index) => TextEditingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.cvTheme.tr()),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: AppSize.s20H,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p14SP),
              child: Text(
                "${AppStrings.pickColor.tr()} : ",
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    pickColor(
                        context: context,
                        value: context.read<CvThemeCubit>().state.pageValue,
                        onColorChanged: (color) {
                          context.read<CvThemeCubit>().togglePageColor(newPageValue: color.value);
                        });
                  },
                  child: Text(
                    AppStrings.pageColor.tr(),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    pickColor(
                        context: context,
                        value: context.read<CvThemeCubit>().state.fontValue,
                        onColorChanged: (color) {
                          context.read<CvThemeCubit>().toggleFontColor(newFontValue: color.value);
                        });
                  },
                  child: Text(AppStrings.fontColor.tr()),
                ),
                ElevatedButton(
                  onPressed: () {
                    context
                        .read<CvThemeCubit>()
                        .togglePageColor(newPageValue: const Color(0xFF3A3A3A).value);
                    context.read<CvThemeCubit>().toggleFontColor(newFontValue: Colors.white.value);
                    context.read<FontCubit>().toggleFont(font: FontAssets.hacenTunisia);
                  },
                  child: Text(AppStrings.reset.tr()),
                ),
              ],
            ),
            BlocBuilder<CvThemeCubit, CvThemeState>(
              builder: (context, state) {
                return Center(
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Container(
                        height: AppSize.s235H,
                        width: AppSize.s235W,
                        decoration:
                            BoxDecoration(shape: BoxShape.circle, color: Color(state.pageValue)),
                      ),
                      Text(
                        AppStrings.fontColor.tr(),
                        style: TextStyle(
                            color: Color(state.fontValue),
                            fontSize: FontSize.s22,
                            fontWeight: FontWeightManager.bold),
                      ),
                    ],
                  ),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p14SP),
              child: Text(
                "${AppStrings.pickFont.tr()} : ",
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            const Divider(),
            BlocBuilder<FontCubit, String>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PopupMenuButton<Menu>(
                      child: Container(
                        padding: EdgeInsets.all(AppPadding.p8SP),
                        margin: EdgeInsets.all(AppMargin.m14Sp),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s12R),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        child: Center(
                          child: Text.rich(TextSpan(
                              text: "${AppStrings.pickFont.tr()} : ",
                              style: TextStyle(
                                color: ColorManager.black,
                                fontSize: FontSize.s22,
                              ),
                              children: [
                                TextSpan(
                                    text: getFontFamily(
                                      state: state,
                                    ),
                                    style: TextStyle(
                                      color: ColorManager.darkGrey,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ])),
                        ),
                      ),
                      onSelected: (Menu item) async {
                        if (item == Menu.itemOne) {
                          context.read<FontCubit>().toggleFont(font: FontAssets.hacenTunisia);
                        }
                        if (item == Menu.itemTwo) {
                          context.read<FontCubit>().toggleFont(font: FontAssets.helveticaWorld);
                        }
                        if (item == Menu.itemThree) {
                          context.read<FontCubit>().toggleFont(font: FontAssets.bonaNova);
                        }

                        if (item == Menu.itemFour) {
                          context.read<FontCubit>().toggleFont(font: FontAssets.mansalva);
                        }
                        if (item == Menu.itemFive) {
                          context.read<FontCubit>().toggleFont(font: FontAssets.openSans);
                        }
                        if (item == Menu.itemSex) {
                          context.read<FontCubit>().toggleFont(font: FontAssets.eBGaramond);
                        }
                        if (item == Menu.itemSeven) {
                          context.read<FontCubit>().toggleFont(font: FontAssets.gFSDidot);
                        }
                      },
                      itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
                        PopupMenuItem(
                            value: Menu.itemOne,
                            child: Text(FontFamily.hacenTunisia,
                                style: Theme.of(context).textTheme.bodySmall)),
                        PopupMenuItem(
                            value: Menu.itemTwo,
                            child: Text(FontFamily.helveticaWorld,
                                style: Theme.of(context).textTheme.bodySmall)),
                        PopupMenuItem(
                            value: Menu.itemThree,
                            child: Text(FontFamily.bonaNova,
                                style: Theme.of(context).textTheme.bodySmall)),
                        PopupMenuItem(
                            value: Menu.itemFour,
                            child: Text(FontFamily.mansalva,
                                style: Theme.of(context).textTheme.bodySmall)),
                        PopupMenuItem(
                            value: Menu.itemFive,
                            child: Text(FontFamily.openSans,
                                style: Theme.of(context).textTheme.bodySmall)),
                        PopupMenuItem(
                            value: Menu.itemSex,
                            child: Text(FontFamily.eBGaramond,
                                style: Theme.of(context).textTheme.bodySmall)),
                        PopupMenuItem(
                            value: Menu.itemSeven,
                            child: Text(FontFamily.gFSDidot,
                                style: Theme.of(context).textTheme.bodySmall)),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppPadding.p80H),
                      child: Text.rich(
                          TextSpan(text: "${AppStrings.arabicLanguage.tr()} : ", children: [
                        TextSpan(
                            text: isSupportArabic(getFontFamily(state: state))
                                ? AppStrings.support.tr()
                                : AppStrings.notSupport.tr(),
                            style: TextStyle(
                              fontSize: FontSize.s22,
                              color: isSupportArabic(getFontFamily(state: state))
                                  ? ColorManager.green
                                  : ColorManager.error,
                            )),
                      ])),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppPadding.p80H),
                      child: Text.rich(
                          TextSpan(text: "${AppStrings.englishLanguage.tr()} : ", children: [
                        TextSpan(
                            text: isSupportEnglish(getFontFamily(state: state))
                                ? AppStrings.support.tr()
                                : AppStrings.notSupport.tr(),
                            style: TextStyle(
                              fontSize: FontSize.s22,
                              color: isSupportEnglish(getFontFamily(state: state))
                                  ? ColorManager.green
                                  : ColorManager.error,
                            )),
                      ])),
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<FontCubit>().toggleFont(font: FontAssets.hacenTunisia);
                        },
                        child: Text(AppStrings.reset.tr()),
                      ),
                    ),
                  ],
                );
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p14SP),
              child: Text(
                "${AppStrings.editSectionTitles.tr()} : ",
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            const Divider(),
            ExpansionPanelList.radio(
                expandedHeaderPadding:
                    EdgeInsets.symmetric(vertical: AppPadding.p8H, horizontal: AppPadding.p8W),
                //expansionCallback: ((index, isExpanded) {}),
                children: [
                  ExpansionPanelRadio(
                    value: "ar",
                    canTapOnHeader: true,
                    headerBuilder: (context, isOpen) {
                      return Text(AppStrings.arabicLanguage.tr());
                    },
                    body: Column(
                      children: [
                        // personalInformationArabic
                        Padding(
                            padding: EdgeInsets.all(AppPadding.p8SP),
                            child: TextField(
                              controller: _myController[0],
                              onSubmitted: (data) {
                                editSectionTitle(() {
                                  setState(
                                    () {
                                      AppConstants.personalInformationArabic = data;
                                    },
                                  );
                                  _myController[0].clear();
                                });
                              },
                              decoration: InputDecoration(
                                hintText: AppConstants.personalInformationArabic,
                                labelText: AppConstants.personalInformationArabic,
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.send),
                                  onPressed: () {
                                    editSectionTitle(() {
                                      setState(
                                        () {
                                          AppConstants.personalInformationArabic =
                                              _myController[0].text;
                                        },
                                      );
                                      _myController[0].clear();
                                    });
                                  },
                                ),
                              ),
                            )),

                        // languagesArabic
                        Padding(
                            padding: EdgeInsets.all(AppPadding.p8SP),
                            child: TextField(
                              controller: _myController[1],
                              onSubmitted: (data) {
                                editSectionTitle(() {
                                  setState(
                                    () {
                                      AppConstants.languagesArabic = data;
                                    },
                                  );
                                  _myController[1].clear();
                                });
                              },
                              decoration: InputDecoration(
                                hintText: AppConstants.languagesArabic,
                                labelText: AppConstants.languagesArabic,
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.send),
                                  onPressed: () {
                                    editSectionTitle(() {
                                      setState(
                                        () {
                                          AppConstants.languagesArabic = _myController[1].text;
                                        },
                                      );
                                      _myController[1].clear();
                                    });
                                  },
                                ),
                              ),
                            )),

                        // achievementsArabic
                        Padding(
                            padding: EdgeInsets.all(AppPadding.p8SP),
                            child: TextField(
                              controller: _myController[2],
                              onSubmitted: (data) {
                                editSectionTitle(() {
                                  setState(
                                    () {
                                      AppConstants.achievementsArabic = data;
                                    },
                                  );
                                  _myController[2].clear();
                                });
                              },
                              decoration: InputDecoration(
                                hintText: AppConstants.achievementsArabic,
                                labelText: AppConstants.achievementsArabic,
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.send),
                                  onPressed: () {
                                    editSectionTitle(() {
                                      setState(
                                        () {
                                          AppConstants.achievementsArabic = _myController[2].text;
                                        },
                                      );
                                      _myController[2].clear();
                                    });
                                  },
                                ),
                              ),
                            )),

                        // interestsAndHobbiesArabic
                        Padding(
                            padding: EdgeInsets.all(AppPadding.p8SP),
                            child: TextField(
                              controller: _myController[3],
                              onSubmitted: (data) {
                                editSectionTitle(() {
                                  setState(
                                    () {
                                      AppConstants.interestsAndHobbiesArabic = data;
                                    },
                                  );
                                  _myController[3].clear();
                                });
                              },
                              decoration: InputDecoration(
                                hintText: AppConstants.interestsAndHobbiesArabic,
                                labelText: AppConstants.interestsAndHobbiesArabic,
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.send),
                                  onPressed: () {
                                    editSectionTitle(() {
                                      setState(
                                        () {
                                          AppConstants.interestsAndHobbiesArabic =
                                              _myController[3].text;
                                        },
                                      );
                                      _myController[3].clear();
                                    });
                                  },
                                ),
                              ),
                            )),

                        // workExperienceArabic
                        Padding(
                            padding: EdgeInsets.all(AppPadding.p8SP),
                            child: TextField(
                              controller: _myController[4],
                              onSubmitted: (data) {
                                editSectionTitle(() {
                                  setState(
                                    () {
                                      AppConstants.workExperienceArabic = data;
                                    },
                                  );
                                  _myController[4].clear();
                                });
                              },
                              decoration: InputDecoration(
                                hintText: AppConstants.workExperienceArabic,
                                labelText: AppConstants.workExperienceArabic,
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.send),
                                  onPressed: () {
                                    editSectionTitle(() {
                                      setState(
                                        () {
                                          AppConstants.workExperienceArabic = _myController[4].text;
                                        },
                                      );
                                      _myController[4].clear();
                                    });
                                  },
                                ),
                              ),
                            )),

                        // educationalQualificationsArabic
                        Padding(
                            padding: EdgeInsets.all(AppPadding.p8SP),
                            child: TextField(
                              controller: _myController[5],
                              onSubmitted: (data) {
                                editSectionTitle(() {
                                  setState(
                                    () {
                                      AppConstants.educationalQualificationsArabic = data;
                                    },
                                  );
                                  _myController[5].clear();
                                });
                              },
                              decoration: InputDecoration(
                                hintText: AppConstants.educationalQualificationsArabic,
                                labelText: AppConstants.educationalQualificationsArabic,
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.send),
                                  onPressed: () {
                                    editSectionTitle(() {
                                      setState(
                                        () {
                                          AppConstants.educationalQualificationsArabic =
                                              _myController[5].text;
                                        },
                                      );
                                      _myController[5].clear();
                                    });
                                  },
                                ),
                              ),
                            )),

                        // personalExperienceAndSkillsArabic
                        Padding(
                            padding: EdgeInsets.all(AppPadding.p8SP),
                            child: TextField(
                              controller: _myController[6],
                              onSubmitted: (data) {
                                editSectionTitle(() {
                                  setState(
                                    () {
                                      AppConstants.personalExperienceAndSkillsArabic = data;
                                    },
                                  );
                                  _myController[6].clear();
                                });
                              },
                              decoration: InputDecoration(
                                hintText: AppConstants.personalExperienceAndSkillsArabic,
                                labelText: AppConstants.personalExperienceAndSkillsArabic,
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.send),
                                  onPressed: () {
                                    editSectionTitle(() {
                                      setState(
                                        () {
                                          AppConstants.personalExperienceAndSkillsArabic =
                                              _myController[6].text;
                                        },
                                      );
                                      _myController[6].clear();
                                    });
                                  },
                                ),
                              ),
                            )),

                        // profileArabic
                        Padding(
                            padding: EdgeInsets.all(AppPadding.p8SP),
                            child: TextField(
                              controller: _myController[7],
                              onSubmitted: (data) {
                                editSectionTitle(() {
                                  setState(
                                    () {
                                      AppConstants.profileArabic = data;
                                    },
                                  );
                                  _myController[7].clear();
                                });
                              },
                              decoration: InputDecoration(
                                hintText: AppConstants.profileArabic,
                                labelText: AppConstants.profileArabic,
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.send),
                                  onPressed: () {
                                    editSectionTitle(() {
                                      setState(
                                        () {
                                          AppConstants.profileArabic = _myController[7].text;
                                        },
                                      );
                                      _myController[7].clear();
                                    });
                                  },
                                ),
                              ),
                            )),

                        // reset
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              AppConstants.personalInformationArabic = "المعلومات الشخصية";
                              AppConstants.languagesArabic = "اللغات";
                              AppConstants.achievementsArabic = "الانجازات";
                              AppConstants.interestsAndHobbiesArabic = "الاهتمامات والهوايات";
                              AppConstants.workExperienceArabic = "خبرات العمل";
                              AppConstants.educationalQualificationsArabic = "المؤهلات التعليمية";
                              AppConstants.personalExperienceAndSkillsArabic =
                                  "الخبرات والمهارات الشخصية";
                              AppConstants.profileArabic = "الملف الشخصي";
                            });

                            showSnackBar(context, AppStrings.success);
                          },
                          child: Text(AppStrings.reset.tr()),
                        ),
                      ],
                    ),
                  ),
                  ExpansionPanelRadio(
                    value: "en",
                    canTapOnHeader: true,
                    headerBuilder: (context, isOpen) {
                      return Text(AppStrings.englishLanguage.tr());
                    },
                    body: Column(
                      children: [
                        // personalInformationEnglish
                        Padding(
                            padding: EdgeInsets.all(AppPadding.p8SP),
                            child: TextField(
                              controller: _myController[8],
                              onSubmitted: (data) {
                                editSectionTitle(() {
                                  setState(
                                    () {
                                      AppConstants.personalInformationEnglish = data;
                                    },
                                  );
                                  _myController[8].clear();
                                });
                              },
                              decoration: InputDecoration(
                                hintText: AppConstants.personalInformationEnglish,
                                labelText: AppConstants.personalInformationEnglish,
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.send),
                                  onPressed: () {
                                    editSectionTitle(() {
                                      setState(
                                        () {
                                          AppConstants.personalInformationEnglish =
                                              _myController[8].text;
                                        },
                                      );
                                      _myController[8].clear();
                                    });
                                  },
                                ),
                              ),
                            )),

                        // languagesEnglish
                        Padding(
                            padding: EdgeInsets.all(AppPadding.p8SP),
                            child: TextField(
                              controller: _myController[9],
                              onSubmitted: (data) {
                                editSectionTitle(() {
                                  setState(
                                    () {
                                      AppConstants.languagesEnglish = data;
                                    },
                                  );
                                  _myController[9].clear();
                                });
                              },
                              decoration: InputDecoration(
                                hintText: AppConstants.languagesEnglish,
                                labelText: AppConstants.languagesEnglish,
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.send),
                                  onPressed: () {
                                    editSectionTitle(() {
                                      setState(
                                        () {
                                          AppConstants.languagesEnglish = _myController[9].text;
                                        },
                                      );
                                      _myController[9].clear();
                                    });
                                  },
                                ),
                              ),
                            )),

                        // achievementsEnglish
                        Padding(
                            padding: EdgeInsets.all(AppPadding.p8SP),
                            child: TextField(
                              controller: _myController[10],
                              onSubmitted: (data) {
                                editSectionTitle(() {
                                  setState(
                                    () {
                                      AppConstants.achievementsEnglish = data;
                                    },
                                  );
                                  _myController[10].clear();
                                });
                              },
                              decoration: InputDecoration(
                                hintText: AppConstants.achievementsEnglish,
                                labelText: AppConstants.achievementsEnglish,
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.send),
                                  onPressed: () {
                                    editSectionTitle(() {
                                      setState(
                                        () {
                                          AppConstants.achievementsEnglish = _myController[10].text;
                                        },
                                      );
                                      _myController[10].clear();
                                    });
                                  },
                                ),
                              ),
                            )),

                        // interestsAndHobbiesEnglish
                        Padding(
                            padding: EdgeInsets.all(AppPadding.p8SP),
                            child: TextField(
                              controller: _myController[11],
                              onSubmitted: (data) {
                                editSectionTitle(() {
                                  setState(
                                    () {
                                      AppConstants.interestsAndHobbiesEnglish = data;
                                    },
                                  );
                                  _myController[11].clear();
                                });
                              },
                              decoration: InputDecoration(
                                hintText: AppConstants.interestsAndHobbiesEnglish,
                                labelText: AppConstants.interestsAndHobbiesEnglish,
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.send),
                                  onPressed: () {
                                    editSectionTitle(() {
                                      setState(
                                        () {
                                          AppConstants.interestsAndHobbiesEnglish =
                                              _myController[11].text;
                                        },
                                      );
                                      _myController[11].clear();
                                    });
                                  },
                                ),
                              ),
                            )),

                        // workExperienceEnglish
                        Padding(
                            padding: EdgeInsets.all(AppPadding.p8SP),
                            child: TextField(
                              controller: _myController[12],
                              onSubmitted: (data) {
                                editSectionTitle(() {
                                  setState(
                                    () {
                                      AppConstants.workExperienceEnglish = data;
                                    },
                                  );
                                  _myController[12].clear();
                                });
                              },
                              decoration: InputDecoration(
                                hintText: AppConstants.workExperienceEnglish,
                                labelText: AppConstants.workExperienceEnglish,
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.send),
                                  onPressed: () {
                                    editSectionTitle(() {
                                      setState(
                                        () {
                                          AppConstants.workExperienceEnglish =
                                              _myController[12].text;
                                        },
                                      );
                                      _myController[12].clear();
                                    });
                                  },
                                ),
                              ),
                            )),

                        // educationalQualificationsEnglish
                        Padding(
                            padding: EdgeInsets.all(AppPadding.p8SP),
                            child: TextField(
                              controller: _myController[13],
                              onSubmitted: (data) {
                                editSectionTitle(() {
                                  setState(
                                    () {
                                      AppConstants.educationalQualificationsEnglish = data;
                                    },
                                  );
                                  _myController[13].clear();
                                });
                              },
                              decoration: InputDecoration(
                                hintText: AppConstants.educationalQualificationsEnglish,
                                labelText: AppConstants.educationalQualificationsEnglish,
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.send),
                                  onPressed: () {
                                    editSectionTitle(() {
                                      setState(
                                        () {
                                          AppConstants.educationalQualificationsEnglish =
                                              _myController[13].text;
                                        },
                                      );
                                      _myController[13].clear();
                                    });
                                  },
                                ),
                              ),
                            )),

                        // personalExperienceAndSkillsEnglish
                        Padding(
                            padding: EdgeInsets.all(AppPadding.p8SP),
                            child: TextField(
                              controller: _myController[14],
                              onSubmitted: (data) {
                                editSectionTitle(() {
                                  setState(
                                    () {
                                      AppConstants.personalExperienceAndSkillsEnglish = data;
                                    },
                                  );
                                  _myController[14].clear();
                                });
                              },
                              decoration: InputDecoration(
                                hintText: AppConstants.personalExperienceAndSkillsEnglish,
                                labelText: AppConstants.personalExperienceAndSkillsEnglish,
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.send),
                                  onPressed: () {
                                    editSectionTitle(() {
                                      setState(
                                        () {
                                          AppConstants.personalExperienceAndSkillsEnglish =
                                              _myController[14].text;
                                        },
                                      );
                                      _myController[14].clear();
                                    });
                                  },
                                ),
                              ),
                            )),

                        // profileEnglish
                        Padding(
                            padding: EdgeInsets.all(AppPadding.p8SP),
                            child: TextField(
                              controller: _myController[15],
                              onSubmitted: (data) {
                                editSectionTitle(() {
                                  setState(
                                    () {
                                      AppConstants.profileEnglish = data;
                                    },
                                  );
                                  _myController[15].clear();
                                });
                              },
                              decoration: InputDecoration(
                                hintText: AppConstants.profileEnglish,
                                labelText: AppConstants.profileEnglish,
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.send),
                                  onPressed: () {
                                    editSectionTitle(() {
                                      setState(
                                        () {
                                          AppConstants.profileEnglish = _myController[15].text;
                                        },
                                      );
                                      _myController[15].clear();
                                    });
                                  },
                                ),
                              ),
                            )),

                        // reset
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              AppConstants.personalInformationEnglish = "Personal Information";
                              AppConstants.languagesEnglish = "Languages";
                              AppConstants.achievementsEnglish = "Achievements";
                              AppConstants.interestsAndHobbiesEnglish = "Interests and Hobbies";
                              AppConstants.workExperienceEnglish = "Work Experience";
                              AppConstants.educationalQualificationsEnglish =
                                  "Educational Qualifications";
                              AppConstants.personalExperienceAndSkillsEnglish =
                                  "Personal Experience and Skills";
                              AppConstants.profileEnglish = "Profile";
                            });

                            showSnackBar(context, AppStrings.success);
                          },
                          child: Text(AppStrings.reset.tr()),
                        ),
                      ],
                    ),
                  ),
                ]),
            SizedBox(
              height: AppSize.s150H,
            )
          ],
        ),
      ),
    );
  }

  void editSectionTitle(Function function) {
    FocusManager.instance.primaryFocus?.unfocus();
    function.call();
    showSnackBar(context, AppStrings.successSectionTitleMessage);
  }

  void pickColor(
          {required BuildContext context,
          required int value,
          required Function(Color) onColorChanged}) =>
      showDialog(
        context: context,
        builder: (context) => SingleChildScrollView(
          child: AlertDialog(
            title: Center(child: Text(AppStrings.pickColor.tr())),
            content: SingleChildScrollView(
              child: buildColorPicker(value: value, onColorChanged: onColorChanged),
            ),
            actions: [
              ElevatedButton(
                child: Text(AppStrings.ok.tr()),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
            actionsAlignment: MainAxisAlignment.center,
          ),
        ),
      );

  Widget buildColorPicker({required int value, required Function(Color) onColorChanged}) =>
      ColorPicker(
          pickerColor: Color(value),
          labelTypes: const [],
          enableAlpha: false,
          onColorChanged: onColorChanged);

  String getFontFamily({required String state}) {
    switch (state) {
      case FontAssets.hacenTunisia:
        return FontFamily.hacenTunisia;
      case FontAssets.helveticaWorld:
        return FontFamily.helveticaWorld;
      case FontAssets.bonaNova:
        return FontFamily.bonaNova;
      case FontAssets.mansalva:
        return FontFamily.mansalva;
      case FontAssets.openSans:
        return FontFamily.openSans;
      case FontAssets.eBGaramond:
        return FontFamily.eBGaramond;
      case FontAssets.gFSDidot:
        return FontFamily.gFSDidot;
      default:
        return FontFamily.hacenTunisia;
    }
  }

  bool isSupportArabic(String font) {
    if (font == FontFamily.hacenTunisia ||
        font == FontFamily.helveticaWorld ||
        font == FontFamily.bonaNova) {
      return true;
    } else {
      return false;
    }
  }

  bool isSupportEnglish(String font) {
    if (font == FontFamily.hacenTunisia ||
        font == FontFamily.helveticaWorld ||
        font == FontFamily.bonaNova ||
        font == FontFamily.mansalva ||
        font == FontFamily.openSans ||
        font == FontFamily.eBGaramond ||
        font == FontFamily.gFSDidot) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    _myController.map((controller) => controller.dispose());
    super.dispose();
  }
}
