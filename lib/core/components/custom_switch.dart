import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/utils.dart';

typedef SwitchChange = Future<bool> Function(bool newState);

class CustomSwitch extends StatefulWidget {
  final bool initialValue;
  final SwitchChange? onSwitch;

  const CustomSwitch(this.initialValue, {Key? key, this.onSwitch})
      : super(key: key);

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  late bool _state;

  @override
  void initState() {
    super.initState();
    _state = widget.initialValue;
    logger.d("message");
  }

  @override
  Widget build(BuildContext context) {
    var isFa = Get.locale== const Locale('fa');
    return Directionality(
      textDirection: isFa?TextDirection.ltr:TextDirection.rtl,
      child: CupertinoSwitch(
          value: _state,
          activeColor: Theme.of(context).primaryColorLight,
          onChanged: (intendedValue) async {
            bool result = await widget.onSwitch?.call(intendedValue) ?? !intendedValue;
            setState(() {
              _state = result;
            });
          }),
    );
  }
}


class CustomSwitchSyncWithValue extends StatefulWidget {
  bool value;
  final SwitchChange? onSwitch;

   CustomSwitchSyncWithValue(this.value, {Key? key, this.onSwitch}):super(key: key);

  @override
  _CustomSwitchSyncWithValueState createState() => _CustomSwitchSyncWithValueState();
}

class _CustomSwitchSyncWithValueState extends State<CustomSwitchSyncWithValue> {

  @override
  Widget build(BuildContext context) {
    var isFa = Get.locale== const Locale('fa');
    return Directionality(
      textDirection: isFa?TextDirection.ltr:TextDirection.rtl,
      child: CupertinoSwitch(
          value: widget.value,
          activeColor: Theme.of(context).primaryColorLight,
          onChanged: (intendedValue) async {
            bool result = await widget.onSwitch?.call(intendedValue) ?? !intendedValue;
            setState(() {
              widget.value = result;
            });
          }),
    );
  }
}
