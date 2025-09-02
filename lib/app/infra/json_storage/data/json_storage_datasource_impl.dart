import 'dart:convert';
import 'package:personal_planner/app/infra/json_storage/constants/directory_path_names.dart';
import 'package:personal_planner/app/infra/json_storage/data/json_storage_datasource.dart';
import 'package:personal_planner/app/shared/error/exception.dart';
import 'package:universal_io/io.dart';
import 'package:path_provider/path_provider.dart';

class JsonStorageServiceImpl implements JsonStorageService {
  @override
  Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/${DirectoryPathNames.basePath}';
  }

  @override
  Future<File> getFile(String fileName) async {
    try {
      final path = await localPath;
      return File('$path/$fileName.json');
    } catch (e) {
      throw FileNotFoundException();
    }
  }

  @override
  Future<void> saveData(String fileName, Map<String, dynamic> data) async {
    try {
      final file = await getFile(fileName);
      final jsonString = jsonEncode(data);
      await file.writeAsString(jsonString);
    } catch (e) {
      throw LocalStorageException();
    }
  }

  @override
  Future<Map<String, dynamic>?> loadData(String fileName) async {
    try {
      final file = await getFile(fileName);
      final exists = await file.exists();

      if (!exists) {
        return null;
      }

      final jsonString = await file.readAsString();
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      throw DataParsingException();
    }
  }

  @override
  Future<void> saveList(
    String fileName,
    List<Map<String, dynamic>> dataList,
  ) async {
    final file = await getFile(fileName);
    final exists = await file.exists();

    if (!exists) {
      throw FileNotFoundException();
    }

    try {
      final jsonString = jsonEncode(dataList);
      await file.writeAsString(jsonString);
    } catch (e) {
      throw Exception('Error saving list: $e');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> loadList(String fileName) async {
    final file = await getFile(fileName);
    final exists = await file.exists();

    if (!exists) {
      throw FileNotFoundException();
    }

    try {
      final jsonString = await file.readAsString();
      final decoded = jsonDecode(jsonString);
      return List<Map<String, dynamic>>.from(decoded);
    } catch (e) {
      throw Exception('Error loading list: $e');
    }
  }

  @override
  Future<void> deleteFile(String fileName) async {
    final file = await getFile(fileName);
    final exists = await file.exists();

    if (!exists) {
      throw FileNotFoundException();
    }

    try {
      await file.delete();
    } catch (e) {
      throw LocalStorageException();
    }
  }

  @override
  Future<bool> fileExists(String fileName) async {
    try {
      final file = await getFile(fileName);
      return await file.exists();
    } catch (e) {
      return false;
    }
  }
}
