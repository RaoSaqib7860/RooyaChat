import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_io_socket/flutter_io_socket.dart';
import 'package:get/get.dart';
import 'package:rooya/ApiConfig/ApiUtils.dart';
import 'package:rooya/ModelClasses/GroupModel.dart';

class ChatScreenProvider extends GetxController {
  var listofMember = <GroupModel>[].obs;

  getGroupList() async {
    listofMember.value = await ApiUtils.getGroup(limit: 10, start: 0);
  }

  Socket? socket;

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
        socket!.on('pendingMessage', (value) {
          getGroupList();
        });
      });
    } catch (e) {
      print('Exception =$e');
    }
  }

}
