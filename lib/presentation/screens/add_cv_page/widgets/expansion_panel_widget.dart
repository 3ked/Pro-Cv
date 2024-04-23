import 'package:cv_pdf/presentation/common/logic/cubit/counter/counter_text_cubit.dart';
import 'package:cv_pdf/presentation/common/logic/cubit/cv_format/cv_format_cubit.dart';
import '../../../../domain/models/models.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/values_manager.dart';

ExpansionPanel expansionPanelWidget(
    Item item, BuildContext context, List<TextEditingController> listEditingController) {
  Widget widget;
  switch (item.header) {
    case AppStrings.fullName:
      widget = fullNameBody(
        item.body,
        [
          listEditingController[0],
          listEditingController[1],
        ],
      );
      break;
    case AppStrings.personalInformation:
      widget = informationBody(item.body, [
        listEditingController[2],
        listEditingController[3],
        listEditingController[4],
        listEditingController[5],
        listEditingController[6],
      ]);
      break;
    case AppStrings.languages:
      widget = languagesBody(
        item.body,
        listEditingController[7],
      );
      break;
    case AppStrings.achievements:
      widget = achievementsBody(
        item.body,
        context,
        listEditingController[8],
      );
      break;
    case AppStrings.interestsAndHobbies:
      widget = interestsAndHobbiesBody(
        item.body,
        listEditingController[9],
      );
      break;
    case AppStrings.workExperience:
      widget = workExperienceBody(
        item.body,
        context,
        listEditingController[10],
      );
      break;
    case AppStrings.educationalQualifications:
      widget = educationalQualificationsBody(
        item.body,
        context,
        listEditingController[11],
      );
      break;
    case AppStrings.personalExperienceAndSkills:
      widget = personalExperienceAndSkillsBody(
        item.body,
        listEditingController[12],
      );
      break;
    default:
      widget = Container();
  }
  return ExpansionPanel(
    canTapOnHeader: true,
    isExpanded: item.isExpanded,
    headerBuilder: (context, isOpen) {
      return Text(item.header.tr());
    },
    body: widget,
  );
}

Column fullNameBody(
  List<Section> cvSection,
  List<TextEditingController> controller,
) {
  return Column(
    children: [
      BlocBuilder<CvFormatCubit, CvFormatState>(
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(AppStrings.fontSizeFullName.tr()),
              TextButton(
                  onPressed: () {
                    if (state.cvFormat.fullNameFontSize > 0) {
                      context
                          .read<CvFormatCubit>()
                          .toggleFullNameFontSize(state.cvFormat.fullNameFontSize - 0.5);
                    }
                  },
                  child: const Text("-")),
              Text(state.cvFormat.fullNameFontSize.toString()),
              TextButton(
                  onPressed: () {
                    context
                        .read<CvFormatCubit>()
                        .toggleFullNameFontSize(state.cvFormat.fullNameFontSize + 0.5);
                  },
                  child: const Text("+")),
            ],
          );
        },
      ),
      BlocBuilder<CvFormatCubit, CvFormatState>(
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(AppStrings.numLinesProfile.tr()),
              TextButton(
                  onPressed: () {
                    if (state.cvFormat.profileLine > 0) {
                      context
                          .read<CvFormatCubit>()
                          .toggleProfileLine(state.cvFormat.profileLine - 0.5);
                    }
                  },
                  child: const Text("-")),
              Text(state.cvFormat.profileLine.toString()),
              TextButton(
                  onPressed: () {
                    context
                        .read<CvFormatCubit>()
                        .toggleProfileLine(state.cvFormat.profileLine + 0.5);
                  },
                  child: const Text("+")),
            ],
          );
        },
      ),
      Column(
        children: cvSection
            .map((section) => Padding(
                  padding: EdgeInsets.all(AppPadding.p8SP),
                  child: BlocProvider<CounterTextCubit>(
                    create: (_) => CounterTextCubit(),
                    child: BlocBuilder<CounterTextCubit, int>(
                      builder: (context, state) {
                        return TextFormField(
                          controller: section.hintText == AppStrings.fullName
                              ? controller[0]
                              : controller[1],
                          onChanged: (data) {
                            BlocProvider.of<CounterTextCubit>(context)
                                .numberText(value: data.length);
                          },
                          maxLines: section.maxLines,
                          keyboardType: section.textInputType,
                          decoration: InputDecoration(
                              hintText: section.hintText.tr(),
                              labelText: section.labelText.tr(),
                              counterText: "$state"),
                        );
                      },
                    ),
                  ),
                ))
            .toList(),
      )
    ],
  );
}

Column informationBody(List<Section> cvSection, List<TextEditingController> controller) {
  return Column(
    children: cvSection
        .map((section) => Padding(
            padding: EdgeInsets.all(AppPadding.p8SP),
            child: BlocProvider<CounterTextCubit>(
              create: (_) => CounterTextCubit(),
              child: BlocBuilder<CounterTextCubit, int>(
                builder: (context, state) {
                  return TextFormField(
                    controller: section.hintText == AppStrings.phoneNumber
                        ? controller[0]
                        : section.hintText == AppStrings.email
                            ? controller[1]
                            : section.hintText == AppStrings.website
                                ? controller[2]
                                : section.hintText == AppStrings.homeAdress
                                    ? controller[3]
                                    : controller[4],
                    onChanged: (data) {
                      BlocProvider.of<CounterTextCubit>(context).numberText(value: data.length);
                    },
                    keyboardType: section.textInputType,
                    decoration: InputDecoration(
                        hintText: section.hintText.tr(),
                        labelText: section.labelText.tr(),
                        counterText: "$state"),
                  );
                },
              ),
            )))
        .toList(),
  );
}

Padding languagesBody(
  Section section,
  TextEditingController controller,
) {
  return Padding(
      padding: EdgeInsets.all(AppPadding.p8SP),
      child: Column(
        children: [
          BlocBuilder<CvFormatCubit, CvFormatState>(
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(AppStrings.numLines.tr()),
                  TextButton(
                      onPressed: () {
                        if (state.cvFormat.languagesLines > 0) {
                          context
                              .read<CvFormatCubit>()
                              .toggleLanguagesLines(state.cvFormat.languagesLines - 0.5);
                        }
                      },
                      child: const Text("-")),
                  Text(state.cvFormat.languagesLines.toString()),
                  TextButton(
                      onPressed: () {
                        context
                            .read<CvFormatCubit>()
                            .toggleLanguagesLines(state.cvFormat.languagesLines + 0.5);
                      },
                      child: const Text("+")),
                ],
              );
            },
          ),
          BlocProvider<CounterTextCubit>(
            create: (_) => CounterTextCubit(),
            child: BlocBuilder<CounterTextCubit, int>(
              builder: (context, state) {
                return TextFormField(
                  controller: controller,
                  onChanged: (data) {
                    BlocProvider.of<CounterTextCubit>(context).numberText(value: data.length);
                  },
                  maxLines: section.maxLines,
                  keyboardType: section.textInputType,
                  decoration: InputDecoration(
                      hintText: section.hintText.tr(),
                      labelText: section.labelText.tr(),
                      counterText: "$state"),
                );
              },
            ),
          ),
        ],
      ));
}

Widget achievementsBody(
  Section section,
  BuildContext context,
  TextEditingController controller,
) {
  return Padding(
      padding: EdgeInsets.all(AppPadding.p8SP),
      child: Column(
        children: [
          BlocBuilder<CvFormatCubit, CvFormatState>(
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(AppStrings.numLines.tr()),
                  TextButton(
                      onPressed: () {
                        if (state.cvFormat.achievementsLines > 0) {
                          context
                              .read<CvFormatCubit>()
                              .toggleAchievements(state.cvFormat.achievementsLines - 0.5);
                        }
                      },
                      child: const Text("-")),
                  Text(state.cvFormat.achievementsLines.toString()),
                  TextButton(
                      onPressed: () {
                        context
                            .read<CvFormatCubit>()
                            .toggleAchievements(state.cvFormat.achievementsLines + 0.5);
                      },
                      child: const Text("+")),
                ],
              );
            },
          ),
          BlocProvider<CounterTextCubit>(
            create: (_) => CounterTextCubit(),
            child: BlocBuilder<CounterTextCubit, int>(
              builder: (context, state) {
                return TextFormField(
                  controller: controller,
                  maxLines: section.maxLines,
                  onChanged: (data) {
                    BlocProvider.of<CounterTextCubit>(context).numberText(value: data.length);
                  },
                  keyboardType: section.textInputType,
                  decoration: InputDecoration(
                      hintText: section.hintText.tr(),
                      labelText: section.labelText.tr(),
                      counterText: "$state"),
                );
              },
            ),
          ),
        ],
      ));
}

Padding interestsAndHobbiesBody(
  Section section,
  TextEditingController controller,
) {
  return Padding(
    padding: EdgeInsets.all(AppPadding.p8SP),
    child: BlocProvider<CounterTextCubit>(
        create: (_) => CounterTextCubit(),
        child: Column(
          children: [
            BlocBuilder<CvFormatCubit, CvFormatState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(AppStrings.numLines.tr()),
                    TextButton(
                        onPressed: () {
                          if (state.cvFormat.interestsAndHobbiesLines > 0) {
                            context.read<CvFormatCubit>().toggleInterestsAndHobbiesLines(
                                state.cvFormat.interestsAndHobbiesLines - 0.5);
                          }
                        },
                        child: const Text("-")),
                    Text(state.cvFormat.interestsAndHobbiesLines.toString()),
                    TextButton(
                        onPressed: () {
                          context.read<CvFormatCubit>().toggleInterestsAndHobbiesLines(
                              state.cvFormat.interestsAndHobbiesLines + 0.5);
                        },
                        child: const Text("+")),
                  ],
                );
              },
            ),
            BlocBuilder<CounterTextCubit, int>(
              builder: (context, state) {
                return TextFormField(
                  controller: controller,
                  maxLines: section.maxLines,
                  onChanged: (data) {
                    BlocProvider.of<CounterTextCubit>(context).numberText(value: data.length);
                  },
                  keyboardType: section.textInputType,
                  decoration: InputDecoration(
                      hintText: section.hintText.tr(),
                      labelText: section.labelText.tr(),
                      counterText: "$state"),
                );
              },
            ),
          ],
        )),
  );
}

Padding workExperienceBody(
  Section section,
  BuildContext context,
  TextEditingController controller,
) {
  return Padding(
    padding: EdgeInsets.all(AppPadding.p8SP),
    child: BlocProvider<CounterTextCubit>(
        create: (_) => CounterTextCubit(),
        child: Column(
          children: [
            BlocBuilder<CvFormatCubit, CvFormatState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(AppStrings.numLines.tr()),
                    TextButton(
                        onPressed: () {
                          if (state.cvFormat.workExperienceLines > 0) {
                            context.read<CvFormatCubit>().toggleWorkExperienceLines(
                                state.cvFormat.workExperienceLines - 0.5);
                          }
                        },
                        child: const Text("-")),
                    Text(state.cvFormat.workExperienceLines.toString()),
                    TextButton(
                        onPressed: () {
                          context
                              .read<CvFormatCubit>()
                              .toggleWorkExperienceLines(state.cvFormat.workExperienceLines + 0.5);
                        },
                        child: const Text("+")),
                  ],
                );
              },
            ),
            BlocBuilder<CounterTextCubit, int>(
              builder: (context, state) {
                return TextFormField(
                  controller: controller,
                  maxLines: section.maxLines,
                  onChanged: (data) {
                    BlocProvider.of<CounterTextCubit>(context).numberText(value: data.length);
                  },
                  keyboardType: section.textInputType,
                  decoration: InputDecoration(
                      hintText: section.hintText.tr(),
                      labelText: section.labelText.tr(),
                      counterText: "$state"),
                );
              },
            ),
          ],
        )),
  );
}

Padding educationalQualificationsBody(
  Section section,
  BuildContext context,
  TextEditingController controller,
) {
  return Padding(
    padding: EdgeInsets.all(AppPadding.p8SP),
    child: BlocProvider<CounterTextCubit>(
        create: (_) => CounterTextCubit(),
        child: Column(
          children: [
            BlocBuilder<CvFormatCubit, CvFormatState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(AppStrings.numLines.tr()),
                    TextButton(
                        onPressed: () {
                          if (state.cvFormat.educationalQualificationsLines > 0) {
                            context.read<CvFormatCubit>().toggleEducationalQualificationsLines(
                                state.cvFormat.educationalQualificationsLines - 0.5);
                          }
                        },
                        child: const Text("-")),
                    Text(state.cvFormat.educationalQualificationsLines.toString()),
                    TextButton(
                        onPressed: () {
                          context.read<CvFormatCubit>().toggleEducationalQualificationsLines(
                              state.cvFormat.educationalQualificationsLines + 0.5);
                        },
                        child: const Text("+")),
                  ],
                );
              },
            ),
            BlocBuilder<CounterTextCubit, int>(
              builder: (context, state) {
                return TextFormField(
                  controller: controller,
                  maxLines: section.maxLines,
                  onChanged: (data) {
                    BlocProvider.of<CounterTextCubit>(context).numberText(value: data.length);
                  },
                  keyboardType: section.textInputType,
                  decoration: InputDecoration(
                      hintText: section.hintText.tr(),
                      labelText: section.labelText.tr(),
                      counterText: "$state"),
                );
              },
            ),
          ],
        )),
  );
}

Padding personalExperienceAndSkillsBody(
  Section section,
  TextEditingController controller,
) {
  return Padding(
    padding: EdgeInsets.all(AppPadding.p8SP),
    child: BlocProvider<CounterTextCubit>(
        create: (_) => CounterTextCubit(),
        child: Column(
          children: [
            BlocBuilder<CvFormatCubit, CvFormatState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(AppStrings.numLines.tr()),
                    TextButton(
                        onPressed: () {
                          if (state.cvFormat.personalExperienceAndSkillsLines > 0) {
                            context.read<CvFormatCubit>().togglePersonalExperienceAndSkillsLines(
                                state.cvFormat.personalExperienceAndSkillsLines - 0.5);
                          }
                        },
                        child: const Text("-")),
                    Text(state.cvFormat.personalExperienceAndSkillsLines.toString()),
                    TextButton(
                        onPressed: () {
                          context.read<CvFormatCubit>().togglePersonalExperienceAndSkillsLines(
                              state.cvFormat.personalExperienceAndSkillsLines + 0.5);
                        },
                        child: const Text("+")),
                  ],
                );
              },
            ),
            BlocBuilder<CounterTextCubit, int>(
              builder: (context, state) {
                return TextFormField(
                  controller: controller,
                  maxLines: section.maxLines,
                  onChanged: (data) {
                    BlocProvider.of<CounterTextCubit>(context).numberText(value: data.length);
                  },
                  keyboardType: section.textInputType,
                  decoration: InputDecoration(
                      hintText: section.hintText.tr(),
                      labelText: section.labelText.tr(),
                      counterText: "$state"),
                );
              },
            ),
          ],
        )),
  );
}
