import '../../../../app/variables.dart';

String buildCertificateSelected(String item, List listItem) {
  switch (listItem.indexOf(item)) {
    case 0:
      return certificateList[0];
    case 1:
      return certificateList[1];
    case 2:
      return certificateList[2];
    case 3:
      return certificateList[3];
    case 4:
      return certificateList[4];
    case 5:
      return certificateList[5];
  }

  return certificateList[0];
}
