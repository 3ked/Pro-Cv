import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import '../../../../../../domain/models/models.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../../../resources/constants_manager.dart';

const double width = 6.0 * PdfPageFormat.cm;
const double width1 = 5.5 * PdfPageFormat.cm;
const double widthPhoto = 4.0 * PdfPageFormat.cm;
const double heightPhoto = 4.0 * PdfPageFormat.cm;

const double height = 29.0 * PdfPageFormat.cm;
const double height1 = 6.0 * PdfPageFormat.cm;
const double height2 = 6.0 * PdfPageFormat.cm;

pw.Container collegeEnLeftColumn(
  Uint8List image,
  pw.Font ttf,
  pw.Font icon1,
  pw.Font icon2,
  Cvfile cvfile,
  CvFormat cvFormat,
  PdfColor pdfPageColor,
  PdfColor pdfFontColor,
) {
  return pw.Container(
      width: width,
      height: height,
      color: pdfPageColor,
      padding: const pw.EdgeInsets.only(top: 0.2 * PdfPageFormat.cm),
      child: pw.Column(
          mainAxisAlignment: pw.MainAxisAlignment.start,
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            buildImage(image, cvfile),
            //////////////////////////////////////////////////
            buildPersonalInformation(ttf, icon1, icon2, cvfile, pdfFontColor),
            ///////////////////////////////////////////////////////////////////
            buildLanguages(ttf, cvfile, cvFormat, pdfFontColor),
            ///////////////////////////////////////////
            buildAchievements(ttf, cvfile, cvFormat, pdfFontColor),
            ////////////////////////////////////////////////
            buildInterestsAndHobbies(ttf, cvfile, cvFormat, pdfFontColor),
          ]));
}

pw.Container buildImage(Uint8List image, Cvfile cvfile) {
  return pw.Container(
    width: width1,
    height: height1,
    child: pw.ClipOval(
      child: cvfile.image.isNotEmpty
          ? pw.Image(
              pw.MemoryImage(isFile(cvfile)
                  ? base64Decode(cvfile.image)
                  : File(cvfile.image).readAsBytesSync()),
              fit: pw.BoxFit.contain,
              height: heightPhoto,
              width: widthPhoto,
            )
          : pw.Image(
              pw.MemoryImage(image),
              height: heightPhoto,
              width: widthPhoto,
            ),
    ),
  );
}

pw.SizedBox buildPersonalInformation(
  pw.Font ttf,
  pw.Font icon1,
  pw.Font icon2,
  Cvfile cvfile,
  PdfColor pdfFontColor,
) {
  return pw.SizedBox(
      width: width1,
      height: height2,
      child: pw.Column(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
        pw.Center(
            child: pw.Text(
          AppConstants.personalInformationEnglish,
          style: pw.TextStyle(
              font: ttf, color: pdfFontColor, fontSize: 15, fontWeight: pw.FontWeight.bold),
        )),
        pw.Divider(color: pdfFontColor),
        pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
          pw.Icon(
            const pw.IconData(
              0xEC8A,
            ),
            font: icon1,
            color: pdfFontColor,
          ),
          pw.Text(cvfile.phoneNumber,
              style: pw.TextStyle(
                color: pdfFontColor,
              )),
        ]),
        pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
          pw.Icon(
            const pw.IconData(
              0xE0BE,
            ),
            font: icon2,
            color: pdfFontColor,
          ),
          pw.Text(cvfile.emailAddress,
              style: pw.TextStyle(
                color: pdfFontColor,
              )),
        ]),
        pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
          pw.Icon(
              const pw.IconData(
                0xE894,
              ),
              color: pdfFontColor,
              font: icon2),
          pw.Text(cvfile.website,
              style: pw.TextStyle(
                color: pdfFontColor,
              )),
        ]),
        pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
          pw.Icon(
            const pw.IconData(
              0xED42,
            ),
            font: icon1,
            color: pdfFontColor,
          ),
          pw.Text(
            cvfile.homeAdress,
            textDirection: pw.TextDirection.rtl,
            style: pw.TextStyle(
              color: pdfFontColor,
            ),
          ),
        ]),
        pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
          pw.Icon(
              const pw.IconData(
                0xE87D,
              ),
              color: pdfFontColor,
              font: icon2),
          pw.Text(
            cvfile.ageAndMaritalStatus,
            style: pw.TextStyle(
              color: pdfFontColor,
            ),
          ),
        ]),
      ]));
}

pw.SizedBox buildLanguages(
  pw.Font ttf,
  Cvfile cvfile,
  CvFormat cvFormat,
  PdfColor pdfFontColor,
) {
  return pw.SizedBox(
      width: width1,
      height: cvFormat.languagesLines * PdfPageFormat.cm,
      child: pw.Column(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
        pw.Center(
            child: pw.Text(
          AppConstants.languagesEnglish,
          style: pw.TextStyle(
              font: ttf, fontSize: 15, color: pdfFontColor, fontWeight: pw.FontWeight.bold),
        )),
        pw.Divider(color: pdfFontColor),
        pw.Align(
            alignment: pw.Alignment.topLeft,
            child: pw.Text(
              cvfile.languages,
              style: pw.TextStyle(
                color: pdfFontColor,
              ),
            )),
      ]));
}

pw.SizedBox buildAchievements(
  pw.Font ttf,
  Cvfile cvfile,
  CvFormat cvFormat,
  PdfColor pdfFontColor,
) {
  return pw.SizedBox(
      width: width1,
      height: cvFormat.achievementsLines * PdfPageFormat.cm,
      child: pw.Column(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
        pw.Center(
            child: pw.Text(
          AppConstants.achievementsEnglish,
          style: pw.TextStyle(
              font: ttf, color: pdfFontColor, fontSize: 15, fontWeight: pw.FontWeight.bold),
        )),
        pw.Divider(color: pdfFontColor),
        pw.Align(
            alignment: pw.Alignment.topLeft,
            child: pw.Text(
              cvfile.achievements,
              style: pw.TextStyle(
                color: pdfFontColor,
              ),
            )),
      ]));
}

pw.SizedBox buildInterestsAndHobbies(
  pw.Font ttf,
  Cvfile cvfile,
  CvFormat cvFormat,
  PdfColor pdfFontColor,
) {
  return pw.SizedBox(
    width: width1,
    height: cvFormat.interestsAndHobbiesLines * PdfPageFormat.cm,
    child: pw.Column(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
      pw.Center(
          child: pw.Text(
        AppConstants.interestsAndHobbiesEnglish,
        style: pw.TextStyle(
            font: ttf, color: pdfFontColor, fontSize: 15, fontWeight: pw.FontWeight.bold),
      )),
      pw.Divider(color: pdfFontColor),
      pw.Align(
        alignment: pw.Alignment.topLeft,
        child: pw.Text(
          cvfile.interestsAndHobbies,
          style: pw.TextStyle(
            color: pdfFontColor,
          ),
        ),
      )
    ]),
  );
}

bool isFile(Cvfile cvfile) {
  try {
    if (cvfile.image == base64Encode(base64Decode(cvfile.image))) {
      return true;
    }
    return false;
  } catch (_) {
    return false;
  }
}
