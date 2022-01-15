import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rooya/GlobalWidget/Photo_View_Class.dart';
import 'package:rooya/SearchUser/SearchUserController.dart';
import 'package:rooya/responsive/primary_color.dart';

class SearchUser extends StatefulWidget {
  const SearchUser({Key? key}) : super(key: key);

  @override
  _SearchUserState createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  var controller = Get.put(SearchUserController());

  @override
  void initState() {
    controller.getFriendList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Column(
          children: [
            Container(
              height: Get.height * 0.045,
              width: Get.width,
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.only(left: 10, right: 0),
              child: TextFormField(
                onChanged: (value) {
                  // selectController.search.value = value;
                  // print('selectController search is = ${selectController.search.value}');
                },
                style: TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  disabledBorder: new OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: new BorderSide(
                        color: Colors.black12,
                      )),
                  focusedBorder: new OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: new BorderSide(
                        color: Colors.black12,
                      )),
                  enabledBorder: new OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: new BorderSide(
                        color: Colors.black12,
                      )),
                  border: new OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: new BorderSide(
                        color: Colors.black12,
                      )),
                  isDense: true,
                  hintText: 'Search here ...',
                  hintStyle: TextStyle(fontSize: 10, color: Colors.black),
                  suffixIcon: Icon(
                    Icons.search,
                    size: 20,
                    color: Color(0XFF0BAB0D),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Obx(
                () => controller.searchUserModel.value.friends == null
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemBuilder: (c, i) {
                          return ListTile(
                            leading: CircularProfileAvatar(
                              '${controller.searchUserModel.value.friends![i].profilePictureUrl}',
                              elevation: 2,
                              radius: 20,
                              imageFit: BoxFit.cover,
                              onTap: () {
                                Get.to(Photo_View_Class(
                                  url:
                                      '${controller.searchUserModel.value.friends![i].profilePictureUrl}',
                                ));
                              },
                            ),
                            title: Text(
                              '${controller.searchUserModel.value.friends![i].firstName} ${controller.searchUserModel.value.friends![i].lastName}',
                              style: TextStyle(fontSize: 13),
                            ),
                            trailing: Container(
                              width: Get.width * 0.2,
                              height: Get.height * 0.030,
                              child: Center(
                                  child: Text(
                                'Chat',
                                style: TextStyle(
                                    fontSize: 10, color: primaryColor),
                              )),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: primaryColor, width: 1),
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                          );
                        },
                        itemCount:
                            controller.searchUserModel.value.friends!.length,
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
