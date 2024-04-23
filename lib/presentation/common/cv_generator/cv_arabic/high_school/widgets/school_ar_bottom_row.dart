import '../../../../../../domain/models/models.dart';
import '../../../../../resources/values_manager.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../../../resources/constants_manager.dart';

const double width = 20.0 * PdfPageFormat.cm;
const double width1 = 19.0 * PdfPageFormat.cm;
//////////////////////////////////////////////
const double height = 23.0 * PdfPageFormat.cm;

pw.Container schoolArBottomRow(
  pw.Font ttf,
  Cvfile cvfile,
  CvFormat cvFormat,
) {
  return pw.Container(
      color: PdfColors.white,
      width: width,
      height: height,
      child: pw.Padding(
        padding: pw.EdgeInsets.all(AppPadding.p8SP),
        child: pw.Column(
          mainAxisAlignment: pw.MainAxisAlignment.start,
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            buildProfile(ttf, cvfile, cvFormat),
            /////////////////////////////////////////////
            buildEducationalQualifications(ttf, cvfile, cvFormat),
            ///////////////////////////////////////////////
            buildLanguages(ttf, cvfile, cvFormat),
            ///////////////////////////////////////////////
            buildExperienceAndSkills(ttf, cvfile, cvFormat),
            ///////////////////////////////////////////////
            buildInterestsAndHobbies(ttf, cvfile, cvFormat),
          ],
        ),
      ));
}

pw.SizedBox buildProfile(pw.Font ttf, Cvfile cvfile, CvFormat cvFormat) {
  return pw.SizedBox(
    width: width1,
    height: cvFormat.profileLine * PdfPageFormat.cm,
    child: pw.Column(
        mainAxisAlignment: pw.MainAxisAlignment.start,
        crossAxisAlignment: pw.CrossAxisAlignment.end,
        children: [
          pw.Align(
            alignment: const pw.Alignment(0.9, 0),
            child: pw.Text(
              AppConstants.profileArabic,
              textDirection: pw.TextDirection.rtl,
              style: pw.TextStyle(font: ttf, fontSize: 20, fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.Divider(color: PdfColors.black),
          pw.Align(
            alignment: pw.Alignment.topRight,
            child: pw.Text(
              cvfile.profile,
              style: const pw.TextStyle(
                color: PdfColors.black,
              ),
              textDirection: pw.TextDirection.rtl,
            ),
          )
        ]),
  );
}

pw.SizedBox buildEducationalQualifications(pw.Font ttf, Cvfile cvfile, CvFormat cvFormat) {
  return pw.SizedBox(
    width: width1,
    height: cvFormat.educationalQualificationsLines * PdfPageFormat.cm,
    child: pw.Column(
      mainAxisAlignment: pw.MainAxisAlignment.start,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Align(
            alignment: const pw.Alignment(0.9, 0),
            child: pw.Text(
              AppConstants.educationalQualificationsArabic,
              textDirection: pw.TextDirection.rtl,
              style: pw.TextStyle(font: ttf, fontSize: 20, fontWeight: pw.FontWeight.bold),
            )),
        pw.Divider(color: PdfColors.black),
        pw.Align(
          alignment: pw.Alignment.centerRight,
          child: pw.Text(
            cvfile.educationalQualifications,
            textDirection: pw.TextDirection.rtl,
          ),
        ),
      ],
    ),
  );
}

pw.SizedBox buildLanguages(pw.Font ttf, Cvfile cvfile, CvFormat cvFormat) {
  return pw.SizedBox(
    width: width1,
    height: cvFormat.languagesLines * PdfPageFormat.cm,
    child: pw.Column(
      mainAxisAlignment: pw.MainAxisAlignment.start,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Align(
          alignment: const pw.Alignment(0.9, 0),
          child: pw.Text(
            AppConstants.languagesArabic,
            textDirection: pw.TextDirection.rtl,
            style: pw.TextStyle(font: ttf, fontSize: 20, fontWeight: pw.FontWeight.bold),
          ),
        ),
        pw.Divider(color: PdfColors.black),
        pw.Text(
          cvfile.languages,
          style: const pw.TextStyle(
            color: PdfColors.black,
          ),
          textDirection: pw.TextDirection.rtl,
        )
      ],
    ),
  );
}

pw.SizedBox buildExperienceAndSkills(pw.Font ttf, Cvfile cvfile, CvFormat cvFormat) {
  return pw.SizedBox(
    width: width1,
    height: cvFormat.personalExperienceAndSkillsLines * PdfPageFormat.cm,
    child: pw.Column(
      mainAxisAlignment: pw.MainAxisAlignment.start,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Align(
            alignment: const pw.Alignment(0.9, 0),
            child: pw.Text(
              AppConstants.personalExperienceAndSkillsArabic,
              textDirection: pw.TextDirection.rtl,
              style: pw.TextStyle(font: ttf, fontSize: 20, fontWeight: pw.FontWeight.bold),
            )),
        pw.Divider(color: PdfColors.black),
        pw.Align(
          alignment: pw.Alignment.topRight,
          child: pw.Text(
            cvfile.personalExperienceAndSkills,
            textDirection: pw.TextDirection.rtl,
          ),
        ),
      ],
    ),
  );
}

pw.SizedBox buildInterestsAndHobbies(pw.Font ttf, Cvfile cvfile, CvFormat cvFormat) {
  return pw.SizedBox(
    width: width1,
    height: cvFormat.interestsAndHobbiesLines * PdfPageFormat.cm,
    child: pw.Column(
        mainAxisAlignment: pw.MainAxisAlignment.start,
        crossAxisAlignment: pw.CrossAxisAlignment.end,
        children: [
          pw.Align(
            alignment: const pw.Alignment(0.9, 0),
            child: pw.Text(
              AppConstants.interestsAndHobbiesArabic,
              textDirection: pw.TextDirection.rtl,
              style: pw.TextStyle(font: ttf, fontSize: 20, fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.Divider(color: PdfColors.black),
          pw.Align(
            alignment: pw.Alignment.topRight,
            child: pw.Text(
              cvfile.interestsAndHobbies,
              style: const pw.TextStyle(
                color: PdfColors.black,
              ),
              textDirection: pw.TextDirection.rtl,
            ),
          )
        ]),
  );
}
