import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../../../domain/models/models.dart';

const double width = 20.0 * PdfPageFormat.cm;
const double width1 = 4.0 * PdfPageFormat.cm;
const double width2 = 14.5 * PdfPageFormat.cm;
const double width3 = 14.5 * PdfPageFormat.cm;
const double widthInfo = 7 * PdfPageFormat.cm;

///////////////////////////////////////////////////
const double height = 6.0 * PdfPageFormat.cm;
const double height1 = 5.5 * PdfPageFormat.cm;
const double height2 = 3.0 * PdfPageFormat.cm;
const double height3 = 2.5 * PdfPageFormat.cm;

//////////////////////////////////////////////////
const double widthPhoto = 4.0 * PdfPageFormat.cm;
const double heightPhoto = 4.0 * PdfPageFormat.cm;

pw.Container skillEnTopRow(
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
    padding: const pw.EdgeInsets.only(
      top: 0.2 * PdfPageFormat.cm,
      bottom: 0.2 * PdfPageFormat.cm,
    ),
    child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.center,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        buildImage(image, cvfile, pdfFontColor, icon2),
        ///////////////////////////////////////////////
        pw.SizedBox(width: 0.4 * PdfPageFormat.cm),
        ////////////////////////////////////////////////
        pw.VerticalDivider(color: pdfFontColor),
        /////////////////////////////////////////////////
        pw.SizedBox(width: 0.4 * PdfPageFormat.cm),
        //////////////////////////////////////////////////
        pw.Column(
          mainAxisAlignment: pw.MainAxisAlignment.start,
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            buildFullName(ttf, cvfile, cvFormat, pdfFontColor),
            // ///////////////////////////////////
            buildPersonalInformation(ttf, icon1, icon2, cvfile, pdfFontColor),
          ],
        ),
      ],
    ),
  );
}

pw.SizedBox buildImage(
  Uint8List image,
  Cvfile cvfile,
  PdfColor pdfFontColor,
  pw.Font icon,
) {
  return pw.SizedBox(
      width: width1,
      height: height1,
      child: pw.Column(
          mainAxisAlignment: pw.MainAxisAlignment.start,
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.ClipOval(
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
            pw.SizedBox(height: 0.4 * PdfPageFormat.cm),
            pw.SizedBox(
              width: width1,
              child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Icon(
                        const pw.IconData(
                          0xE87D,
                        ),
                        color: pdfFontColor,
                        font: icon),
                    pw.Text(
                      cvfile.ageAndMaritalStatus,
                      style: pw.TextStyle(
                        color: pdfFontColor,
                      ),
                    ),
                  ]),
            )
          ]));
}

pw.SizedBox buildFullName(
  pw.Font ttf,
  Cvfile cvfile,
  CvFormat cvFormat,
  PdfColor pdfFontColor,
) {
  return pw.SizedBox(
    width: width2,
    height: height2,
    child: pw.Align(
      alignment: pw.Alignment.topLeft,
      child: pw.Text(
        cvfile.fullName,
        style: pw.TextStyle(
            font: ttf,
            fontSize: cvFormat.fullNameFontSize,
            fontWeight: pw.FontWeight.bold,
            color: pdfFontColor),
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
    width: width3,
    height: height3,
    child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.start,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(
          width: widthInfo,
          height: height3,
          child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
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
                pw.SizedBox(height: 0.5 * PdfPageFormat.cm),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
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
              ]),
        ),
        pw.SizedBox(
          width: widthInfo,
          height: height3,
          child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Icon(
                        const pw.IconData(
                          0xED42,
                        ),
                        font: icon1,
                        color: pdfFontColor,
                      ),
                      pw.Text(
                        cvfile.homeAdress,
                        style: pw.TextStyle(
                          color: pdfFontColor,
                        ),
                      ),
                    ]),
                pw.SizedBox(height: 0.5 * PdfPageFormat.cm),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Icon(
                      const pw.IconData(
                        0xE87D,
                      ),
                      color: pdfFontColor,
                      font: icon2,
                    ),
                    pw.Text(
                      cvfile.website,
                      style: pw.TextStyle(
                        color: pdfFontColor,
                      ),
                    ),
                  ],
                ),
              ]),
        ),
      ],
    ),
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
