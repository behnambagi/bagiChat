import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonCustom extends StatefulWidget {
  final String text;
  final IconData? iconData;
  final VoidCallback? onClick;
  final Color? fromColor;
  final Color? colorMain;
  final Color? toColor;
  final Color? textColor;
  final double? width;

  const ButtonCustom(
      this.text, {
        this.onClick,
        this.iconData,
        this.fromColor,
        this.toColor,
        this.width,
        this.textColor = Colors.white,
        Key? key,
        this.colorMain,
      }) : super(key: key);

  @override
  _ButtonCustomState createState() => _ButtonCustomState();
}

class _ButtonCustomState extends State<ButtonCustom> {
  bool _isTapped = false;
  bool _pending = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTapDown: (d) {
          setState(() {
            _isTapped = true;
          });
        },
        onTap: () {
          if (_pending) return;
          _pending = true;
          Future.delayed(const Duration(milliseconds: 300)).then((value) {
            _pending = false;
            widget.onClick?.call();
          });
        },
        onTapCancel: () {
          setState(() {
            _isTapped = false;
          });
        },
        onTapUp: (d) {
          setState(() {
            _isTapped = false;
          });
        },
        child: Container(
          // width: widget.width ?? 310,
          // height: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            boxShadow: _isTapped
                ? []
                : [
              BoxShadow(
                color: widget.fromColor ??
                    Theme.of(context).primaryColor.withOpacity(0.5),
                blurRadius: 10,
                offset: const Offset(0, 0),
              ),
            ],
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                widget.fromColor ??
                    widget.colorMain ??
                    Theme.of(context).primaryColor,
                widget.toColor ??
                    widget.colorMain ??
                    Theme.of(context).primaryColorLight
              ],
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.text,
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: widget.textColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (widget.iconData != null)
                VerticalDivider(
                  thickness: 1,
                  color: widget.textColor,
                  indent: 4,
                  endIndent: 4,
                ),
              if (widget.iconData != null)
                Icon(
                  widget.iconData,
                  color: widget.textColor,
                  size: 15,
                )
            ],
          ),
        ));
  }
}

class WhiteButton extends StatelessWidget {
  final String text;
  final Key? keyBtn;
  final VoidCallback? onClick;
  final double? width;
  final IconData? iconData;

  const WhiteButton(this.text,
      {Key? key, this.onClick, this.width, this.iconData, this.keyBtn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonCustom(
      text,
      key: keyBtn,
      onClick: onClick,
      textColor: const Color(0xff3F497C),
      iconData: iconData,
      fromColor: Get.isDarkMode?Get.theme.hintColor:const Color(0xffe8e8e8),
      toColor: const Color(0xfff9f9f9),
      width: width,
    );
  }
}

