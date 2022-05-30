import 'package:get/get.dart';
import 'package:rooya/ApiConfig/ApiUtils.dart';
import 'package:rooya/Screens/SearchUser/SearchUserModel.dart';
import 'package:rooya/Screens/UserChat/Media/GroupInfoModel.dart';

class UserChatInformationConntroller extends GetxController {
  var infoModel = UserInfoModel().obs;
  var loadData = false.obs;
  var listofFriends=[].obs;
  getGroupInfo({String? userID}) async {
    infoModel.value = await ApiUtils.getUserInfo(start: 0, limit: 10,userID: userID);
    loadData.value = true;
  }

  var searchUserModel = SearchUserModel().obs;
  getFriendList() async {
    searchUserModel.value = await ApiUtils.getfriendList(limit: 50, start: 0);
  }
}
