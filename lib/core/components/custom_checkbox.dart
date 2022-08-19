import 'package:flutter/material.dart';
import 'package:get/get.dart';

typedef CheckBoxChange = Future<bool> Function(bool newState);

class CustomCheckBox extends StatefulWidget {
  final bool initialValue;
  final CheckBoxChange? onSwitch;

  const CustomCheckBox(this.initialValue, {Key? key, this.onSwitch})
      : super(key: key);

  @override
  _CustomCheckBoxState createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  late bool _state;

  @override
  void initState() {
    super.initState();
    _state = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    var isFa = Get.locale== const Locale('fa');
    return Directionality(
      textDirection: isFa?TextDirection.ltr:TextDirection.rtl,
      child: Checkbox(
          value: _state,
            // activeColor: Theme.of(context).primaryColorLight,
          onChanged: (intendedValue) async {
            if(intendedValue ==null)return;
            bool result = await widget.onSwitch?.call(intendedValue) ?? !intendedValue;
            setState(() {
              _state = result;
            });
          }),
    );
  }
}
