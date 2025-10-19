import 'package:universal_io/io.dart';

abstract class JsonStorageService {
  Future<String> get localPath;

  Future<File> getFile(String fileName);

  Future<void> saveData(String fileName, Map<String, dynamic> data);

  Future<Map<String, dynamic>?> loadData(String fileName);

  Future<void> saveList(String fileName, List<Map<String, dynamic>> dataList);

  Future<List<Map<String, dynamic>>> loadList(String fileName);

  Future<void> deleteFile(String fileName);

  Future<bool> fileExists(String fileName);
}
