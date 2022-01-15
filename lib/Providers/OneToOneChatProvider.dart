import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rooya/ApiConfig/ApiUtils.dart';
import 'package:rooya/GlobalWidget/FileUploader.dart';
import 'package:rooya/Providers/OneToOneModel.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:dio/dio.dart' as dio;

class OneToOneChatProvider extends GetxController {
  var startTyping = false.obs;
  var searchText = ''.obs;
  var isReciverTyping = false.obs;

  checkTypnigStatus({String? groupId}) {
    debounce(searchText, (value) {
      socket!.emit(
          'notTyping', {'userId': storage.read('userID'), 'groupId': groupId});
      startTyping.value = false;
    }, time: Duration(milliseconds: 500));
  }

  userTypingStart({String? groupId}) {
    socket!
        .emit('typing', {'userId': storage.read('userID'), 'groupId': groupId});
  }

  var oneToOneChat = <OneToOneChatModel>[].obs;

  Future getAllMessage({String? groupId}) async {
    oneToOneChat.value =
        await ApiUtils.getMessage_list(groupID: groupId, start: 0, limit: 100);
    if(oneToOneChat.isNotEmpty){
      socket!.emit('announceSeen', oneToOneChat[0].message!.mId);
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

  Socket? socket;

// 'http://chat.rooyatech.com:0/socket.io/?EIO=3&transport=websocket#'
  onConnectScocket({String? groupID}) {
    //
    try {
      print('Connection start to socket group = $groupID');
      print('${storage.read('token')}');
      socket = io(
          'http://chat.rooyatech.com:3003',
          OptionBuilder()
              .setTransports(['websocket'])
              .disableAutoConnect()
              .build());
      socket!.connect();
      socket!.emit('joinRoom', int.parse(groupID!));
      socket!.on('connect', (value) {
        socket!.emit(
            'register',
            jsonEncode({
              '_r': '${storage.read('token')}',
              'url': "https://chat.rooyatech.com/",
              'registrarType': "client",
            }));
        // socket!.emit('fetchOnReconnect', {
        //   '_r': '${storage.read('token')}',
        //   'userId': '${storage.read('userID')}',
        //   'activeGroupId': groupID,
        //   "domGroups": [1, 2],
        //   "sId": "${socket!.id}"
        // });

        socket!.emit('notTyping',
            {'userId': storage.read('userID'), 'groupId': groupID});
        socket!.on('userNotTyping', (value) {
          print('userNotTyping: $value');
          if (value['userId'].toString() != storage.read('userID')) {
            isReciverTyping.value = false;
          }
        });
        socket!.on('userTyping', (value) {
          print('userTyping =$value');
          if (value['userId'].toString() != storage.read('userID')) {
            isReciverTyping.value = true;
          }
        });
        socket!.on('newMessage', (value) {
          print('newMessage = $value');
          oneToOneChat.insert(0, OneToOneChatModel.fromJson(value));
        });
        socket!.on('receiveSeen', (value) {
          print('receiveSeen = $value');
        });
        socket!.on('getFetchOnReconnect', (value) {
          print('getFetchOnReconnect = $value');
        });
        socket!.on('updateStatusOnReconnect', (value) {
          print('updateStatusOnReconnect app = $value');
        });
        socket!.on('updateStatus', (value) {
          print('updateStatus app = $value');
        });
        socket!.on('getSessionId', (value) {
          print('getSessionId app = $value');
        });
      });
    } catch (e) {
      print(e.toString());
    }
  }

  onSentMessage({String? message, String? groupId}) {
    print('send message');
    socket!.emit('sendText', {
      'message': message,
      '_r': '${storage.read('token')}',
      'groupId': '$groupId'
    });
  }

  leaveRoom({String? groupId}) {
    socket!.emit('leaveRoom', int.parse(groupId!));

    socket!.close();
    socket!.dispose();
    socket!.disconnect();
  }

  var recording_start = false.obs;

  final ImagePicker _picker = ImagePicker();

  Future<String> onImageButtonPressed(
      {ImageSource? source, String? tag}) async {
    try {
      final pickedFile;
      if (tag == 'image') {
        pickedFile = await _picker.getImage(
          source: source!,
        );
        if (pickedFile!.path != null) {
          return '${pickedFile!.path}';
        } else {
          return '';
        }
      } else {
        pickedFile = await _picker.getVideo(
          source: source!,
        );
        if (pickedFile!.path != null) {
          return '${pickedFile!.path}';
        } else {
          return '';
        }
      }
    } catch (e) {}
    return '';
  }
}
