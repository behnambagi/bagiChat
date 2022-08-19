part of ui_utils;

class AppLoading{
  static loadingOn<T>(Future Function() func, {int? sizeTimeCancel = 10}) async {
    var myCancelableFuture = CancelableOperation.fromFuture(
        func(),onCancel: ()=>AppSnackBar.snackBar("انجام شد", "درخواست مورد نظر جلوگیری شد"));
    _loadingDialog(sizeTimeCancel: sizeTimeCancel, onCancel: ()=> myCancelableFuture.cancel()
    );
    try {
      await myCancelableFuture.value;
      closeDialog();
    } catch (e) {
      closeDialog();
      rethrow;
    }
  }

  static Future<bool> loadingOnBool<T>(Future Function() func, {int? sizeTimeCancel}) async {
    _loadingDialog(sizeTimeCancel: sizeTimeCancel);
    try {
      var b = await func();
      closeDialog();
      return b;
    } catch (e) {
      closeDialog();
      rethrow;
    }
  }

  static _loadingDialog({Function()? onCancel, int? sizeTimeCancel}) async {
    RxBool cancel = true.obs;
    if(sizeTimeCancel!=null)Timer(sizeTimeCancel.seconds, ()=>cancel.value = false);
    Get.defaultDialog(
      title: "",
      content: WillPopScope(
        onWillPop: () async => false,
        child: Obx(()=> Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LoadingIndicator(color: Get.theme.colorScheme.secondary),
            const SizedBox(height: 10),
            Text("Please wait".tr),
            if(!cancel.value && sizeTimeCancel!=null)
              TextButton(onPressed: () {
                Get.back();
                onCancel!();
              },
                  child: Text("Cancel".tr))
          ],
        ),
        ),
      ),
      barrierDismissible: false,
    );
  }


}