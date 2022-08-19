import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../utils/ui/ui_util.dart';
import '../utils/utils.dart';
import 'image_widget.dart';


class SmartFutureBuilder<T> extends StatelessWidget {
  const SmartFutureBuilder({Key? key, required this.future,
    required this.buildWidget, this.sizeLoading,
    this.sizeNotFound, bool? isListEmpty}) : isListEmpty= isListEmpty??false, super(key: key);
  final Future<T> future;
  final Widget Function(dynamic data) buildWidget;
  final double? sizeLoading;
  final double? sizeNotFound;
  final bool isListEmpty;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
        future: future,
        builder: (BuildContext context,AsyncSnapshot<T> snapshot){
          switch (snapshot.connectionState){
            case ConnectionState.done:
              if(snapshot.hasError) {
                logger.d(snapshot.error);
                return SizedBox(height: sizeLoading??450, child: Center(child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SpinKitFadingCube(size: 45, color: Colors.red),
                    const SizedBox(height: 20),
                    const Text("Error!"),
                    TextButton(onPressed: ()async=> {await closeDialog(),
                      Get.back()}, child: const Text("back"))
                  ],
                ),));
              }
              if(snapshot.data is List&&(snapshot.data as List).isEmpty&&isListEmpty) {
                return Column(
                  children: [
                    SizedBox(height: sizeNotFound??450, child:
                    NotFoundItem(height: sizeNotFound==null?null:(sizeNotFound!-25.0),)),
                  ],
                );
              }
              return buildWidget(snapshot.data);
            case ConnectionState.waiting:
            default:return SizedBox(height: sizeLoading??450, child: const Center(child:
            SpinKitFadingCube(size: 45, color: Colors.blue),));
          }
        }

    );
  }
}

class NotFoundItem extends StatelessWidget {
  const NotFoundItem({Key? key, this.height}) : super(key: key);
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 30,),
          MBSvg("No-data", asset: 1, height: height??250),
          const SizedBox(height: 30,),
          Text("There are no items to display".tr)
        ],
      ),
    );
  }
}

