import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rooya/ApiConfig/ApiUtils.dart';
import 'package:rooya/ApiConfig/BaseURL.dart';
import 'package:rooya/ApiConfig/SizeConfiq.dart';
import 'package:rooya/Models/FriendsListModel.dart';
import 'package:rooya/Models/GroupModel.dart';
import 'package:rooya/Plugins/FocusedMenu/focused_menu.dart';
import 'package:rooya/Plugins/FocusedMenu/modals.dart';
import 'package:rooya/Utils/primary_color.dart';
import 'package:dio/dio.dart' as dio;
import 'package:rooya/Utils/text_filed/app_font.dart';

import 'GroupInformationProvider.dart';

class GroupInformation extends StatefulWidget {
  final GroupModel? groupModel;
  const GroupInformation({
    Key? key,
    this.groupModel,
  }) : super(key: key);

  @override
  _GroupInformationState createState() => _GroupInformationState();
}

class _GroupInformationState extends State<GroupInformation> {
  bool status = false;
  bool status1 = false;
  GroupModel groupModel = GroupModel();
  var infoController = Get.put(GroupInformationConntroller());

  @override
  void initState() {
    groupModel = widget.groupModel!;
    infoController.getFriendList();
    super.initState();
  }

  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                Container(
                  height: Get.height,
                  width: Get.width,
                  child: Builder(builder: (context) {
                    return CustomScrollView(slivers: [
                      SliverAppBar(
                        backgroundColor: Colors.green,
                        expandedHeight: 200,
                        elevation: 20,
                        //floating: false,
                        pinned: true,
                        //snap: false,
                        leading: IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                        actions: [
                          Visibility(
                            visible: true,
                            child: Container(
                              child: IconButton(
                                  onPressed: () async {
                                    // FilePickerResult? result =
                                    //     await FilePicker.platform
                                    //         .pickFiles(
                                    //   type: FileType.custom,
                                    //   allowedExtensions: [
                                    //     'jpg',
                                    //     'jpeg',
                                    //     'mp4',
                                    //     'png',
                                    //   ],
                                    // );
                                    // if (result!.files.isNotEmpty) {
                                    //   print(
                                    //       'file path is = ${result.files[0].path}');
                                    //   setState(() {
                                    //     isloading = true;
                                    //   });
                                    //   String path = await uploadFile(
                                    //       '${result.files[0].path}');
                                    //   print('upload path is =$path');
                                    //   Map mapdata = {
                                    //     'groupId': '${widget.groupID}',
                                    //     'groupImage': '$path'
                                    //   };
                                    //   await ApiUtils
                                    //       .changeGroupImagePost(
                                    //           map: mapdata);
                                    //   await infoController.getGroupInfo(
                                    //       groupID: widget.groupID);
                                    //   setState(() {
                                    //     isloading = false;
                                    //   });
                                    // }
                                  },
                                  icon: Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.white,
                                  )),
                              margin: EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                  color: buttonColor, shape: BoxShape.circle),
                            ),
                          )
                        ],
                        flexibleSpace: FlexibleSpaceBar(
                          title: Text(
                            '${groupModel.groupName}',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: AppFonts.segoeui,
                                fontWeight: FontWeight.bold),
                          ),
                          centerTitle: false,
                          background: CachedNetworkImage(
                            imageUrl: '${groupModel.avatar}',
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Text(
                                'Hey I\'m using Mersaal',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: AppFonts.segoeui,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.007,
                            ),
                            Container(
                              width: width,
                              height: height * 0.08,
                              //color: Colors.green,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    height: height * 0.06,
                                    width: width * 0.45,
                                    color: Colors.blueGrey[50],
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'Notification',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontFamily: AppFonts.segoeui,
                                          ),
                                        ),
                                        CupertinoSwitch(
                                          value: status,
                                          onChanged: (bool value) {
                                            setState(() {
                                              status = value;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: height * 0.06,
                                    width: width * 0.45,
                                    color: Colors.blueGrey[50],
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'Favorite Message',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontFamily: AppFonts.segoeui,
                                          ),
                                        ),
                                        Icon(
                                          Icons.favorite,
                                          color: Colors.green,
                                          size: 25,
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: width * 0.035),
                              child: Container(
                                height: height * 0.06,
                                width: width * 0.93,
                                color: Colors.blueGrey[50],
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'Auto Save Media to Camera Role',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontFamily: AppFonts.segoeui,
                                      ),
                                    ),
                                    CupertinoSwitch(
                                      value: status1,
                                      onChanged: (bool value) {
                                        setState(() {
                                          status1 = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: height * 0.28,
                              width: width,
                              //color: Colors.blueGrey,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Card(
                                        elevation: 2,
                                        child: Container(
                                          height: height * 0.10,
                                          width: width * 0.45,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color(0x290bab0d),
                                                offset: Offset(0, 3),
                                                blurRadius: 6,
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                height: 40,
                                                width: 40,
                                                //color: Colors.white,
                                                child: SvgPicture.asset(
                                                  'assets/user/g.svg',
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              Text(
                                                'Photos',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily:
                                                        AppFonts.segoeui,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Card(
                                        elevation: 2,
                                        child: Container(
                                          height: height * 0.10,
                                          width: width * 0.45,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color(0x290bab0d),
                                                offset: Offset(0, 3),
                                                blurRadius: 6,
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                height: 25,
                                                width: 50,
                                                //color: Colors.white,
                                                child: SvgPicture.asset(
                                                  'assets/user/d.svg',
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              Text(
                                                'Videos',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily:
                                                        AppFonts.segoeui,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Card(
                                        elevation: 2,
                                        child: Container(
                                          height: height * 0.10,
                                          width: width * 0.45,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color(0x290bab0d),
                                                offset: Offset(0, 3),
                                                blurRadius: 6,
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                height: 40,
                                                width: 40,
                                                //color: Colors.white,
                                                child: SvgPicture.asset(
                                                  'assets/user/l.svg',
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              Text(
                                                'Links',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily:
                                                        AppFonts.segoeui,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Card(
                                        elevation: 2,
                                        child: Container(
                                          height: height * 0.10,
                                          width: width * 0.45,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color(0x290bab0d),
                                                offset: Offset(0, 3),
                                                blurRadius: 6,
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                height: 35,
                                                width: 30,
                                                //color: Colors.white,
                                                child: SvgPicture.asset(
                                                  'assets/user/de.svg',
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              Text(
                                                'Documents',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily:
                                                        AppFonts.segoeui,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: height * 0.08,
                              width: width,
                              // color: Colors.red,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Text(
                                        'Mutual Groups',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontFamily: AppFonts.segoeui,
                                            fontSize: 11,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        '${groupModel.parts!.length} Participants',
                                        style: TextStyle(
                                          fontSize: 9,
                                          fontFamily: AppFonts.segoeui,
                                        ),
                                      ),
                                    ],
                                  ),
                                  groupModel.owner == true
                                      ? InkWell(
                                          onTap: () async {
                                            createGroup(context,
                                                infoController.friendList,
                                                (Map smap) async {
                                              setState(() {
                                                isloading = true;
                                              });
                                              await ApiUtils.addGroupMember(
                                                  map: smap);
                                              setState(() {
                                                isloading = false;
                                              });
                                              GroupModel model =
                                                  await infoController
                                                      .getGroupList(
                                                          groupModel.groupId!);
                                              if (model.groupId != '') {
                                                print('new data coming ');
                                                groupModel = model;
                                              }
                                              setState(() {});
                                            });
                                          },
                                          child: Icon(
                                            Icons.add_circle_rounded,
                                            color: buttonColor,
                                          ),
                                        )
                                      : SizedBox(),
                                  Container(
                                    height: 40,
                                    width: 250,
                                    decoration: BoxDecoration(
                                        color: Colors.blueGrey[50],
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        isDense: true,
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white)),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white)),
                                        hintText: 'Search here ...',
                                        hintStyle: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black54),
                                        suffixIcon: Icon(
                                          Icons.search,
                                          size: 23,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SliverList(
                          delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                        return Column(
                          children: [
                            ListTile(
                              leading: CircularProfileAvatar(
                                '',
                                radius: 23,
                                child: CachedNetworkImage(
                                  imageUrl:
                                      "${groupModel.parts![index].avatar}",
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                              title: Row(
                                children: [
                                  Text(
                                    '${groupModel.parts![index].firstName} ${groupModel.parts![index].lastName}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontFamily: AppFonts.segoeui,
                                        fontSize: 14),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    '(Admin)',
                                    style: TextStyle(
                                        fontFamily: AppFonts.segoeui,
                                        fontSize: 10),
                                  ),
                                ],
                              ),
                              subtitle: Text(
                                '',
                                style: TextStyle(
                                    color: Color(0XFF373737),
                                    fontFamily: AppFonts.segoeui,
                                    fontSize: 12),
                              ),
                              trailing: groupModel.parts![index].userId ==
                                      groupModel.userId
                                  ? Text(
                                      'Admin',
                                      style: TextStyle(
                                          fontFamily: AppFonts.segoeui,
                                          fontSize: 12),
                                    )
                                  : FocusedMenuHolder(
                                      blurSize: 0.1,
                                      menuItemExtent: 45,
                                      menuWidth: width * 0.5,
                                      menuOffset: 0,
                                      openWithTap: true,
                                      blurBackgroundColor:
                                          Colors.white.withOpacity(0.3),
                                      onCneTapMenuItems: !groupModel.owner!
                                          ? <FocusedMenuItem>[
                                              FocusedMenuItem(
                                                  title: Text("Info"),
                                                  onPressed: () {}),
                                            ]
                                          : groupModel.owner!
                                              ? <FocusedMenuItem>[
                                                  FocusedMenuItem(
                                                      title: Text("Info"),
                                                      onPressed: () {}),
                                                  FocusedMenuItem(
                                                      title: Text(
                                                          "Remove from Admin"),
                                                      onPressed: () async {
                                                        setState(() {
                                                          isloading = true;
                                                        });
                                                        Map data = {
                                                          'server_key':
                                                              serverKey,
                                                          'type':
                                                              'remove_admin',
                                                          'id':
                                                              '${groupModel.groupId}',
                                                          'parts':
                                                              '${groupModel.parts![index].userId}'
                                                        };
                                                        print('${{
                                                          'server_key':
                                                              serverKey,
                                                          'type':
                                                              'remove_admin',
                                                          'id':
                                                              '${groupModel.groupId}',
                                                          'parts':
                                                              '${groupModel.parts![index].userId}'
                                                        }}');
                                                        await ApiUtils
                                                            .RemoveAdminpost(
                                                                map: data);
                                                        await infoController
                                                            .getGroupList(
                                                                groupModel
                                                                    .groupId!);
                                                        setState(() {
                                                          isloading = false;
                                                        });
                                                      }),
                                                  FocusedMenuItem(
                                                      title: Text(
                                                          "Remove from Group"),
                                                      onPressed: () async {
                                                        setState(() {
                                                          isloading = true;
                                                        });
                                                        Map data = {
                                                          'server_key':
                                                              serverKey,
                                                          'type': 'remove_user',
                                                          'id':
                                                              '${groupModel.groupId}',
                                                          'parts':
                                                              '${groupModel.parts![index].userId}'
                                                        };
                                                        await ApiUtils
                                                            .RemoveAdminpost(
                                                                map: data);
                                                        await infoController
                                                            .getGroupList(
                                                                groupModel
                                                                    .groupId!);
                                                        setState(() {
                                                          isloading = false;
                                                        });
                                                      }),
                                                ]
                                              : <FocusedMenuItem>[
                                                  FocusedMenuItem(
                                                      title: Text("Info"),
                                                      onPressed: () {}),
                                                  FocusedMenuItem(
                                                      title: Text(
                                                          "Make Group Admin"),
                                                      onPressed: () async {
                                                        setState(() {
                                                          isloading = true;
                                                        });
                                                        Map data = {
                                                          'server_key':
                                                              serverKey,
                                                          'type': 'make_admin',
                                                          'id':
                                                              '${groupModel.groupId}',
                                                          'parts':
                                                              '${groupModel.parts![index].userId}'
                                                        };
                                                        await ApiUtils
                                                            .RemoveAdminpost(
                                                                map: data);
                                                        await infoController
                                                            .getGroupList(
                                                                groupModel
                                                                    .groupId!);
                                                        setState(() {
                                                          isloading = false;
                                                        });
                                                      }),
                                                  FocusedMenuItem(
                                                      title: Text(
                                                          "Remove from Group"),
                                                      onPressed: () async {
                                                        setState(() {
                                                          isloading = true;
                                                        });
                                                        Map data = {
                                                          'server_key':
                                                              serverKey,
                                                          'type': 'remove_user',
                                                          'id':
                                                              '${groupModel.groupId}',
                                                          'parts':
                                                              '${groupModel.parts![index].userId}'
                                                        };
                                                        await ApiUtils
                                                            .RemoveAdminpost(
                                                                map: data);
                                                        await infoController
                                                            .getGroupList(
                                                                groupModel
                                                                    .groupId!);
                                                        setState(() {
                                                          isloading = false;
                                                        });
                                                      }),
                                                ],
                                      onPressed: () {},
                                      child: Icon(
                                        Icons.more_vert,
                                        color: Colors.black,
                                      ),
                                    ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Container(
                              height: 1,
                              color: Colors.black12,
                              margin: EdgeInsets.only(
                                  left: width * 0.23,
                                  right: width * 0.040,
                                  bottom: height * 0.018),
                            ),
                          ],
                        );
                      }, childCount: groupModel.parts!.length))
                    ]);
                  }),
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
            )));
  }

  // TextEditingController groupNameController = TextEditingController();
  // TextEditingController groupDescriptionController = TextEditingController();
  //
  // UpdateInfo(BuildContext context, UserInfoModel model, Function(Map) mapData) {
  //   groupNameController.text = model.groupName ?? '';
  //   groupDescriptionController.text = model.groupDecs ?? '';
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //             insetPadding: EdgeInsets.only(left: 10, right: 10),
  //             content: StatefulBuilder(
  //               builder: (context, setState) {
  //                 return Container(
  //                     height: 500,
  //                     width: 400,
  //                     //color: Colors.green,
  //                     child: Column(children: [
  //                       Text(
  //                         'Update Group Info',
  //                         style: TextStyle(color: Colors.green, fontSize: 16),
  //                       ),
  //                       SizedBox(
  //                         height: 12,
  //                       ),
  //                       SizedBox(
  //                         height: 12,
  //                       ),
  //                       Container(
  //                         width: double.infinity,
  //                         decoration: BoxDecoration(
  //                             color: Color(0XFFF5F5F5),
  //                             borderRadius: BorderRadius.circular(8)),
  //                         child: TextField(
  //                           controller: groupNameController,
  //                           decoration: InputDecoration(
  //                               border: InputBorder.none,
  //                               hintText: 'Group Name',
  //                               hintStyle: TextStyle(
  //                                   fontSize: 13, fontFamily: AppFonts.segoeui),
  //                               contentPadding: EdgeInsets.only(left: 8)),
  //                         ),
  //                       ),
  //                       SizedBox(
  //                         height: 12,
  //                       ),
  //                       Container(
  //                         width: double.infinity,
  //                         padding: EdgeInsets.all(5),
  //                         decoration: BoxDecoration(
  //                             color: Color(0XFFF5F5F5),
  //                             borderRadius: BorderRadius.circular(8)),
  //                         child: TextField(
  //                           controller: groupDescriptionController,
  //                           maxLines: 14,
  //                           decoration: InputDecoration(
  //                               border: InputBorder.none,
  //                               hintText: 'Group Description',
  //                               hintStyle: TextStyle(
  //                                   fontSize: 13, fontFamily: AppFonts.segoeui),
  //                               contentPadding: EdgeInsets.only(left: 8)),
  //                         ),
  //                       ),
  //                       SizedBox(
  //                         height: 14,
  //                       ),
  //                       InkWell(
  //                         onTap: () {
  //                           if (groupNameController.text.trim().isNotEmpty &&
  //                               groupDescriptionController.text
  //                                   .trim()
  //                                   .isNotEmpty) {
  //                             Map map = {
  //                               'groupId': '${model.groupId}',
  //                               'groupName': '${groupNameController.text}',
  //                               'description':
  //                                   '${groupDescriptionController.text}'
  //                             };
  //                             mapData.call(map);
  //                             Navigator.of(context).pop();
  //                           } else {
  //                             snackBarFailer('Please fill up all the fields');
  //                           }
  //                         },
  //                         child: Center(
  //                           child: Container(
  //                             height: height * 0.050,
  //                             width: width * 0.3,
  //                             child: Center(
  //                               child: Text(
  //                                 'Update',
  //                                 style: TextStyle(
  //                                     color: Colors.white,
  //                                     fontSize: 13,
  //                                     fontFamily: AppFonts.segoeui),
  //                               ),
  //                             ),
  //                             decoration: BoxDecoration(
  //                                 color: buttonColor,
  //                                 borderRadius: BorderRadius.circular(30)),
  //                           ),
  //                         ),
  //                       )
  //                     ]));
  //               },
  //             ));
  //       });
  // }
  //
  createGroup(BuildContext context, List<Following> friendsList,
      Function(Map) mapData) {
    TextEditingController groupNameController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              insetPadding: EdgeInsets.only(left: 10, right: 10),
              content: StatefulBuilder(
                builder: (context, setState) {
                  return Container(
                      height: 500,
                      width: 400,
                      //color: Colors.green,
                      child: Column(children: [
                        Text(
                          'Select Friend',
                          style: TextStyle(color: Colors.green, fontSize: 16),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          height: 300,
                          color: Colors.white,
                          child: friendsList.isEmpty
                              ? Center(
                                  child: Text('Empty list'),
                                )
                              : ListView.builder(
                                  itemCount: friendsList.length,
                                  itemBuilder: (context, i) => Column(
                                    children: [
                                      ListTile(
                                        leading: CircularProfileAvatar(
                                          '',
                                          radius: 23,
                                          child: Image.network(
                                            '${friendsList[i].avatar}',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        title: Text(
                                          '${friendsList[i].firstName} ${friendsList[i].lastName}',
                                          style: TextStyle(
                                              fontFamily: AppFonts.segoeui,
                                              fontSize: 13),
                                        ),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            InkWell(
                                              child: Container(
                                                height: 25,
                                                width: 60,
                                                child: Center(
                                                    child: Text(
                                                  'Add',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily:
                                                          AppFonts.segoeui,
                                                      fontSize: 11),
                                                )),
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    border: Border.all(
                                                        color: Colors.green,
                                                        width: 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                              ),
                                              onTap: () {
                                                Map data = {
                                                  'server_key': serverKey,
                                                  'type': 'add_user',
                                                  'id': '${groupModel.groupId}',
                                                  'parts':
                                                      '${friendsList[i].userId}'
                                                };
                                                mapData.call(data);
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ]));
                },
              ));
        });
  }

  Widget userinfoData({String? name, String? detaisl}) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.05,
          ),
          child: Row(
            children: [
              Text(
                '$name',
                style: TextStyle(
                    fontFamily: AppFonts.segoeui,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                '$detaisl',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: AppFonts.segoeui,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
