import 'package:get/get.dart';
import 'package:rooya/ApiConfig/ApiUtils.dart';
import 'package:rooya/ApiConfig/BaseURL.dart';
import 'package:rooya/Models/FriendsListModel.dart';
import 'package:rooya/Models/GroupModel.dart';

class GroupInformationConntroller extends GetxController {
  var listofChat = <GroupModel>[].obs;
  Future<GroupModel> getGroupList(String groupID) async {
    listofChat.value = await ApiUtils.getMainGroup(
        limit: 100,
        start: 0,
        mapData: {'server_key': serverKey, 'data_type': 'groups'});
    for (var i in listofChat) {
      if (i.groupId.toString() == groupID) {
        return i;
      }
    }
    return GroupModel(groupId: '');
  }

  var friendList = <Following>[].obs;
  Future getFriendList() async {
    friendList.value = await ApiUtils.allFriendList(limit: 50, start: 0);
  }
}
