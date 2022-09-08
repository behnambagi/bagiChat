part of ui_utils;

// contains all dialog templates
class AppDialog {
  AppDialog._();
  static Future<T?> dialog<T>(BuildContext context,
      {required Widget child,List<Widget>? actions,
        bool backDropFilter = false,
        Function()? onBack}) async{
    var widget = backDropFilter?BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: child):child;
    return await showCupertinoModalPopup<T>(
      context: context,
      builder: (BuildContext context) =>
          WillPopScope(
        onWillPop: () async {
          if(onBack==null) {
            return true;
          } else {
            onBack.call();
            return false;
          }
        },
        child: CupertinoAlertDialog(
          content: widget,
          actions: actions??[],
        ),
      ),
    );
  }

  static closeDialog(BuildContext context) =>Navigator.pop(context);

  static Future<T?> loading<T>(BuildContext context)async{
    return await dialog<T>(context,
        onBack: () {},
        child: Column(
          children: const [
            Padding(
              padding: EdgeInsets.all(25.0),
              child: CupertinoActivityIndicator(radius: 20),
            ),
            Text('Please wait...',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            )
          ],
        ));
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
