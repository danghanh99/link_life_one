class Constant {
  // prod
  // static const String url = "https://koji-app2.starboardasiavn.com/";
  // static const String url = "http://koujiapp.kir.jp/"; // new
  // dev
  static const String url = "https://koji-app.starboardasiavn.com/";
  static const String getListInventorySchedule = '${url}src/APIs/InventorySchedule/getListInventorySchedule.php?';
  static const String updateInventoryScheduleById = '${url}src/APIs/InventorySchedule/updateInventoryScheduleById.php';
  static const String checkSaveMaterial = '${url}src/APIs/Material/getListDefaultMaterial.php?';
  static const String getListDefaultFromEditMaterial = '${url}src/APIs/Material/getListDefaultFromEditMaterial.php?';
  static const String deleteListMaterial = '${url}src/APIs/Material/deleteListMaterial.php';
  static const String deleteExistSave = '${url}/src/APIs/Material/deleteExistSave.php';
  static const String getListMemberCategory = '${url}src/APIs/InventoryList/getListMemberCategory.php';
  static const String getListDefaultInventory = '${url}src/APIs/InventoryList/getListDefaultInventory.php?';
  static const String getListInventoryByCheckList = '${url}src/APIs/InventoryList/getListInventoryByCheckList.php?';
  static const String requestPostUploadRegisterSignImage = '${url}Request/Koji/requestPostUploadRegisterSignImage.php';
  static const String deleteMaterialById = '${url}src/APIs/Material/deleteMaterialById.php';
  static const String getDataQRById = '${url}src/APIs/Material/getDataQRById.php?';
  static const String getListDefaultMaterialTakeBack = '${url}src/APIs/MaterialTakeBack/getListDefaultMaterialTakeBack.php?';
  static const String insertMaterialTakeBackById = '${url}src/APIs/MaterialTakeBack/insertMaterialTakeBackById.php';
  static const String registrationMaterialById = '${url}src/APIs/Material/registrationMaterialById.php';
  static const String backMaterial = '${url}src/APIs/Material/backMaterial.php';
  static const String getListPersonSchedule = '${url}Request/Schedule/requestGetListPeople.php?';

  static const int compressTargetWidth = 600;
}
