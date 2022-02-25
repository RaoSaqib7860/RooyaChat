import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

snackBarFailer(String message) {
  Get.snackbar('Alert'.tr, message, barBlur: 15.0);
}

snackBarSuccess(String message) {
  Get.snackbar('Success'.tr, message, barBlur: 15.0);
}

launchURL(String aaa) async {
  final url = '$aaa';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}