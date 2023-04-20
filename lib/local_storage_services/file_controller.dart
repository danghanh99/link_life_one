import 'dart:io';

import 'package:dio/dio.dart';
import 'package:link_life_one/local_storage_services/id_name_controller.dart';
import 'package:path_provider/path_provider.dart';

class FileController{

  Future<Directory> prepareSaveDir() async {
    String localPath = (await _findLocalPath());

    final savedDir = Directory(localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      return await savedDir.create();
    }
    return savedDir;
  }

  Future<String> _findLocalPath() async {
    var directory = await getApplicationDocumentsDirectory();
    return '${directory.path}${Platform.pathSeparator}Document';
  }

  Future<String?> downloadFile({
    required url,
    required fileName,
    required Function onFailed
  })async{

    String path = '${(await prepareSaveDir()).path}${Platform.pathSeparator}$fileName';
    String storagePath = '${Platform.pathSeparator}$fileName';
    try {
      await Dio().download(url, path);
      print('full path: $path');
      return storagePath;
    } catch (e) {
      onFailed.call();
      return null;
    }

  }

  Future<String> copyFile({
    required File file,
    bool? isNew,
    required Function onFailed
  })async{
    String fileName = file.path.split(Platform.pathSeparator).last;
    if(isNew!=null && isNew){
      fileName = IdNameController().addNewSuffixFileNamePath(fileName);
    }
    else if(isNew!=null && !isNew){
      fileName = IdNameController().addEditSuffixFileNamePath(fileName);
    }
    String path = '${(await prepareSaveDir()).path}${Platform.pathSeparator}$fileName';
    String storagePath = '${Platform.pathSeparator}$fileName';
    try {
      await file.copy(path);
      return storagePath;

    } catch (e) {
      onFailed.call();
      return '';
    }

  }
}