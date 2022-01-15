import 'package:get/get.dart';

snackBarFailer(String message) {
  Get.snackbar('Alert'.tr, message, barBlur: 15.0);
}

snackBarSuccess(String message) {
  Get.snackbar('Success'.tr, message, barBlur: 15.0);
}
