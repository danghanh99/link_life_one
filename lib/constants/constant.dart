class Constant {
  // static const String url = "https://koji-app2.starboardasiavn.com/";
  static const String url = "https://koji-app.starboardasiavn.com/";
  static const String getListInventorySchedule = '${url}src/APIs/InventorySchedule/getListInventorySchedule.php?';
  static const String updateInventoryScheduleById = '${url}src/APIs/InventorySchedule/updateInventoryScheduleById.php';
  static const String checkSaveMaterial = '${url}src/APIs/Material/getListDefaultMaterial.php?';
  static const String getListDefaultFromEditMaterial = '${url}src/APIs/Material/getListDefaultFromEditMaterial.php?';
  static const String deleteListMaterial = '${url}src/APIs/Material/deleteListMaterial.php';
  static const String getListMemberCategory = '${url}src/APIs/InventoryList/getListMemberCategory.php';
  static const String getListDefaultInventory = '${url}src/APIs/InventoryList/getListDefaultInventory.php?';
  static const String getListInventoryByCheckList = '${url}src/APIs/InventoryList/getListInventoryByCheckList.php?';
}
