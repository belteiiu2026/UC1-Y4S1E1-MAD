
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileStorageManager {

  String fileName = "book.txt";
  static final FileStorageManager instance = FileStorageManager._init();
  FileStorageManager._init();

  Future<void> initFileStorage() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    String path = appDocDir.path;
    File file = File('$path/$fileName');
    if(await file.exists() == false){
      await file.create(recursive: true);
    }
  }

  Future<void> saveToFileStorage(String data) async {
    final appDocDir = await getApplicationDocumentsDirectory();
    String path = appDocDir.path;
    File file = File('$path/$fileName');
    await file.writeAsString("$data\n", mode: FileMode.append);
  }

  Future<List<String>> readFromFileStorage() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    String path = appDocDir.path;
    File file = File('$path/$fileName');
    return file.readAsLines();
  }
}