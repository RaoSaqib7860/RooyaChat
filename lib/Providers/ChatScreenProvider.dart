import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_io_socket/flutter_io_socket.dart';
import 'package:get/get.dart';
import 'package:rooya/ApiConfig/ApiUtils.dart';
import 'package:rooya/ModelClasses/GroupModel.dart';
import 'package:rooya/ModelClasses/UpcomingMessageModel.dart';
import 'package:rooya/SearchUser/SearchUser.dart';
import '../OneToOneChat.dart';

class ChatScreenProvider extends GetxController {
  var listofMember = <GroupModel>[].obs;

  getGroupList() async {
    listofMember.value = await ApiUtils.getGroup(limit: 10, start: 0);
  }

  Socket? socket;
  String alreadyOpenGroup='';
  connectToSocket() {
    try {
      socket = io(
          'http://chat.rooyatech.com:3003',
          OptionBuilder()
              .setTransports(['websocket'])
              .disableAutoConnect()
              .build());
      socket!.connect();
      socket!.on('connect', (value) {
        print('connect to server');
        socket!.emit(
            'register',
            jsonEncode({
              '_r': '${storage.read('token')}',
              'url': "https://chat.rooyatech.com/",
              'registrarType': "client",
            }));
        socket!.on('pendingMessage', (value) async {
          print('new upcoming message is = $value');
          UpcomingMessageModel model =
              UpcomingMessageModel.fromJson(jsonDecode(value));
          await getGroupList();
          if (model.groupData!.recentMessage == 'You: ' && alreadyOpenGroup!=model.groupData!.groupId.toString() && openSearch) {
            alreadyOpenGroup=model.groupData!.groupId.toString();
            Navigator.push(
                Get.context!,
                MaterialPageRoute(
                    builder: (c) => OneToOneChat(
                          groupID: model.groupData!.groupId.toString(),
                          name: "${model.groupData!.members![0].firstName} " +
                              "${model.groupData!.members![0].lastName}",
                          profilePic:
                              "${model.groupData!.members![0].profilePictureUrl}",
                        ))).then((value) async {
            });
          }
          await getGroupList();
        });
      });
    } catch (e) {
      print('Exception =$e');
    }
  }
}
