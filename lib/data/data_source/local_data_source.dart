import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

abstract class LocalDataSource {
  Future createFolder();
  Future<File> saveDocument({required pw.Document pdf});
  Future saveFile(String fileName, pw.Document pdf);
  Future<bool> requestPermission(Permission permissions);
  Future<Directory> get getLocalPath;
}

class LocalDataSourceImpl implements LocalDataSource {
  @override
  Future createFolder() async {
    if (await requestPermission(Permission.storage)) {
      Directory directory = await getLocalPath;
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
    }
  }

  @override
  Future<File?> saveFile(String fileName, pw.Document pdf) async {
    if (await requestPermission(Permission.storage)) {
      Directory directory = await getLocalPath;
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
        final file = File('${directory.path}/$fileName.pdf');

        final pdfFile = await file.writeAsBytes(await pdf.save());

        return pdfFile;
      }
    }
    return null;
  }

  @override
  Future<bool> requestPermission(Permission permissions) async {
    if (await permissions.isGranted) {
      return true;
    } else {
      var result = await permissions.request();
      if (result == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  @override
  Future<Directory> get getLocalPath async {
    Directory? directory = await getExternalStorageDirectory();
    String newPath = "";
    List<String> folders = directory!.path.split("/");

    for (int x = 1; x < folders.length; x++) {
      String folder = folders[x];
      if (folder != "Android") {
        newPath += "/" + folder;
      } else {
        break;
      }
    }
    newPath = newPath + "/Pro CV";
    directory = Directory(newPath);
    return directory;
  }

  @override
  Future<File> saveDocument({required pw.Document pdf}) async {
    final bytes = await pdf.save();
    final dir = await getApplicationDocumentsDirectory();
    final file = File("${dir.path}/example.pdf");
    await file.writeAsBytes(bytes);
    return file;
  }
}
