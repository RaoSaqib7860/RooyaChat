import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rooya/ApiConfig/ApiUtils.dart';
import 'package:rooya/ApiConfig/SizeConfiq.dart';
import 'package:rooya/GlobalWidget/Photo_View_Class.dart';
import 'package:rooya/Utils/primary_color.dart';

import 'SearchUserController.dart';

bool openSearch = false;

class SearchUser extends StatefulWidget {
  const SearchUser({Key? key}) : super(key: key);

  @override
  _SearchUserState createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  var controller = Get.put(SearchUserController());

  @override
  void initState() {
    openSearch = true;
    controller.getFriendList();
    super.initState();
  }

  bool isloading = false;

  @override
  void dispose() {
    openSearch = false;
    super.dispose();
  }

  int selectedIndex = 0;
  List listOfTab = ['Chats', 'Documents', 'Audio', 'Video', 'links', 'Images'];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 0,
          leading: SizedBox(),
          actions: [
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Center(
                child: Text(
                  'Cancel',
                  style: TextStyle(color: buttonColor),
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size(width, height * 0.030),
            child: TabBar(
              isScrollable: true,
              labelColor: buttonColor,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: buttonColor,
              unselectedLabelColor: Colors.black,
              tabs: listOfTab.map((e) {
                return Column(
                  children: [
                    Text(
                      '$e',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    )
                  ],
                );
              }).toList(),
            ),
          ),
          elevation: 0,
          title: Container(
            height: Get.height * 0.045,
            width: Get.width,
            padding: EdgeInsets.only(left: 10, right: 0),
            child: TextFormField(
              onChanged: (value) {
                // selectController.search.value = value;
                // print('selectController search is = ${selectController.search.value}');
              },
              style: TextStyle(fontSize: 14),
              decoration: InputDecoration(
                disabledBorder: new OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: new BorderSide(
                      color: Colors.black12,
                    )),
                focusedBorder: new OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: new BorderSide(
                      color: Colors.black12,
                    )),
                enabledBorder: new OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: new BorderSide(
                      color: Colors.black12,
                    )),
                border: new OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
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
          backgroundColor: Colors.white,
        ),
        body: TabBarView(
          children: [
            Stack(
              children: [
                Container(
                  height: Get.height,
                  width: Get.width,
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.030,
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
                                        radius: 23,
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
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      // trailing: InkWell(
                                      //   onTap: () async {
                                      //
                                      //   },
                                      //   child: Container(
                                      //     width: Get.width * 0.2,
                                      //     height: Get.height * 0.030,
                                      //     child: Center(
                                      //         child: Text(
                                      //       'Chat',
                                      //       style: TextStyle(
                                      //           fontSize: 10, color: primaryColor),
                                      //     )),
                                      //     decoration: BoxDecoration(
                                      //         border: Border.all(
                                      //             color: primaryColor, width: 1),
                                      //         borderRadius:
                                      //             BorderRadius.circular(30)),
                                      //   ),
                                      // ),
                                      onTap: () async {
                                        Map map = {
                                          'message': '',
                                          'memberId[]':
                                              '${controller.searchUserModel.value.friends![i].userId}'
                                        };
                                        setState(() {
                                          isloading = true;
                                        });
                                        await ApiUtils.sendMessagepost(
                                            map: map);
                                        setState(() {
                                          isloading = false;
                                        });
                                      },
                                    );
                                  },
                                  itemCount: controller
                                      .searchUserModel.value.friends!.length,
                                ),
                        ),
                      )
                    ],
                  ),
                ),
                isloading
                    ? Container(
                        height: Get.height,
                        width: Get.width,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                        decoration:
                            BoxDecoration(color: Colors.black.withOpacity(0.3)),
                      )
                    : SizedBox()
              ],
            ),
            Icon(Icons.music_video),
            Icon(Icons.camera_alt),
            Icon(Icons.grade),
            Icon(Icons.email),
            Icon(Icons.email)
          ],
        ),
      ),
    );
  }
}
