import 'package:get/get.dart';
import 'cf_local_storage.dart';

abstract class ControllerWithStorage extends GetxController{
  LocalStorage storage = Get.find();
}