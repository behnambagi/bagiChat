import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../utils/utils.dart';
const double _radius = 5;

typedef TextChangeCallback = void Function(String text);

class TextFieldWidget extends StatelessWidget {
  final String? hint;
  final String? label;
  final TextChangeCallback? onTextChange;
  final TextInputType type;
  final bool isRequired;
  final bool? isPassInput;
  final bool? isUsernameInput;
  final bool enabled;
  final Widget? prefixIcon;
  final bool readOnly;
  final void Function()? onTap;
  final String? initialValue;
  final int maxLines;
  final double maxWidth;
  final int minLength;
  final int? maxLength;
  final Widget? endWidget;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final bool obscure;
  final FocusNode? focusNode;
  final TextDirection? textDirection;
  final TextEditingController? controller;

  const TextFieldWidget(
      {this.label, this.hint, this.isRequired = true,
        this.isPassInput, this.isUsernameInput, this.enabled = true,
        this.type = TextInputType.text, this.onTextChange, this.initialValue,
        this.minLength = 0, this.maxLength = 255, this.readOnly = false, this.onTap,
        this.maxLines = 1, this.maxWidth = 340, Key? key, this.endWidget, this.obscure = false,
        this.focusNode, this.textDirection, this.prefixIcon, this.textInputAction,
        this.onFieldSubmitted, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (label?.isNotEmpty ?? false)
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 0, 10),
              child: Text(label! + (isRequired == false ? "Optional".tr : ''),
                  style: TextStyle(
                      fontSize: 15, color: Theme.of(context).hintColor),
                  textAlign: TextAlign.center),
            ),
            Stack(children: [
            TextFormField(
              controller: controller,
              textInputAction:textInputAction,
              autofocus: true,
              focusNode: focusNode,
              enabled: enabled,
              initialValue: initialValue,
              onFieldSubmitted: onFieldSubmitted,
              readOnly: readOnly,
              onTap: onTap,
              maxLines: maxLines,
              textDirection: textDirection,
              obscureText: obscure,
              validator: (value) {
                if (isRequired && (value?.isEmpty ?? true)) {
                  return "This field must not be empty".tr;
                }
                if(isUsernameInput == true){
                  String  patterns = r'^[A-Za-z][A-Za-z0-9_]{4,29}$';
                  RegExp regExps = RegExp(patterns);
                  logger.d(regExps.hasMatch(value??""));
                  if (!regExps.hasMatch(value??"")) {
                    return "یوزر باید بیشتر از 4 حرف و شامل a تا z و یا با اعداد باشد".tr;
                  }
                }
                if(isPassInput == true){
                  String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
                  RegExp regExp = RegExp(pattern);
                  logger.d(regExp.hasMatch(value??""));
                  if (!regExp.hasMatch(value??"")) {
                    return "پسورد باید حداقل 8 کاراکتر و یک حرف بزرگ و عدد باشد".tr;
                  }
                }
                if (minLength > 0 && (value?.length ?? 0) < minLength) {
                  return "At least # character".tr.replaceAll("#", minLength.localized());
                }
                if ((value?.isNotEmpty ?? false) &&
                    type == TextInputType.emailAddress &&
                    !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value ?? "")) return "Enter a valid email".tr;
                if ((value?.isNotEmpty ?? false) &&
                    type == TextInputType.phone &&
                    !RegExp(r"^09[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]")
                        .hasMatch(value ?? "")) {
                  return "Invalid mobile number".tr;
                }
                return null;
              },
              onChanged: onTextChange,
              keyboardType: type,
              inputFormatters: [
                if (type == TextInputType.phone || type == TextInputType.number)
                  FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(maxLength)
              ],
              decoration: InputDecoration(
                prefixIcon: prefixIcon,
                filled: !context.isDarkMode,
                contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                hintText: hint,
                hintStyle: TextStyle(
                    color: readOnly?Colors.black.withOpacity(0.8):const Color(0xff9297B0),
                    fontSize: 16),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(_radius)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).hintColor),
                  borderRadius: const BorderRadius.all(Radius.circular(_radius)),
                ),
                focusedBorder:  OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).hintColor),
                  borderRadius: const BorderRadius.all(Radius.circular(_radius)),
                ),
                fillColor: Colors.white,
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.redAccent),
                  borderRadius:
                   BorderRadius.all(Radius.circular(_radius)),
                ),
              ),
            ),
            if (endWidget != null)
              Align(
                alignment: textDirection == TextDirection.ltr
                    ? Alignment.centerRight
                    : AlignmentDirectional.centerEnd,
                child: endWidget,
              )
          ])
        ],
      ),
    );
  }
}

class PasswordTextFieldWidget extends StatefulWidget {
  final String? initialValue;
  final Icon? prefixIcon;
  final bool? isPassInput;
  final TextChangeCallback onPasswordChange;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final String? label;
  final bool isRequired;

  const PasswordTextFieldWidget(
      {Key? key,this.initialValue,
        required this.onPasswordChange, this.label, this.isPassInput,
        this.isRequired = true, this.textInputAction, this.onFieldSubmitted, this.prefixIcon })
      : super(key: key);

  @override
  _PasswordTextFieldWidgetState createState() => _PasswordTextFieldWidgetState();
}

class _PasswordTextFieldWidgetState extends State<PasswordTextFieldWidget> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFieldWidget(
      textInputAction: widget.textInputAction,
      label: widget.label,
      type: TextInputType.visiblePassword,
      obscure: _obscure,
      onTextChange: widget.onPasswordChange,
      hint: "    "+"Password".tr,
      onFieldSubmitted: widget.onFieldSubmitted,
      prefixIcon: widget.prefixIcon,
      initialValue: widget.initialValue,
      isPassInput: widget.isPassInput,
      textDirection: TextDirection.ltr,
      isRequired: widget.isRequired,

      endWidget: IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () {
            setState(
                  () {
                _obscure = !_obscure;
              },
            );
          },
          icon: const Icon(Icons.remove_red_eye_outlined)),
    );
  }
}


extension LocalizedNumbers on num {
  String localized([String? langCode]) {
    langCode = langCode ?? Get.locale?.languageCode;
    String numStr = toString();
    if (langCode == 'fa') {
      return _toPersian(numStr);
    } else if (langCode == 'ar') {
      return _toArabic(numStr);
    } else {
      return numStr;
    }
  }
}

extension StringLocalizedNumbers on String {
  String localizedNumbers([String? langCode]) {
    langCode = langCode ?? Get.locale?.languageCode;
    if (langCode == 'fa') {
      return _toPersian(this);
    } else if (langCode == 'ar') {
      return _toArabic(this);
    } else {
      return this;
    }
  }
}

String _toPersian(String numbers) {
  String formattedString = numbers.replaceAll("1", "۱");

  formattedString = formattedString.replaceAll("2", "۲");
  formattedString = formattedString.replaceAll("3", "۳");
  formattedString = formattedString.replaceAll("4", "۴");
  formattedString = formattedString.replaceAll("5", "۵");
  formattedString = formattedString.replaceAll("6", "۶");
  formattedString = formattedString.replaceAll("7", "۷");
  formattedString = formattedString.replaceAll("8", "۸");
  formattedString = formattedString.replaceAll("9", "۹");
  formattedString = formattedString.replaceAll("0", "۰");

  return formattedString;
}

String _toArabic(String numbers) {
  String formattedString = numbers.replaceAll("1", "۱");

  formattedString = formattedString.replaceAll("2", "۲");
  formattedString = formattedString.replaceAll("3", "٣");
  formattedString = formattedString.replaceAll("4", "٤");
  formattedString = formattedString.replaceAll("5", "٥");
  formattedString = formattedString.replaceAll("6", "٦");
  formattedString = formattedString.replaceAll("7", "۷");
  formattedString = formattedString.replaceAll("8", "۸");
  formattedString = formattedString.replaceAll("9", "۹");
  formattedString = formattedString.replaceAll("0", "۰");

  return formattedString;
}

