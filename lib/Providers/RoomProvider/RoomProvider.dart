import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rooya/ApiConfig/ApiUtils.dart';
import 'package:rooya/ApiConfig/BaseURL.dart';
import 'package:rooya/Models/UpcomingMessageModel.dart';
import 'package:rooya/Models/FriendsListModel.dart';
import 'package:rooya/Models/GroupModel.dart';
import 'package:rooya/Utils/UserDataService.dart';
import 'package:socket_io_client/socket_io_client.dart';

class RoomProvider extends GetxController {
  var listofChat = <GroupModel>[].obs;
  var loadChat = false.obs;
  getGroupList() async {
    listofChat.value = await ApiUtils.getMainRoom(
        limit: 100,
        start: 0,
        mapData: {
          'server_key': serverKey,
          'type': 'get_list',
          'variant': 'room'
        });
    print('lenght = ${listofChat.value.length}');
    loadChat.value = true;
  }

  Socket? socket;
  String alreadyOpenGroup = '';

  connectToSocket() {
    try {
      socket = io(
          '$socketURL',
          OptionBuilder()
              .setTransports(['websocket'])
              .disableAutoConnect()
              .build());
      socket!.connect();
      socket!.on('connect', (value) {
        print('connect to server');
        socket!.emit(
          'join',
          {
            "username": "${UserDataService.userDataModel!.userData!.username}",
            'user_id':
                int.parse('${UserDataService.userDataModel!.userData!.userId}'),
          },
        );
        socket!.on("group_message_page", (data) {
          print('group_message_page');
          getGroupList();
        });
        // socket!.emit(
        //     'register',
        //     jsonEncode({
        //       '_r': '${storage.read('token')}',
        //       'url': "https://cc.rooyatech.com/",
        //       'registrarType': "client",
        //     }));
        // socket!.on('pendingMessage', (value) async {
        //   print('new upcoming message is = $value');
        //   UpcomingMessageModel model =
        //       UpcomingMessageModel.fromJson(jsonDecode(value));
        //   await getChatList();
        //   if (alreadyOpenGroup != model.groupData!.groupId.toString() &&
        //       openSearch) {
        //     alreadyOpenGroup = model.groupData!.groupId.toString();
        //     Navigator.of(Get.context!).pop();
        //     Get.to(OneToOneChat(
        //       groupID: model.groupData!.groupId.toString(),
        //       name: "${model.groupData!.members![0].firstName} " +
        //           "${model.groupData!.members![0].lastName}",
        //       profilePic: "${model.groupData!.members![0].profilePictureUrl}",
        //     ))!
        //         .then((value) => {});
        //     // Navigator.push(
        //     //     Get.context!,
        //     //     MaterialPageRoute(
        //     //         builder: (c) => OneToOneChat(
        //     //               groupID: model.groupData!.groupId.toString(),
        //     //               name: "${model.groupData!.members![0].firstName} " +
        //     //                   "${model.groupData!.members![0].lastName}",
        //     //               profilePic:
        //     //                   "${model.groupData!.members![0].profilePictureUrl}",
        //     //             ))).then((value) async {});
        //   }
        //   await getChatList();
        // });
        // socket!.on('blockStatus', (value) {
        //   print('blockStatus = $value');
        //   getChatList();
        // });
      });
    } catch (e) {
      print('Exception =$e');
    }
  }

  leaveGroup() {
    print('leave group');
    socket!.close();
    socket!.disconnect();
    socket!.dispose();
  }

  var friendList = <Following>[].obs;
  Future getFriendList() async {
    friendList.value = await ApiUtils.allFriendList(limit: 50, start: 0);
  }

  var isLoading = false.obs;
}
