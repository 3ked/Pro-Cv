import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_manager/file_manager.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../data/data_source/local_data_source.dart';
import '../../../resources/strings_manager.dart';
import '../../../widgets/show_snack_bar.dart';

void buildDialogPdfName({
  required BuildContext contextPage,
  required pw.Document pdf,
}) async {
  String? cvName;
  showDialog(
      context: contextPage,
      builder: (BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: AlertDialog(
            title: Text(AppStrings.addName.tr()),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  onChanged: (fileName) => cvName = fileName,
                  decoration: InputDecoration(
                    hintText: AppStrings.pdfName.tr(),
                    labelText: AppStrings.pdfName.tr(),
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (cvName != null) {
                        Directory dir = await LocalDataSourceImpl().getLocalPath;
                        List<FileSystemEntity> entities = dir.listSync();
                        for (int i = 0; i < entities.length; i++) {
                          if (FileManager.basename(entities[i], false) == "$cvName.pdf") {
                            FocusManager.instance.primaryFocus?.unfocus();
                            showSnackBar(contextPage, AppStrings.changeName);
                            return;
                          }
                        }
                        Navigator.pop(context);
                        await LocalDataSourceImpl().saveFile(cvName!, pdf);
                        showSnackBar(contextPage, AppStrings.saveDone);
                      }
                    },
                    child: Text(AppStrings.ok.tr()))
              ],
            ),
          ),
        );
      });
}
