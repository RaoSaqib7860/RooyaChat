import 'dart:convert';
import 'dart:developer';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:rooya/ApiConfig/BaseURL.dart';
import 'package:rooya/GlobalWidget/SnackBarApp.dart';
import 'package:rooya/Media/GroupInfoModel.dart';
import 'package:rooya/ModelClasses/GroupModel.dart';
import 'package:rooya/ModelClasses/LoginModel.dart';
import 'package:rooya/Providers/OneToOneModel.dart';
import 'package:rooya/SearchUser/SearchUserModel.dart';

final getGroups = 'getGroups';
final login = 'login/';
final sendMessage = 'sendMessage';
final getMessage = 'getMessage';
final friendList = 'friendList';
final removeGroup = 'removeGroup';
final removeMessage = 'removePost';
final getGroupsById = 'getGroupsById';
final addGroupAdmin = 'addGroupAdmin';
final RemoveAdmin = 'RemoveAdmin';
final addGroupMember = 'addGroupMember';
final deleteMember = 'deleteMember';
final changeGroupName = 'changeGroupName';
final changeGroupImage='changeGroupImage';
GetStorage storage = GetStorage();
Map<String, String> header = {
  'Authorization': 'Basic YWRtaW46MTIzNA==',
  'x-auth-token': '${storage.read('token')}',
};

class ApiUtils {
  static Future changeGroupImagePost({Map? map}) async {
    var url = Uri.parse('$baseUrl$changeGroupImage');
    try {
      var responce = await http.post(url, headers: header, body: map);
      var data = jsonDecode(responce.body);
      print('changeGroupImagePost is = $data');
    } catch (e) {
      print('Exception is = $e');
    }
  }

  static Future changeGroupNamePost({Map? map}) async {
    var url = Uri.parse('$baseUrl$changeGroupName');
    try {
      var responce = await http.post(url, headers: header, body: map);
      var data = jsonDecode(responce.body);
      print('changeGroupNamePost is = $data');
    } catch (e) {
      print('Exception is = $e');
    }
  }

  static Future deleteMemberPost({Map? map}) async {
    var url = Uri.parse('$baseUrl$deleteMember');
    try {
      var responce = await http.post(url, headers: header, body: map);
      var data = jsonDecode(responce.body);
      print('deleteMemberPost is = $data');
    } catch (e) {
      print('Exception is = $e');
    }
  }

  static Future addGroupMemberPost({Map? map}) async {
    var url = Uri.parse('$baseUrl$addGroupMember');
    try {
      var responce = await http.post(url, headers: header, body: map);
      var data = jsonDecode(responce.body);
      print('addGroupMemberPost is = $data');
    } catch (e) {
      print('Exception is = $e');
    }
  }

  static Future addGroupAdminpost({Map? map}) async {
    var url = Uri.parse('$baseUrl$addGroupAdmin');
    try {
      var responce = await http.post(url, headers: header, body: map);
      var data = jsonDecode(responce.body);
      print('addGroupAdminpostdata is = $data');
    } catch (e) {
      print('Exception is = $e');
    }
  }

  static Future RemoveAdminpost({Map? map}) async {
    var url = Uri.parse('$baseUrl$RemoveAdmin');
    try {
      var responce = await http.post(url, headers: header, body: map);
      var data = jsonDecode(responce.body);
      print('RemoveAdminpost is = $data');
    } catch (e) {
      print('Exception is = $e');
    }
  }

  static Future sendMessagepost({Map? map}) async {
    var url = Uri.parse('$baseUrl$sendMessage');
    try {
      var responce = await http.post(url, headers: header, body: map);
      var data = jsonDecode(responce.body);
      print('send message data is = $data');
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
        modellist.removeWhere((element) => element.groupType == 0);
        return modellist;
      } else {
        return [];
      }
    } catch (e) {
      print('Exception is = $e');
    }
    return [];
  }

  static Future<List<GroupModel>> getMainGroup({int? limit, int? start}) async {
    log('token = ${storage.read('token')}');
    var url = Uri.parse('$baseUrl$getGroups?limit=$limit&start=$start');
    try {
      var responce = await http.get(url, headers: header);
      var data = jsonDecode(responce.body);
      log('group data is = $data');
      if (data['status']['code'] == 200) {
        List list = data['response'];
        List<GroupModel> modellist =
            list.map((e) => GroupModel.fromJson(e)).toList();
        modellist.removeWhere((element) => element.groupType == 1);
        return modellist;
      } else {
        return [];
      }
    } catch (e) {
      print('Exception is = $e');
    }
    return [];
  }

  static Future<UserInfoModel> getGroupbyIds(
      {int? limit, int? start, String? groupID}) async {
    var url = Uri.parse('$baseUrl$getGroupsById?groupid=$groupID&limit=$limit&start=$start');
    try {
      var responce = await http.get(url, headers: header);
      var data = jsonDecode(responce.body);
      log('group info Data is = $data');
      if (data['status']['code'] == 200) {
        List list = data['response'];
        list.removeWhere(
            (element) => element['groupId'] != int.parse(groupID!));
        log('Start Adding model');
        UserInfoModel model = UserInfoModel.fromJson(list[0]);
        log('group info Data is = $data');
        return model;
      } else {
        log('group info Data not fine');
        return UserInfoModel();
      }
    } catch (e) {
      print('Exception is = $e');
    }
    return UserInfoModel();
  }

  static createGroup({Map? map}) async {
    var url = Uri.parse('${baseUrl}createGroupByMember');
    try {
      var responce = await http.post(url, headers: header, body: map);
      var data = jsonDecode(responce.body);
      log('createGroupByMember = $data');
    } catch (e) {
      print('Exception is = $e');
    }
  }

  static Future<SearchUserModel> getfriendList({int? limit, int? start}) async {
    var url = Uri.parse(
        'https://cc.rooyatech.com/user/friendList?limit=$limit&start=$start');
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
      print('profile data is = $data');
      LoginModel model = LoginModel.fromJson(data);
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
