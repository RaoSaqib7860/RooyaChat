import 'package:get/get.dart';
import 'package:rooya/ApiConfig/ApiUtils.dart';
import 'package:rooya/Media/GroupInfoModel.dart';
import 'package:rooya/SearchUser/SearchUserModel.dart';

class UserChatInformationConntroller extends GetxController {
  var infoModel = UserInfoModel().obs;
  var loadData = false.obs;
  var listofFriends=[].obs;
  getGroupInfo({String? groupID}) async {
    infoModel.value = await ApiUtils.getGroupbyIds(start: 0, limit: 10,groupID: groupID);
    infoModel.value.members!.removeWhere((element) => element.userId==int.parse(
        infoModel.value.groupAdmin!));
    infoModel.value.members!.insert(
        0,
        Members(
            userId: int.parse(infoModel.value.groupAdmin!),
            firstName: infoModel.value.groupFAdmin,
            lastName: infoModel.value.groupLAdmin,
            profilePictureUrl: infoModel.value.groupPAdmin,
            isadmin: true));
    listofFriends.value=[];
    for(var i in infoModel.value.members!){
      if(i.isadmin!){
        listofFriends.add(i.userId);
      }
    }
    loadData.value = true;
  }

  var searchUserModel = SearchUserModel().obs;
  getFriendList() async {
    searchUserModel.value = await ApiUtils.getfriendList(limit: 50, start: 0);
  }
}
