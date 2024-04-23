import '../../../../../../domain/models/models.dart';
import '../../../../../resources/values_manager.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../../../resources/constants_manager.dart';

const double width = 20.0 * PdfPageFormat.cm;
const double width1 = 19.0 * PdfPageFormat.cm;
//////////////////////////////////////////////
const double height = 23.0 * PdfPageFormat.cm;
// const double height1 = 4.0 * PdfPageFormat.cm;
// const double height2 = 4.0 * PdfPageFormat.cm;
// const double height3 = 4.0 * PdfPageFormat.cm;
// const double height4 = 5.0 * PdfPageFormat.cm;
// const double height5 = 4.0 * PdfPageFormat.cm;

pw.Container schoolEnBottomRow(
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
            buildProfile(ttf, cvfile, cvFormat),
            //////////////////////////////////////////////
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

pw.SizedBox buildProfile(
  pw.Font ttf,
  Cvfile cvfile,
  CvFormat cvFormat,
) {
  return pw.SizedBox(
    width: width1,
    height: cvFormat.profileLine * PdfPageFormat.cm,
    child: pw.Column(
        mainAxisAlignment: pw.MainAxisAlignment.start,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Align(
            alignment: const pw.Alignment(-0.9, 0),
            child: pw.Text(
              AppConstants.profileEnglish,
              style: pw.TextStyle(font: ttf, fontSize: 20, fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.Divider(color: PdfColors.black),
          pw.Align(
            alignment: pw.Alignment.topLeft,
            child: pw.Text(
              cvfile.profile,
              style: const pw.TextStyle(
                color: PdfColors.black,
              ),
            ),
          )
        ]),
  );
}

pw.SizedBox buildEducationalQualifications(
  pw.Font ttf,
  Cvfile cvfile,
  CvFormat cvFormat,
) {
  return pw.SizedBox(
    width: width1,
    height: cvFormat.educationalQualificationsLines * PdfPageFormat.cm,
    child: pw.Column(
      mainAxisAlignment: pw.MainAxisAlignment.start,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Align(
            alignment: const pw.Alignment(-0.9, 0),
            child: pw.Text(
              AppConstants.educationalQualificationsEnglish,
              style: pw.TextStyle(font: ttf, fontSize: 20, fontWeight: pw.FontWeight.bold),
            )),
        pw.Divider(color: PdfColors.black),
        pw.Align(
          alignment: pw.Alignment.topLeft,
          child: pw.Text(
            cvfile.educationalQualifications,
          ),
        ),
      ],
    ),
  );
}

pw.SizedBox buildLanguages(
  pw.Font ttf,
  Cvfile cvfile,
  CvFormat cvFormat,
) {
  return pw.SizedBox(
    width: width1,
    height: cvFormat.languagesLines * PdfPageFormat.cm,
    child: pw.Column(
      mainAxisAlignment: pw.MainAxisAlignment.start,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Align(
          alignment: const pw.Alignment(-0.9, 0),
          child: pw.Text(
            AppConstants.languagesEnglish,
            style: pw.TextStyle(font: ttf, fontSize: 20, fontWeight: pw.FontWeight.bold),
          ),
        ),
        pw.Divider(color: PdfColors.black),
        pw.Text(
          cvfile.languages,
          style: const pw.TextStyle(
            color: PdfColors.black,
          ),
        )
      ],
    ),
  );
}

pw.SizedBox buildExperienceAndSkills(
  pw.Font ttf,
  Cvfile cvfile,
  CvFormat cvFormat,
) {
  return pw.SizedBox(
    width: width1,
    height: cvFormat.personalExperienceAndSkillsLines * PdfPageFormat.cm,
    child: pw.Column(
      mainAxisAlignment: pw.MainAxisAlignment.start,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Align(
            alignment: const pw.Alignment(-0.9, 0),
            child: pw.Text(
              AppConstants.personalExperienceAndSkillsEnglish,
              style: pw.TextStyle(font: ttf, fontSize: 20, fontWeight: pw.FontWeight.bold),
            )),
        pw.Divider(color: PdfColors.black),
        pw.Align(
          alignment: pw.Alignment.topLeft,
          child: pw.Text(
            cvfile.personalExperienceAndSkills,
          ),
        ),
      ],
    ),
  );
}

pw.SizedBox buildInterestsAndHobbies(
  pw.Font ttf,
  Cvfile cvfile,
  CvFormat cvFormat,
) {
  return pw.SizedBox(
    width: width1,
    height: cvFormat.interestsAndHobbiesLines * PdfPageFormat.cm,
    child: pw.Column(
        mainAxisAlignment: pw.MainAxisAlignment.start,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Align(
            alignment: const pw.Alignment(-0.9, 0),
            child: pw.Text(
              AppConstants.interestsAndHobbiesEnglish,
              style: pw.TextStyle(font: ttf, fontSize: 20, fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.Divider(color: PdfColors.black),
          pw.Align(
            alignment: pw.Alignment.topLeft,
            child: pw.Text(
              cvfile.interestsAndHobbies,
              style: const pw.TextStyle(
                color: PdfColors.black,
              ),
            ),
          )
        ]),
  );
}
