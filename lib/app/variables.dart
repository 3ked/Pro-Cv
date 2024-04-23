import '../domain/models/models.dart';
import 'package:flutter/material.dart';
import '../presentation/resources/constants_manager.dart';
import '../presentation/resources/strings_manager.dart';

List<String> certificateList = const [
  AppConstants.arCollegeDegree,
  AppConstants.arHighSchool,
  AppConstants.arSkillbased,
  AppConstants.enCollegeDegree,
  AppConstants.enHighSchool,
  AppConstants.enSkillbased,
];
///////////////////////////////////////////////////////////////
List<Item> cvCollegeDegree = [
  Item(header: AppStrings.fullName, body: fullNameSections),
  Item(header: AppStrings.personalInformation, body: personalInformationSections),
  Item(header: AppStrings.languages, body: languagesSections),
  Item(header: AppStrings.achievements, body: achievementsSections),
  Item(header: AppStrings.interestsAndHobbies, body: interestsAndHobbiesSections),
  Item(header: AppStrings.workExperience, body: workExperienceSections),
  Item(header: AppStrings.educationalQualifications, body: educationalQualificationsSections),
  Item(header: AppStrings.personalExperienceAndSkills, body: personalExperienceAndSkillsSections)
];
///////////////////////////////////////////////////////////////
List<Item> cvHighSchool = [
  Item(header: AppStrings.fullName, body: fullNameSections),
  Item(header: AppStrings.personalInformation, body: personalInformationSections),
  Item(header: AppStrings.educationalQualifications, body: educationalQualificationsSections),
  Item(header: AppStrings.languages, body: languagesSections),
  Item(header: AppStrings.personalExperienceAndSkills, body: personalExperienceAndSkillsSections),
  Item(header: AppStrings.interestsAndHobbies, body: interestsAndHobbiesSections),
];
///////////////////////////////////////////////////////////////
List<Item> cvSkillBased = [
  Item(header: AppStrings.fullName, body: fullNameSections),
  Item(header: AppStrings.personalInformation, body: personalInformationSections),
  Item(header: AppStrings.personalExperienceAndSkills, body: personalExperienceAndSkillsSections),
  Item(header: AppStrings.languages, body: languagesSections),
  Item(header: AppStrings.interestsAndHobbies, body: interestsAndHobbiesSections),
];

///////////////////////////////////////////////////////////////////////////////////
List<Section> fullNameSections = [
  Section(
    textInputType: TextInputType.text,
    hintText: AppStrings.fullName,
    labelText: AppStrings.fullName,
  ),
  Section(
    textInputType: TextInputType.multiline,
    hintText: AppStrings.profile,
    labelText: AppStrings.profile,
    maxLines: 4,
  ),
];
//////////////////////////////////////////////////////////////////
List<Section> personalInformationSections = [
  Section(
    textInputType: TextInputType.number,
    hintText: AppStrings.phoneNumber,
    labelText: AppStrings.phoneNumber,
  ),
  Section(
    textInputType: TextInputType.emailAddress,
    hintText: AppStrings.email,
    labelText: AppStrings.email,
  ),
  Section(
    textInputType: TextInputType.url,
    hintText: AppStrings.website,
    labelText: AppStrings.website,
  ),
  Section(
    textInputType: TextInputType.streetAddress,
    hintText: AppStrings.homeAdress,
    labelText: AppStrings.homeAdress,
  ),
  Section(
    textInputType: TextInputType.multiline,
    hintText: AppStrings.ageAndMaritalStatus,
    labelText: AppStrings.ageAndMaritalStatus,
  )
];
///////////////////////////////////////////////////////////////
Section languagesSections = Section(
  textInputType: TextInputType.multiline,
  hintText: AppStrings.languages,
  labelText: AppStrings.languages,
  maxLines: 4,
);
/////////////////////////////////////////////////////////
Section achievementsSections = Section(
  textInputType: TextInputType.multiline,
  hintText: AppStrings.achievements,
  labelText: AppStrings.achievements,
  maxLines: 4,
);
//////////////////////////////////////////////////////////////////
Section interestsAndHobbiesSections = Section(
  textInputType: TextInputType.multiline,
  hintText: AppStrings.interestsAndHobbies,
  labelText: AppStrings.interestsAndHobbies,
  maxLines: 4,
);
//////////////////////////////////////////////////////////////
Section workExperienceSections = Section(
  textInputType: TextInputType.multiline,
  hintText: AppStrings.workExperience,
  labelText: AppStrings.workExperience,
  maxLines: 4,
);
//////////////////////////////
Section educationalQualificationsSections = Section(
  textInputType: TextInputType.multiline,
  hintText: AppStrings.educationalQualifications,
  labelText: AppStrings.educationalQualifications,
  maxLines: 4,
);
///////////////////////////////////////////////////////////////////
Section personalExperienceAndSkillsSections = Section(
  textInputType: TextInputType.multiline,
  hintText: AppStrings.personalExperienceAndSkills,
  labelText: AppStrings.personalExperienceAndSkills,
  maxLines: 4,
);
