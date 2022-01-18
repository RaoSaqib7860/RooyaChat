import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:rooya/ApiConfig/BaseURL.dart';
import 'package:rooya/GlobalWidget/SnackBarApp.dart';
import 'package:rooya/ModelClasses/GroupModel.dart';
import 'package:rooya/ModelClasses/LoginModel.dart';
import 'package:rooya/Providers/OneToOneModel.dart';
import 'package:rooya/SearchUser/SearchUserModel.dart';

final getGroups = 'getGroups';
final login = 'login/';
final sendMessage = 'sendMessage';
final getMessage = 'getMessage';
final friendList = 'friendList';
final removeGroup ='removeGroup';
final removeMessage='removePost';

GetStorage storage = GetStorage();
Map<String, String> header = {
  'Authorization': 'Basic YWRtaW46MTIzNA==',
  'x-auth-token': '${storage.read('token')}',
};

class ApiUtils {
  static Future sendMessagepost({Map? map}) async {
    var url = Uri.parse('$baseUrl$sendMessage');
    try {
      var responce = await http.post(url, headers: header, body: map);
      var data = jsonDecode(responce.body);
      print('group data is = $data');
      if (data['status']['code'] == 200) {
      } else {}
    } catch (e) {
      print('Exception is = $e');
    }
  }

  static Future removeMessageApi({Map? map}) async {
    var url = Uri.parse('$baseUrl$removeMessage');
    try {
      var responce = await http.post(url, headers: header, body: map);
      var data = jsonDecode(responce.body);
      print('remove Message data is = $data');
      if (data['status']['code'] == 200) {
      } else {}
    } catch (e) {
      print('Exception is = $e');
    }
  }

  static Future removeGroupApi({Map? map}) async {
    var url = Uri.parse('$baseUrl$removeGroup');
    try {
      var responce = await http.post(url, headers: header, body: map);
      var data = jsonDecode(responce.body);
      print('remove group data is = $data');
      if (data['status']['code'] == 200) {
      } else {}
    } catch (e) {
      print('Exception is = $e');
    }
  }

  static Future<List<GroupModel>> getGroup({int? limit, int? start}) async {
    var url = Uri.parse('$baseUrl$getGroups?limit=$limit&start=$start');
    try {
      var responce = await http.get(url, headers: header);
      var data = jsonDecode(responce.body);
      log('group data is = $data');
      if (data['status']['code'] == 200) {
        List list = data['response'];
        List<GroupModel> modellist =
            list.map((e) => GroupModel.fromJson(e)).toList();
        return modellist;
      } else {
        return [];
      }
    } catch (e) {
      print('Exception is = $e');
    }
    return [];
  }

  static Future<SearchUserModel> getfriendList({int? limit, int? start}) async {
    var url = Uri.parse(
        'https://chat.rooyatech.com/user/friendList?limit=$limit&start=$start');
    try {
      var responce = await http.get(url, headers: header);
      var data = jsonDecode(responce.body);
      log('friend data is = $data');
      if (data['status'] is Map) {
        SearchUserModel modellist = SearchUserModel.fromJson(data['response']);
        return modellist;
      } else {
        return SearchUserModel();
      }
    } catch (e) {
      print('Exception is = $e');
    }
    return SearchUserModel();
  }

  static Future<List<OneToOneChatModel>> getMessage_list(
      {int? limit, int? start, String? groupID}) async {
    var url = Uri.parse(
        '$baseUrl$getMessage?limit=$limit&start=$start&groupId=$groupID');
    try {
      var responce = await http.get(url, headers: header);
      var data = jsonDecode(responce.body);
      print('message list is this = $data');
      if (data['status']['code'] == 200) {
        List list = data['response'];
        List<OneToOneChatModel> modellist =
            list.map((e) => OneToOneChatModel.fromJson(e)).toList();
        return modellist.reversed.toList();
      } else {
        return [];
      }
    } catch (e) {
      print('Exception is = $e');
    }
    return [];
  }

  static Future<bool> getlogin({Map? map}) async {
    var url = Uri.parse('$loginUrl$login');
    try {
      var responce = await http.post(url, body: map);
      var data = jsonDecode(responce.body);
      LoginModel model = LoginModel.fromJson(data);
      print('data is = $data');
      if (model.status!.code == 200) {
        storage.write('userID', '${data['userId']}');
        storage.write('profile', '${data['profilePic']}');
        storage.write('name', '${data['fullName']}');
        storage.write('token', model.response);
        return true;
      } else {
        snackBarFailer('${data['status']['message']}');
        return false;
      }
    } catch (e) {}
    return false;
  }
}
