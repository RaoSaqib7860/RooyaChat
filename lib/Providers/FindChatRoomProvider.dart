import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rooya/ApiConfig/ApiUtils.dart';
import 'package:rooya/Models/GroupModel.dart';

class FindChatRoomProvider extends GetxController {
  var listofChat = <GroupModel>[].obs;
  var loadChat = false.obs;
 Future getGroupList({Map? mapData}) async {
    listofChat.value = await ApiUtils.getAllRoomData(mapData: mapData);
    loadChat.value = true;
  }

  Future<bool> joinRoom({Map? mapData}) async {
   bool value = await ApiUtils.joinRoom(mapData: mapData);
   return value;
  }
}
