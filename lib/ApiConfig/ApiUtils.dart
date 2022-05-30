import 'dart:convert';
import 'dart:developer';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:rooya/ApiConfig/BaseURL.dart';
import 'package:rooya/GlobalWidget/SnackBarApp.dart';
import 'package:rooya/Models/LoginModel.dart';
import 'package:rooya/Models/FriendsListModel.dart';
import 'package:rooya/Models/GroupChatModel.dart';
import 'package:rooya/Models/GroupModel.dart';
import 'package:rooya/Models/OneTwoOneOuterModel.dart';
import 'package:rooya/Models/UserChatModel.dart';
import 'package:rooya/Models/UserDataModel.dart';
import 'package:rooya/Models/UserStoriesModel.dart';
import 'package:rooya/Screens/SearchUser/SearchUserModel.dart';
import 'package:rooya/Screens/UserChat/Media/GroupInfoModel.dart';
import 'package:rooya/Utils/UserDataService.dart';

final getChat = 'get_chats';
final getroomListChat = 'group_chat';
final allStories = 'get-user-stories';
final getRoom = 'group_chat';
final getGroupChat = 'group_chat';
final login = 'auth';
final userData = 'get-user-data';
final sendMessage = 'send-message';
final getMessage = 'get_user_messages';
final friendList = 'get-friends';
final create_group = 'group_chat';
final addMemberToGroup = 'group_chat';
final removeGroup = 'removeGroup';
final removeMessage = 'removePost';
final getGroupsById = 'getGroupsById';
final addGroupAdmin = 'group_chat';
final RemoveAdmin = 'RemoveAdmin';
final addGroupMember = 'addGroupMember';
final deleteMember = 'deleteMember';
final changeGroupName = 'changeGroupName';
final changeGroupImage = 'changeGroupImage';
final blockGroup = 'blockGroup';
final unblockGroup = 'unblockGroup';

GetStorage storage = GetStorage();
Map<String, String> header = {
  'Authorization': 'Basic YWRtaW46MTIzNA==',
  'x-auth-token': '${storage.read('token')}',
};
String token = '?access_token=${storage.read('token')}';

class ApiUtils {
  static Future blockUser({Map? map}) async {
    var url = Uri.parse('$baseUrl$blockGroup');
    try {
      var responce = await http.post(url, headers: header, body: map);
      var data = jsonDecode(responce.body);
      print('blockGroup is = $data');
    } catch (e) {
      print('Exception is = $e');
    }
  }

  static Future unblockUser({Map? map}) async {
    var url = Uri.parse('$baseUrl$unblockGroup');
    try {
      var responce = await http.post(url, headers: header, body: map);
      var data = jsonDecode(responce.body);
      print('unblockGroup is = $data');
    } catch (e) {
      print('Exception is = $e');
    }
  }

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
    print('RemoveAdminpost request = ${map}');
    var url = Uri.parse('$baseUrl$addGroupAdmin$token');
    try {
      var responce = await http.post(url, body: map);
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

  static Future<String> newsendMessagepost({Map? map}) async {
    String groupid = '';
    var url = Uri.parse('$baseUrl$sendMessage');
    try {
      var responce = await http.post(url, headers: header, body: map);
      var data = jsonDecode(responce.body);
      print('send message data is = $data');
      if (data['status']['code'] == 200) {
        groupid = data['response']['groupId'].toString();
        return groupid;
      } else {}
      return groupid;
    } catch (e) {
      print('Exception is = $e');
    }
    return groupid;
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

  static Future<OneToOneChatOuterModel> getGroup(
      {int? limit, int? start, Map? mapData}) async {
    var url = Uri.parse('$baseUrl$getChat$token');
    try {
      var responce = await http.post(url, body: mapData);
      var data = jsonDecode(responce.body);
      // print('Chat data is = $data');
      print('Chat data is = ${data['api_status']}');
      if (data['api_status'] == 200) {
        print('in 200 now');
        OneToOneChatOuterModel modellist =
            OneToOneChatOuterModel.fromJson(data);
        return modellist;
      } else {
        return OneToOneChatOuterModel(apiStatus: 400);
      }
    } catch (e) {
      print('Exception is = $e');
    }
    return OneToOneChatOuterModel(apiStatus: 400);
  }

  static Future<List<GroupModel>> getMainGroup(
      {int? limit, int? start, Map? mapData}) async {
    var url = Uri.parse('$baseUrl$getChat$token');
    try {
      var responce = await await http.post(url, body: mapData);
      var data = jsonDecode(responce.body);
      // print('group data is = $data');
      if (data['api_status'] == 200) {
        List list = data['data'];
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

  static Future<List<GroupModel>> getAllRoomData({Map? mapData}) async {
    var url = Uri.parse('$baseUrl$getroomListChat$token');
    try {
      var responce = await await http.post(url, body: mapData);
      var data = jsonDecode(responce.body);
      print('room data = $data');
      if (data['api_status'] == 200) {
        List list = data['data'];
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

  static Future<List<UserStoryModel>> getAllStoriesData({Map? mapData}) async {
    var url = Uri.parse('$baseUrl$allStories$token');
    try {
      var responce = await await http.post(url, body: mapData);
      var data = jsonDecode(responce.body);
      print('stories data = $data');
      if (data['api_status'] == 200) {
        List list = data['stories'];
        List<UserStoryModel> modellist =
            list.map((e) => UserStoryModel.fromJson(e)).toList();
        return modellist;
      } else {
        return [];
      }
    } catch (e) {
      print('Exception is = $e');
    }
    return [];
  }

  static Future<bool> joinRoom({Map? mapData}) async {
    var url = Uri.parse('$baseUrl$getGroupChat$token');
    try {
      var responce = await await http.post(url, body: mapData);
      var data = jsonDecode(responce.body);
      print('join room data = $data');
      if (data['api_status'] == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Exception is = $e');
    }
    return false;
  }

  static Future<List<GroupModel>> getMainRoom(
      {int? limit, int? start, Map? mapData}) async {
    var url = Uri.parse('$baseUrl$getRoom$token');
    try {
      var responce = await await http.post(url, body: mapData);
      var data = jsonDecode(responce.body);
      // print('group data is = $data');
      if (data['api_status'] == 200) {
        List list = data['data'];
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

  static Future<UserInfoModel> getUserInfo(
      {int? limit, int? start, String? userID}) async {
    var url = Uri.parse('$baseUrl$userData$token');
    try {
      var responce = await http.post(url, body: {
        'server_key': serverKey,
        'fetch': 'user_data',
        'user_id': userID
      });
      var data = jsonDecode(responce.body);
      print('user info Data is = $data');
      if (data['api_status'] == 200) {
        UserInfoModel model = UserInfoModel.fromJson(data);
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
    var url = Uri.parse('$baseUrl$create_group$token');
    try {
      var responce = await http.post(url, body: map);
      var data = jsonDecode(responce.body);
      print('createGroupByMember = $data');
    } catch (e) {
      print('Exception is = $e');
    }
  }

  static addGroupMember({Map? map}) async {
    var url = Uri.parse('$baseUrl$addMemberToGroup$token');
    try {
      var responce = await http.post(url, body: map);
      var data = jsonDecode(responce.body);
      print('addGroupMember = $data');
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

  static Future<List<Following>> allFriendList({int? limit, int? start}) async {
    var url = Uri.parse('$baseUrl$friendList$token');
    try {
      var responce = await http.post(url, body: {
        'server_key': serverKey,
        'type': 'followers,following',
        'user_id': '${UserDataService.userDataModel!.userData!.userId}'
      });
      var data = jsonDecode(responce.body);
      log('friend data is = $data');
      if (data['api_status'] == 200) {
        FriendsListModel modellist = FriendsListModel.fromJson(data);
        return modellist.data!.following!;
      } else {
        return [];
      }
    } catch (e) {
      print('Exception is = $e');
    }
    return [];
  }

  static Future<List<Messages>> getMessage_list(
      {int? limit, int? start, Map? map}) async {
    var url = Uri.parse('$baseUrl$getMessage$token');
    try {
      var responce = await http.post(url, body: map);
      var data = jsonDecode(responce.body);
      print('message list is this = $data');
      if (data['api_status'] == 200) {
        UserChatModel modellist = UserChatModel.fromJson(data)
          ..messages!.reversed;
        return modellist.messages!;
      } else {
        return UserChatModel(apiStatus: 400, messages: []).messages!;
      }
    } catch (e) {
      print('Exception is = $e');
    }
    return UserChatModel(apiStatus: 400, messages: []).messages!;
  }

  static Future sendMessagetoUser({Map? map}) async {
    var url = Uri.parse('$baseUrl$sendMessage$token');
    try {
      var responce = await http.post(url, body: map);
      var data = jsonDecode(responce.body);
      print('send message is = $data');
    } catch (e) {
      print('Exception is = $e');
    }
  }

  static Future<List<Messages>> getMessage_list_forGroup(
      {int? limit, int? start, Map? map}) async {
    var url = Uri.parse('$baseUrl$getGroupChat$token');
    try {
      var responce = await http.post(url, body: map);
      var data = jsonDecode(responce.body);
      print('message list is this = $data');
      if (data['api_status'] == 200) {
        GroupChatModel modellist = GroupChatModel.fromJson(data)
          ..data!.messages!.reversed;
        return modellist.data!.messages!;
      } else {
        return UserChatModel(apiStatus: 400, messages: []).messages!;
      }
    } catch (e) {
      print('Exception is = $e');
    }
    return UserChatModel(apiStatus: 400, messages: []).messages!;
  }

  static Future<bool> getlogin({Map? map}) async {
    var url = Uri.parse('$baseUrl$login');
    print('hit login');
    try {
      var responce = await http.post(url, body: map);
      var data = jsonDecode(responce.body);
      print('profile data is = $data');
      if (data['api_status'] == 200) {
        LoginModel model = LoginModel.fromJson(data);
        storage.write('userID', model.userId);
        // storage.write('profile', '${data['profilePic']}');
        // storage.write('name', '${data['fullName']}');
        storage.write('token', model.accessToken);
        return true;
      } else {
        snackBarFailer('${data['status']['message']}');
        return false;
      }
    } catch (e) {}
    return false;
  }

  static Future<bool> getUserData({Map? map}) async {
    var url = Uri.parse('$baseUrl$userData$token');
    try {
      var responce = await http.post(url, body: map);
      var data = jsonDecode(responce.body);
      print('profile data is = $data');
      if (data['api_status'] == 200) {
        UserDataService.userDataModel = UserDataModel.fromJson(data);
        storage.write(
            'userData', jsonEncode(UserDataService.userDataModel!.toJson()));
        return true;
      } else {
        snackBarFailer('${data['status']['message']}');
        return false;
      }
    } catch (e) {}
    return false;
  }
}
