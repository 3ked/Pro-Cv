import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../../../domain/models/models.dart';
import '../../../../../resources/constants_manager.dart';
import '../../../../../resources/values_manager.dart';

const double width = 13.6 * PdfPageFormat.cm;
const double width1 = 13.0 * PdfPageFormat.cm;
const double height = 29.0 * PdfPageFormat.cm;

pw.Container collegeArLeftColumn(
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
            buildFullName(ttf, cvfile, cvFormat),
            /////////////////////////////////////////
            buildWorkExperience(ttf, cvfile, cvFormat),
            ///////////////////////////////////////////////
            buildEducationalQualifications(ttf, cvfile, cvFormat),
            //////////////////////////////////////////////////////////
            buildExperienceAndSkills(ttf, cvfile, cvFormat),
          ],
        ),
      ));
}

pw.SizedBox buildFullName(
  pw.Font ttf,
  Cvfile cvfile,
  CvFormat cvFormat,
) {
  return pw.SizedBox(
      width: width1,
      height: cvFormat.profileLine * PdfPageFormat.cm,
      child: pw.Column(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
        pw.Align(
          alignment: pw.Alignment.topRight,
          child: pw.Text(
            cvfile.fullName,
            textDirection: pw.TextDirection.rtl,
            style: pw.TextStyle(
                font: ttf, fontSize: cvFormat.fullNameFontSize, fontWeight: pw.FontWeight.bold),
          ),
        ),
        pw.Align(
          alignment: pw.Alignment.topRight,
          child: pw.Text(
            cvfile.profile,
            style: const pw.TextStyle(color: PdfColors.grey800),
            textDirection: pw.TextDirection.rtl,
          ),
        )
      ]));
}

pw.SizedBox buildWorkExperience(
  pw.Font ttf,
  Cvfile cvfile,
  CvFormat cvFormat,
) {
  return pw.SizedBox(
      width: width1,
      height: cvFormat.workExperienceLines * PdfPageFormat.cm,
      child: pw.Column(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
        pw.Align(
            alignment: const pw.Alignment(0.6, 0),
            child: pw.Text(
              AppConstants.workExperienceArabic,
              textDirection: pw.TextDirection.rtl,
              style: pw.TextStyle(font: ttf, fontSize: 20, fontWeight: pw.FontWeight.bold),
            )),
        pw.Divider(),
        pw.Align(
          alignment: pw.Alignment.centerRight,
          child: pw.Text(
            cvfile.workExperience,
            textDirection: pw.TextDirection.rtl,
          ),
        ),
      ]));
}

pw.SizedBox buildEducationalQualifications(
  pw.Font ttf,
  Cvfile cvfile,
  CvFormat cvFormat,
) {
  return pw.SizedBox(
      width: width1,
      height: cvFormat.educationalQualificationsLines * PdfPageFormat.cm,
      child: pw.Column(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
        pw.Align(
            alignment: const pw.Alignment(0.6, 0),
            child: pw.Text(
              AppConstants.educationalQualificationsArabic,
              textDirection: pw.TextDirection.rtl,
              style: pw.TextStyle(font: ttf, fontSize: 20, fontWeight: pw.FontWeight.bold),
            )),
        pw.Divider(),
        pw.Align(
          alignment: pw.Alignment.centerRight,
          child: pw.Text(
            cvfile.educationalQualifications,
            textDirection: pw.TextDirection.rtl,
          ),
        ),
      ]));
}

pw.SizedBox buildExperienceAndSkills(
  pw.Font ttf,
  Cvfile cvfile,
  CvFormat cvFormat,
) {
  return pw.SizedBox(
    width: width1,
    height: cvFormat.workExperienceLines * PdfPageFormat.cm,
    child: pw.Column(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
      pw.Align(
          alignment: const pw.Alignment(0.6, 0),
          child: pw.Text(
            AppConstants.personalExperienceAndSkillsArabic,
            textDirection: pw.TextDirection.rtl,
            style: pw.TextStyle(font: ttf, fontSize: 20, fontWeight: pw.FontWeight.bold),
          )),
      pw.Divider(),
      pw.Align(
        alignment: pw.Alignment.bottomRight,
        child: pw.Text(
          cvfile.personalExperienceAndSkills,
          textDirection: pw.TextDirection.rtl,
        ),
      ),
    ]),
  );
}
