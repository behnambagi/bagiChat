part of ui_utils;

// contains all bottomSheet templates
class AppBottomSheet {

  static Future<T?> actionSheetCupertino<T>(BuildContext context) {
    return showCupertinoModalPopup(
      context: context,
      filter: ImageFilter.blur(sigmaX: 5,sigmaY: 5),
      builder: (BuildContext context) => CupertinoActionSheet(
          title: const Text('Choose Options'),
          message: const Text('Your options are '),
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: const Text('One'),
              onPressed: () {
                Navigator.pop(context, 'One');
              },
            ),
            CupertinoActionSheetAction(
              child: const Text('Two'),
              onPressed: () {
                Navigator.pop(context, 'Two');
              },
            )
          ],
          cancelButton: CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context, 'Cancel');
            },
            child: const Text('Cancel'),
          )),
    );
  }

  static Future<T?> showBottomSheet<T>(BuildContext context, Widget child,
      {String? title, bool fullScreen = false}) {
    return showModalBottomSheet(
      isScrollControlled: fullScreen,
// required for min/max child size
      context: context,
      barrierColor: Colors.black12,
      elevation: 10,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (ctx) {
        return SizedBox(
          width: 250,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 100,
                height: 4,
                decoration: const BoxDecoration(
                    color: Color(0xffb0b0b0),
                    borderRadius: BorderRadius.all(Radius.circular(25))
                ),
              ),
              const SizedBox(height: 12),
              if (title != null)
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline6,
                      )
                    ],
                  ),
                ),
              child
            ],
          ),
        );
      },
    );
  }

  static showDraggableBottomSheet(BuildContext context,
      {required Widget child, String? title}) {
    showModalBottomSheet(
      isScrollControlled: true,
      // required for min/max child size
      context: context,
      barrierColor: Colors.black12,
      elevation: 10,

      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (ctx) {
        return DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.25,
            maxChildSize: 1,
            builder: (dssContext, controller) => SingleChildScrollView(
              controller: controller,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                      width: 72,
                      child: Divider(
                        color: Color(0xffb0b0b0),
                        thickness: 2,
                        height: 15,
                      )),
                  if (title != null)
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            title,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline6,
                          )
                        ],
                      ),
                    ),
                  const Divider(thickness: 1),
                  child,
                ],
              ),
            ));
      },
    );
  }

}
