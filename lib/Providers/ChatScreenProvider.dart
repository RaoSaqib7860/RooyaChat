import 'dart:io';
import 'package:get/get.dart';
import 'package:rooya/ApiConfig/ApiUtils.dart';
import 'package:rooya/ApiConfig/BaseURL.dart';
import 'package:rooya/GlobalWidget/FileUploader.dart';
import 'package:rooya/Models/OneTwoOneOuterModel.dart';
import 'package:rooya/Models/UserStoriesModel.dart';
import 'package:rooya/Screens/SearchUser/SearchUserModel.dart';
import 'package:rooya/Utils/UserDataService.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:dio/dio.dart' as dio;

class ChatScreenProvider extends GetxController {
  var listofChat = <Data>[].obs;
  var loadChat = false.obs;
  getChatList() async {
    OneToOneChatOuterModel v = await ApiUtils.getGroup(
        limit: 100,
        start: 0,
        mapData: {'server_key': serverKey, 'data_type': 'users'});
    print('pharse data is =${v.apiStatus}');
    if (v.apiStatus == 200) {
      listofChat.value = v.data!;
    }
    loadChat.value = true;
  }

  Socket? socket;
  String alreadyOpenGroup = '';

  //https://xd.rooya.com:449/?hash=9c693d1979dc33cfa0e0
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
        socket!.on("private_message_page", (data) {
          print('private_message_page');
          getChatList();
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
    socket!.close();
    socket!.disconnect();
    socket!.dispose();
  }

  var searchUserModel = SearchUserModel().obs;
  getFriendList() async {
    searchUserModel.value = await ApiUtils.getfriendList(limit: 50, start: 0);
  }

  var idsOfUserStories = [];
  var storyList = <UserStoryModel>[].obs;
  Future getStoryList() async {
    storyList.value =
        await ApiUtils.getAllStoriesData(mapData: {'server_key': serverKey});
    idsOfUserStories = [];
    for (var i in storyList) {
      idsOfUserStories.add(i.userId);
    }
  }

  sentMessageViaFile({String? filePath, String? groupId}) async {
    var file = File(filePath!);
    String fileName = file.path.split('/').last;
    Map<String, dynamic> data = {
      'memberId': storage.read('userID'),
      'groupId': '$groupId',
      'file': await dio.MultipartFile.fromFile(
        '${file.path}',
        filename: '$fileName',
      )
    };
    sendFileMessage(data);
  }

  var isLoading = false.obs;
}
