import '../../../../../../domain/models/models.dart';
import '../../../../../resources/values_manager.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../../../resources/constants_manager.dart';

const double width = 13.6 * PdfPageFormat.cm;
const double width1 = 13.0 * PdfPageFormat.cm;
const double height = 29.0 * PdfPageFormat.cm;

pw.Container collegeEnRightColumn(
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
          crossAxisAlignment: pw.CrossAxisAlignment.start,
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
          alignment: pw.Alignment.topLeft,
          child: pw.Text(
            cvfile.fullName,
            style: pw.TextStyle(
                font: ttf, fontSize: cvFormat.fullNameFontSize, fontWeight: pw.FontWeight.bold),
          ),
        ),
        pw.Align(
          alignment: pw.Alignment.topLeft,
          child: pw.Text(cvfile.profile, style: const pw.TextStyle(color: PdfColors.grey800)),
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
            alignment: const pw.Alignment(-0.8, 0),
            child: pw.Text(
              AppConstants.workExperienceEnglish,
              style: pw.TextStyle(font: ttf, fontSize: 20, fontWeight: pw.FontWeight.bold),
            )),
        pw.Divider(),
        pw.Align(
          alignment: pw.Alignment.topLeft,
          child: pw.Text(
            cvfile.workExperience,
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
      height: cvFormat.educationalQualificationsLines * PdfPageFormat.cm, //height3,
      child: pw.Column(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
        pw.Align(
            alignment: const pw.Alignment(-0.7, 0),
            child: pw.Text(
              AppConstants.educationalQualificationsEnglish,
              style: pw.TextStyle(font: ttf, fontSize: 20, fontWeight: pw.FontWeight.bold),
            )),
        pw.Divider(),
        pw.Align(
          alignment: pw.Alignment.topLeft,
          child: pw.Text(
            cvfile.educationalQualifications,
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
    height: cvFormat.personalExperienceAndSkillsLines * PdfPageFormat.cm, //height4,
    child: pw.Column(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
      pw.Align(
          alignment: const pw.Alignment(-0.6, 0),
          child: pw.Text(
            AppConstants.personalExperienceAndSkillsEnglish,
            style: pw.TextStyle(font: ttf, fontSize: 20, fontWeight: pw.FontWeight.bold),
          )),
      pw.Divider(),
      pw.Align(
        alignment: pw.Alignment.topLeft,
        child: pw.Text(
          cvfile.personalExperienceAndSkills,
        ),
      ),
    ]),
  );
}
