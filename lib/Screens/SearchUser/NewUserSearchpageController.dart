import 'package:get/get.dart';
import 'package:rooya/ApiConfig/ApiUtils.dart';

import 'SearchUserModel.dart';

class NewUserSearchPageController extends GetxController {
  var searchUserModel = SearchUserModel().obs;

  getFriendList() async {
    searchUserModel.value = await ApiUtils.getfriendList(limit: 50, start: 0);
  }
}
