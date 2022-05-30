import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rooya/ApiConfig/ApiUtils.dart';
import 'package:rooya/GlobalWidget/FileUploader.dart';
import 'package:rooya/Providers/OneToOneModel.dart';
import 'package:rooya/Screens/SearchUser/SearchUserModel.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:dio/dio.dart' as dio;

class OneToOneChatProvider extends GetxController {
  var startTyping = false.obs;
  var searchText = ''.obs;
  var isReciverTyping = false.obs;
  var isOnline = false.obs;


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
  String groupID = '';
  Future getAllMessage({String? groupId}) async {
    // groupID = groupId!;
    // List<OneToOneChatModel> listData = await ApiUtils.getMessage_list(groupID: groupId, start: 0, limit: 100);
    // if(oneToOneChat.isEmpty){
    //   oneToOneChat.value=listData;
    // }else{
    //   if(listData.last.message!=oneToOneChat.last.message){
    //     oneToOneChat.value=listData;
    //   }
    // }
    // oneToOneChat.value =
    //     await ApiUtils.getMessage_list(groupID: groupId, start: 0, limit: 100);
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
  bool isRecive=false;
// 'http://cc.rooyatech.com:0/socket.io/?EIO=3&transport=websocket#'
  onConnectScocket({String? groupID}) {
    //
    try {
      print('token is = ${storage.read('token')}');
      print('${storage.read('token')}');
      socket = io(
          'http://cc.rooyatech.com:4499',
          OptionBuilder()
              .setTransports(['websocket'])
              .disableAutoConnect()
              .build());
      socket!.close();
      socket!.connect();
      socket!.emit('joinRoom', int.parse(groupID!));
      socket!.on('connect', (value) {
        socket!.emit(
            'register',
            jsonEncode({
              '_r': '${storage.read('token')}',
              'url': "https://cc.rooyatech.com/",
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
          log('newMessage is = $value');
          oneToOneChat.insert(0, OneToOneChatModel.fromJson(value));
         //  if(groupID!=''){
         //    getAllMessage(groupId: groupID);
         //  }
        });
        socket!.on('receiveSeen', (value) {
          print('receiveSeen = $value');
          if(!isRecive){
            isRecive=true;
            if(groupID!=''){
              getAllMessage(groupId: groupID);
            }
            Future.delayed(Duration(seconds: 2),(){
              isRecive=false;
            });
          }
        });
        // socket!.on('getFetchOnReconnect', (value) {
        //   print('getFetchOnReconnect = $value');
        // });
        // socket!.on('updateStatusOnReconnect', (value) {
        //   print('updateStatusOnReconnect app = $value');
        // });
        socket!.on('updateStatus', (value) {
          print('updateStatus app = $value');
          if(value['status']==1){
            isOnline.value=true;
          }else{
            isOnline.value=false;
          }
          if(groupID!=''){
            getAllMessage(groupId: groupID);
          }
        });
        // socket!.on('getSessionId', (value) {
        //   print('getSessionId app = $value');
        // });
        socket!.on('blockStatus', (value) {
          print('blockStatus is = $value');
          if(value['block']==0){
            block_user.value=false;
          }else{
            block_user.value=true;
          }
        });
      });
    } catch (e) {
      print(e.toString());
    }
  }

  var block_user=false.obs;

  onSentMessage({String? message, String? groupId}) {
    print('send message');
    try{
      socket!.emit('sendText', {
        'message': message,
        '_r': '${storage.read('token')}',
        'groupId': '$groupId'
      });
    }catch (e){
      print('send message exaption is = $e');
    }
  }

  leaveRoom({String? groupId}) {
    groupID='';
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

  var searchUserModel = SearchUserModel().obs;
  getFriendList() async {
    searchUserModel.value = await ApiUtils.getfriendList(limit: 50, start: 0);
  }
}
