import 'package:get/get.dart';
import 'package:rooya/ApiConfig/ApiUtils.dart';
import 'package:rooya/SearchUser/SearchUserModel.dart';

class SearchUserController extends GetxController {
  var searchUserModel = SearchUserModel().obs;

  getFriendList()async{
    searchUserModel.value=await ApiUtils.getfriendList(limit: 50,start: 0);
  }
}
