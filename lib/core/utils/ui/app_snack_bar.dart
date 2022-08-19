part of ui_utils;


/// contains all snackBar templates
class AppSnackBar {
  static snackBar(String title, String msg, {bool? noCloseDialog, bool? back}) async {
    if (noCloseDialog == null) closeDialog();
    if(back!=null&&back)Get.back();
    Get.snackbar(title, msg);
  }

  static successfulSnackBar() {
    snackBar("Successful".tr, "Successfully saved".tr);
  }

}
