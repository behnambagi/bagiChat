import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import '../config/themes/app_theme.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({Key? key, required this.title, required this.color, required this.onTap})
      : super(key: key);
  final String title;
  final Color color;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 258,
        height: context.height*0.061,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(24)),
          boxShadow: const [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.25),
                offset: Offset(0, 4),
                blurRadius: 4,
                spreadRadius: 0)
          ],
        ),
        child: Center(
          child: Text(title,
            style: const TextStyle(
                color: Colors.white, fontFamily: Font.inter, fontSize: 20),
          ),
        ),
        // box-shadow: 0px 4px 4px 0px #00000040;
      ),
    );
  }
}
class ButtonWidgetNext extends StatelessWidget {
  const ButtonWidgetNext({Key? key, required this.title, required this.color, required this.onTap})
      : super(key: key);
  final String title;
  final Color color;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 340,
        height: context.height*0.061,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: Center(
          child: Text(title,
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 13,
                letterSpacing: 0.3),
          ),
        ),
        // box-shadow: 0px 4px 4px 0px #00000040;
      ),
    );
  }
}
