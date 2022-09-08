import 'package:flutter/cupertino.dart';
class IosContainer extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;

  const IosContainer({Key? key,
    this.width = double.infinity,
    this.height = 80, required this.child,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: CupertinoColors.white,
          border: Border.symmetric(
              horizontal: BorderSide(
                  color: CupertinoColors.inactiveGray.withOpacity(0.27),
                  width: 1.2))),
      width: width,
      height: height,
      child: child,
    );
  }
}
