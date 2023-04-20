import 'package:intl/intl.dart';

const newSuffix = '_new';
const editSuffix = '_edit';

class IdNameController{

  String getId(){
    var now = DateTime.now();
    return 'temp_${DateFormat('ddHHmmss').format(now)}${now.millisecond}${now.microsecond}';
  }

  String addNewSuffixFileNamePath(String path){
    return _addFileNameSuffixPath(path, newSuffix);
  }

  String addEditSuffixFileNamePath(String path){
    return _addFileNameSuffixPath(path, editSuffix);
  }

  String removeNewSuffixFileNamePath(String path){
    return _removeFileNameSuffixPath(path, newSuffix);
  }

  String removeEditSuffixFileNamePath(String path){
    return _removeFileNameSuffixPath(path, editSuffix);
  }

  int detectStateSuffix(String path){
    if(path.contains(newSuffix) && _detectSuffixFromFileNameSuffixPath(path, newSuffix)){
      return 1;
    }
    if(path.contains(editSuffix) && _detectSuffixFromFileNameSuffixPath(path, editSuffix)){
      return 2;
    }
    return 0;
  }

  bool _detectSuffixFromFileNameSuffixPath(String fullPath, String suffix){
    String name = fullPath.substring(fullPath.lastIndexOf('/')+1, fullPath.indexOf('.'));
    if(name.contains(suffix)){
      String lastPartName = name.substring(name.length-suffix.length);
      if(lastPartName==suffix) return true;
      return false;
    }
    else{
      return false;
    }
  }

  String _removeFileNameSuffixPath(String fullPath, String suffix){
    String path = fullPath.substring(0, fullPath.lastIndexOf('/')+1);
    String name = fullPath.substring(fullPath.lastIndexOf('/')+1, fullPath.indexOf('.'));
    String extension = fullPath.substring(fullPath.indexOf('.'));
    if(name.contains(suffix)){
      name = name.substring(0, name.lastIndexOf(suffix));
      return '$path$name$extension';
    }
    else{
      return fullPath;
    }
  }

  String _addFileNameSuffixPath(String fullPath, String suffix){
    String path = fullPath.substring(0, fullPath.lastIndexOf('/')+1);
    String name = fullPath.substring(fullPath.lastIndexOf('/')+1, fullPath.indexOf('.'));
    String extension = fullPath.substring(fullPath.indexOf('.'));
    return '$path$name$suffix$extension';
  }

}