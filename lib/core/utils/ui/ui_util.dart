library ui_utils;

import 'dart:async';
import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:async/async.dart';
import '../../components/button_custom.dart';
import '../../components/loading_indicator.dart';
import '../utils.dart';


part 'app_snack_bar.dart';
part 'app_dialog.dart';
part 'app_loading.dart';
part 'app_bottom_sheet.dart';
part 'app_extension.dart';

closeDialog() {
  if (Get.isDialogOpen ?? false||Get.isSnackbarOpen) Get.back();
}

bool isBig(BuildContext context) {
  Orientation big = MediaQuery.of(context).orientation;
  return Orientation.landscape == big;
}


