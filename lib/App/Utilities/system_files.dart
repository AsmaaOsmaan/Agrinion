import 'dart:io';

import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

class SystemFileManager {
  static Future<File?> convertResponseToFile(response,
      [dynamic fileName]) async {
    try {
      final appStorage = await getApplicationDocumentsDirectory();
      final file = File('${appStorage.path}/$fileName.pdf');
      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response);
      await raf.close();
      return file;
    } on Exception {
      return null;
    }
  }

  static Future<void> openFile(File? file) async {
    OpenFilex.open(file!.path);
  }
}
