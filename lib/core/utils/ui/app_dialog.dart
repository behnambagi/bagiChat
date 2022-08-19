part of ui_utils;

// contains all dialog templates
class AppDialog {
  static Future<T?> dialog<T>(Widget widget, {Function()? onBack}) {
    return Get.dialog<T>(
      WillPopScope(
        onWillPop: () async {
          if(onBack==null) {
            return true;
          } else {
            onBack.call();
            return false;
          }
        },
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Material(child: widget),
                ),
              )),
        ),
      ),
    );
  }

  static Future<T?> dialogDeveloping<T>() {
    return dialog<T>(SizedBox(
      width: 280,
      height: 380,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const MBSvg("develop", height: 200,width: 200,),
            Text("Development stage".tr, style: const TextStyle(fontSize: 13)),
            const SizedBox(height: 5),
            Text("We are implementing this section, please be patient".tr,
                style: const TextStyle(fontSize: 10)),
            const SizedBox(height: 15),
            ButtonCustom("back".tr, onClick: ()=>closeDialog(),
                width: 110, colorMain: const Color(0xffFF725E)),
          ],
        ),
      ),
    ));
  }

  static Future<T?> dialogConnectionIsWifi<T>() {
    return dialogRequired(SizedBox(
      width: 250,
      height: 340,
      child: Center(
        child: Column(
          children: [
            const MBPng("netWork", width: double.infinity),
            SizedBox(
                width: 220,
                child: Text(
                    "Please turn off your internet and stay connected to WiFi only".tr,
                    style: const TextStyle(fontSize: 15))),
            const SizedBox(height: 15),
            ButtonCustom(
              "I turned it off!".tr,iconData: Icons.network_check,
              onClick: () async {
                var connectivityResult =
                await (Connectivity().checkConnectivity());
                if (connectivityResult == ConnectivityResult.mobile) {
                  AppSnackBar.snackBar("Error".tr,
                      "You have not turned off your mobile internet!".tr,
                      noCloseDialog: true);
                } else {
                  closeDialog();
                }
              },
              width: 140,
            )
          ],
        ),
      ),
    ));
  }

  static Future<T?> dialogRequired<T>(Widget widget) {
    return Get.dialog<T>(
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Material(child: widget),
                ),
              )),
        ),
        barrierDismissible: false);
  }

  static Future<T?> dialogRequiredNotInternet<T>(void Function()? onAction) {
    return Get.dialog<T>(
        Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Material(
                    child: SizedBox(
                      width: 270,
                      height: 290,
                      child: Column(
                        children: [
                          const MBPng("wifi_connect", width: 190, height: 180),
                          Text(
                            'You are not connected to the Internet.'.tr,
                            style:const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 5),
                          Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const Spacer(),
                                ButtonCustom(
                                  "Try again".tr,
                                  onClick: onAction,
                                  width: 115,
                                ),
                                const Spacer(),
                                ButtonCustom(
                                  "back".tr,
                                  onClick: () => closeDialog(),
                                  width: 115,
                                  colorMain: Colors.red,
                                ),
                                const Spacer()
                              ],
                            ),
                          )
                        ],
                      ),
                    )),
              ),
            )),
        barrierDismissible: false);
  }

  static Future<T?> mediumDialog<T>(Widget child) =>
      dialog<T>(SizedBox(width: 500, height: 650, child: child));

  static gotItDialog(String title, String msg, {Function()? onGotIt}) async {
    await Get.defaultDialog(
      title: title,
      content: Text(msg),
      confirm: ElevatedButton(
          onPressed: () {
            Get.back();
            onGotIt?.call();
          },
          child: Text("gotIt".tr)),
    );
  }

  static Future<bool?> yesNoDialog(BuildContext context, {bool? forBack}) async {
    return AppBottomSheet.showBottomSheet<bool>(
        context,
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonCustom(
                "No".tr,
                width: 150,
                fromColor: const Color(0xffD82517),
                toColor: const Color(0xffF44336),
                onClick: () => Navigator.pop(context, false),
              ),
              const SizedBox(width: 32),
              ButtonCustom(
                forBack==true?"Save".tr:"Yes".tr,
                width: 150,
                onClick: () => Navigator.pop(context, true),
              )
            ],
          ),
        ),
        title: forBack==true?"آیا مقادیر وارد شده ذخیره شوند؟":"Are you sure?".tr);
  }

}
