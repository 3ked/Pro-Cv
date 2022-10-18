import 'dart:typed_data';
import '../../../../../domain/models/models.dart';
import 'widgets/college_en_left_column.dart';
import 'widgets/college_en_right_column.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Stack cvEnCollegeDegree(
  pw.Font ttf,
  Uint8List image,
  pw.Font myIcon,
  pw.Font ttfIcon,
  Cvfile cvfile,
  CvFormat cvFormat,
  PdfColor pdfPageColor,
  PdfColor pdfFontColor,
) {
  return pw.Stack(
    children: [
      pw.Container(
        color: pdfPageColor,
        width: 21.0 * PdfPageFormat.cm,
        height: 30.0 * PdfPageFormat.cm,
      ),
      pw.Positioned(
          top: 0.5 * PdfPageFormat.cm,
          left: 0.5 * PdfPageFormat.cm,
          child: pw.Container(
            width: 20.0 * PdfPageFormat.cm,
            height: 29.0 * PdfPageFormat.cm,
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Padding(
                    padding: const pw.EdgeInsets.only(right: 0.4 * PdfPageFormat.cm),
                    child: collegeEnLeftColumn(
                        image, ttf, myIcon, ttfIcon, cvfile, cvFormat, pdfPageColor, pdfFontColor)),
                collegeEnRightColumn(ttf, cvfile, cvFormat),
              ],
            ),
          )),
    ],
  );
}
