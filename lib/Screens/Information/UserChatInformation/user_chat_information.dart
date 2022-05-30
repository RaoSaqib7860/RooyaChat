import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rooya/ApiConfig/SizeConfiq.dart';
import 'package:rooya/Utils/primary_color.dart';
import 'package:dio/dio.dart' as dio;
import 'package:rooya/Utils/text_filed/app_font.dart';
import 'UserChatInformationController.dart';

class UserChatInformation extends StatefulWidget {
  final String? userID;

  const UserChatInformation({
    Key? key,
    this.userID,
  }) : super(key: key);

  @override
  _UserChatInformationState createState() => _UserChatInformationState();
}

class _UserChatInformationState extends State<UserChatInformation> {
  bool status = false;
  bool status1 = false;

  var infoController = Get.put(UserChatInformationConntroller());

  @override
  void initState() {
    infoController.getGroupInfo(userID: widget.userID);
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
                  child: Obx(
                    () => !infoController.loadData.value
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Builder(builder: (context) {
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
                                          color: buttonColor,
                                          shape: BoxShape.circle),
                                    ),
                                  )
                                ],
                                flexibleSpace: FlexibleSpaceBar(
                                  titlePadding: EdgeInsets.only(
                                      top: 2, left: 50, bottom: 2),
                                  title: Row(
                                    children: [
                                      CircularProfileAvatar(
                                        '',
                                        onTap: () {},
                                        radius: 25,
                                        backgroundColor: Colors.blueGrey[100]!,
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              '${infoController.infoModel.value.userData!.avatar}',
                                          placeholder: (context, url) => Center(
                                              child:
                                                  CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.person),
                                          fit: BoxFit.cover,
                                        ),
                                        imageFit: BoxFit.cover,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '${infoController.infoModel.value.userData!.firstName} ' +
                                            '${infoController.infoModel.value.userData!.lastName}',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: AppFonts.segoeui,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  centerTitle: false,
                                  background: CachedNetworkImage(
                                    imageUrl:
                                        '${infoController.infoModel.value.userData!.cover}',
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator()),
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
                                      '${infoController.infoModel.value.userData!.about == 'null' ? 'Hey I\'m using Mersaal' : infoController.infoModel.value.userData!.about}',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontFamily: AppFonts.segoeui,
                                      ),
                                    ),
                                  ),
                                    userinfoData(
                                        name: 'Gender :',
                                        detaisl: '${infoController.infoModel.value.userData!.gender??''}'),
                                    userinfoData(
                                        name: 'Address :',
                                        detaisl: '${infoController.infoModel.value.userData!.address??''}'),
                                    userinfoData(
                                        name: 'birthday :',
                                        detaisl: '${infoController.infoModel.value.userData!.birthday??''}'),
                                    userinfoData(
                                        name: 'Facebook :',
                                        detaisl: '${infoController.infoModel.value.userData!.facebook??''}'),
                                    userinfoData(
                                        name: 'Twitter :',
                                        detaisl: '${infoController.infoModel.value.userData!.twitter??''}'),
                                    userinfoData(
                                        name: 'Linkedin :',
                                        detaisl: '${infoController.infoModel.value.userData!.linkedin??''}'),
                                    userinfoData(
                                        name: 'Instagram :',
                                        detaisl: '${infoController.infoModel.value.userData!.instagram??''}'),
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
                                                    fontFamily:
                                                        AppFonts.segoeui,
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
                                                    fontFamily:
                                                        AppFonts.segoeui,
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
                                      padding:
                                          EdgeInsets.only(left: width * 0.035),
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
                                                        color: const Color(
                                                            0x290bab0d),
                                                        offset: Offset(0, 3),
                                                        blurRadius: 6,
                                                      ),
                                                    ],
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
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
                                                            fontFamily: AppFonts
                                                                .segoeui,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
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
                                                        color: const Color(
                                                            0x290bab0d),
                                                        offset: Offset(0, 3),
                                                        blurRadius: 6,
                                                      ),
                                                    ],
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
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
                                                            fontFamily: AppFonts
                                                                .segoeui,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
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
                                                        color: const Color(
                                                            0x290bab0d),
                                                        offset: Offset(0, 3),
                                                        blurRadius: 6,
                                                      ),
                                                    ],
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
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
                                                            fontFamily: AppFonts
                                                                .segoeui,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
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
                                                        color: const Color(
                                                            0x290bab0d),
                                                        offset: Offset(0, 3),
                                                        blurRadius: 6,
                                                      ),
                                                    ],
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
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
                                                            fontFamily: AppFonts
                                                                .segoeui,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
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
                                    // !widget.fromGroup!
                                    //     ? SizedBox()
                                    //     : Container(
                                    //         height: height * 0.08,
                                    //         width: width,
                                    //         // color: Colors.red,
                                    //         child: Row(
                                    //           mainAxisAlignment:
                                    //               MainAxisAlignment.spaceEvenly,
                                    //           children: [
                                    //             Column(
                                    //               crossAxisAlignment:
                                    //                   CrossAxisAlignment.start,
                                    //               children: [
                                    //                 SizedBox(
                                    //                   height: 7,
                                    //                 ),
                                    //                 Text(
                                    //                   'Mutual Groups',
                                    //                   style: TextStyle(
                                    //                       fontWeight:
                                    //                           FontWeight.w500,
                                    //                       fontFamily:
                                    //                           AppFonts.segoeui,
                                    //                       fontSize: 11,
                                    //                       color: Colors.black),
                                    //                 ),
                                    //                 Text(
                                    //                   '${infoController.infoModel.value.members!.length} Groups',
                                    //                   style: TextStyle(
                                    //                     fontSize: 9,
                                    //                     fontFamily:
                                    //                         AppFonts.segoeui,
                                    //                   ),
                                    //                 ),
                                    //               ],
                                    //             ),
                                    //             infoController.listofFriends
                                    //                     .contains(int.parse(
                                    //                         storage.read(
                                    //                             'userID')))
                                    //                 ? InkWell(
                                    //                     onTap: () async {
                                    //                       setState(() {
                                    //                         isloading = true;
                                    //                       });
                                    //                       await infoController
                                    //                           .getFriendList();
                                    //                       setState(() {
                                    //                         isloading = false;
                                    //                       });
                                    //                       createGroup(
                                    //                           context,
                                    //                           infoController
                                    //                               .searchUserModel
                                    //                               .value,
                                    //                           (Map smap) async {
                                    //                         setState(() {
                                    //                           isloading = true;
                                    //                         });
                                    //                         await ApiUtils
                                    //                             .addGroupMemberPost(
                                    //                                 map: smap);
                                    //                         setState(() {
                                    //                           isloading = false;
                                    //                         });
                                    //                         await infoController
                                    //                             .getGroupInfo(
                                    //                                 groupID: widget
                                    //                                     .groupID);
                                    //                         setState(() {});
                                    //                         print(
                                    //                             'Over all object is = $smap');
                                    //                       });
                                    //                     },
                                    //                     child: Icon(
                                    //                       Icons
                                    //                           .add_circle_rounded,
                                    //                       color: buttonColor,
                                    //                     ),
                                    //                   )
                                    //                 : SizedBox(),
                                    //             Container(
                                    //               height: 40,
                                    //               width: 250,
                                    //               decoration: BoxDecoration(
                                    //                   color:
                                    //                       Colors.blueGrey[50],
                                    //                   borderRadius:
                                    //                       BorderRadius.circular(
                                    //                           30)),
                                    //               child: TextField(
                                    //                 decoration: InputDecoration(
                                    //                   isDense: true,
                                    //                   enabledBorder:
                                    //                       OutlineInputBorder(
                                    //                           borderSide: BorderSide(
                                    //                               color: Colors
                                    //                                   .white)),
                                    //                   focusedBorder:
                                    //                       OutlineInputBorder(
                                    //                           borderSide: BorderSide(
                                    //                               color: Colors
                                    //                                   .white)),
                                    //                   border: OutlineInputBorder(
                                    //                       borderSide:
                                    //                           BorderSide(
                                    //                               color: Colors
                                    //                                   .white)),
                                    //                   hintText:
                                    //                       'Search here ...',
                                    //                   hintStyle: TextStyle(
                                    //                       fontSize: 12,
                                    //                       color:
                                    //                           Colors.black54),
                                    //                   suffixIcon: Icon(
                                    //                     Icons.search,
                                    //                     size: 23,
                                    //                     color: Colors.green,
                                    //                   ),
                                    //                 ),
                                    //               ),
                                    //             ),
                                    //           ],
                                    //         ),
                                    //       )
                                  ],
                                ),
                              ),
                              // !widget.fromGroup!
                              //     ? SliverToBoxAdapter()
                              //     : SliverList(
                              //         delegate: SliverChildBuilderDelegate(
                              //             (BuildContext context, int index) {
                              //         return Column(
                              //           children: [
                              //             ListTile(
                              //               leading: CircularProfileAvatar(
                              //                 '',
                              //                 radius: 23,
                              //                 child: CachedNetworkImage(
                              //                   imageUrl:
                              //                       "${infoController.infoModel.value.members![index].profilePictureUrl}",
                              //                   fit: BoxFit.cover,
                              //                   placeholder: (context, url) =>
                              //                       CircularProgressIndicator(),
                              //                   errorWidget:
                              //                       (context, url, error) =>
                              //                           Icon(Icons.error),
                              //                 ),
                              //               ),
                              //               title: Row(
                              //                 children: [
                              //                   Text(
                              //                     '${infoController.infoModel.value.members![index].firstName} ${infoController.infoModel.value.members![index].lastName}',
                              //                     style: TextStyle(
                              //                         fontWeight:
                              //                             FontWeight.w700,
                              //                         fontFamily:
                              //                             AppFonts.segoeui,
                              //                         fontSize: 14),
                              //                   ),
                              //                   SizedBox(
                              //                     width: 10,
                              //                   ),
                              //                   Text(
                              //                     infoController
                              //                                 .infoModel
                              //                                 .value
                              //                                 .members![index]
                              //                                 .isadmin! &&
                              //                             infoController
                              //                                     .infoModel
                              //                                     .value
                              //                                     .members![
                              //                                         index]
                              //                                     .userId
                              //                                     .toString() !=
                              //                                 '${infoController.infoModel.value.groupAdmin}'
                              //                         ? '(Admin)'
                              //                         : '',
                              //                     style: TextStyle(
                              //                         fontFamily:
                              //                             AppFonts.segoeui,
                              //                         fontSize: 10),
                              //                   ),
                              //                 ],
                              //               ),
                              //               // subtitle: Text(
                              //               //   '',
                              //               //   style: TextStyle(
                              //               //       color: Color(0XFF373737),
                              //               //       fontFamily: AppFonts.segoeui,
                              //               //       fontSize: 12),
                              //               // ),
                              //               trailing: infoController
                              //                           .infoModel
                              //                           .value
                              //                           .members![index]
                              //                           .userId
                              //                           .toString() ==
                              //                       '${infoController.infoModel.value.groupAdmin}'
                              //                   ? Text(
                              //                       'Admin',
                              //                       style: TextStyle(
                              //                           fontFamily:
                              //                               AppFonts.segoeui,
                              //                           fontSize: 12),
                              //                     )
                              //                   : FocusedMenuHolder(
                              //                       blurSize: 0.1,
                              //                       menuItemExtent: 45,
                              //                       menuWidth: width * 0.5,
                              //                       menuOffset: 0,
                              //                       openWithTap: true,
                              //                       blurBackgroundColor: Colors
                              //                           .white
                              //                           .withOpacity(0.3),
                              //                       onCneTapMenuItems: !infoController
                              //                               .listofFriends
                              //                               .contains(int.parse(
                              //                                   storage.read(
                              //                                       'userID')))
                              //                           ? <FocusedMenuItem>[
                              //                               FocusedMenuItem(
                              //                                   title: Text(
                              //                                       "Info"),
                              //                                   onPressed:
                              //                                       () {}),
                              //                             ]
                              //                           : infoController
                              //                                   .infoModel
                              //                                   .value
                              //                                   .members![index]
                              //                                   .isadmin!
                              //                               ? <FocusedMenuItem>[
                              //                                   FocusedMenuItem(
                              //                                       title: Text(
                              //                                           "Info"),
                              //                                       onPressed:
                              //                                           () {}),
                              //                                   FocusedMenuItem(
                              //                                       title: Text(
                              //                                           "Remove from Admin"),
                              //                                       onPressed:
                              //                                           () async {
                              //                                         setState(
                              //                                             () {
                              //                                           isloading =
                              //                                               true;
                              //                                         });
                              //                                         Map map =
                              //                                             {
                              //                                           'groupId':
                              //                                               '${infoController.infoModel.value.groupId}',
                              //                                           'memberId':
                              //                                               '${infoController.infoModel.value.members![index].userId}',
                              //                                         };
                              //                                         await ApiUtils
                              //                                             .RemoveAdminpost(
                              //                                                 map: map);
                              //                                         await infoController.getGroupInfo(
                              //                                             groupID:
                              //                                                 widget.groupID);
                              //                                         setState(
                              //                                             () {
                              //                                           isloading =
                              //                                               false;
                              //                                         });
                              //                                       }),
                              //                                   FocusedMenuItem(
                              //                                       title: Text(
                              //                                           "Remove from Group"),
                              //                                       onPressed:
                              //                                           () async {
                              //                                         Map data =
                              //                                             {
                              //                                           'groupId':
                              //                                               '${infoController.infoModel.value.groupId}',
                              //                                           'memberId':
                              //                                               '${infoController.infoModel.value.members![index].userId}'
                              //                                         };
                              //                                         setState(
                              //                                             () {
                              //                                           isloading =
                              //                                               true;
                              //                                         });
                              //                                         await ApiUtils
                              //                                             .deleteMemberPost(
                              //                                                 map: data);
                              //                                         await infoController.getGroupInfo(
                              //                                             groupID:
                              //                                                 widget.groupID);
                              //                                         isloading =
                              //                                             false;
                              //                                         setState(
                              //                                             () {});
                              //                                       }),
                              //                                 ]
                              //                               : <FocusedMenuItem>[
                              //                                   FocusedMenuItem(
                              //                                       title: Text(
                              //                                           "Info"),
                              //                                       onPressed:
                              //                                           () {}),
                              //                                   FocusedMenuItem(
                              //                                       title: Text(
                              //                                           "Make Group Admin"),
                              //                                       onPressed:
                              //                                           () async {
                              //                                         setState(
                              //                                             () {
                              //                                           isloading =
                              //                                               true;
                              //                                         });
                              //                                         Map map =
                              //                                             {
                              //                                           'groupId':
                              //                                               '${infoController.infoModel.value.groupId}',
                              //                                           'userId[]':
                              //                                               '${infoController.infoModel.value.members![index].userId}',
                              //                                           'memberId[]':
                              //                                               '${infoController.infoModel.value.members![index].userId}',
                              //                                         };
                              //                                         await ApiUtils
                              //                                             .addGroupAdminpost(
                              //                                                 map: map);
                              //                                         await infoController.getGroupInfo(
                              //                                             groupID:
                              //                                                 widget.groupID);
                              //                                         isloading =
                              //                                             false;
                              //                                         setState(
                              //                                             () {});
                              //                                       }),
                              //                                   FocusedMenuItem(
                              //                                       title: Text(
                              //                                           "Remove from Group"),
                              //                                       onPressed:
                              //                                           () async {
                              //                                         Map data =
                              //                                             {
                              //                                           'groupId':
                              //                                               '${infoController.infoModel.value.groupId}',
                              //                                           'memberId':
                              //                                               '${infoController.infoModel.value.members![index].userId}'
                              //                                         };
                              //                                         setState(
                              //                                             () {
                              //                                           isloading =
                              //                                               true;
                              //                                         });
                              //                                         await ApiUtils
                              //                                             .deleteMemberPost(
                              //                                                 map: data);
                              //                                         await infoController.getGroupInfo(
                              //                                             groupID:
                              //                                                 widget.groupID);
                              //                                         isloading =
                              //                                             false;
                              //                                         setState(
                              //                                             () {});
                              //                                       }),
                              //                                 ],
                              //                       onPressed: () {},
                              //                       child: Icon(
                              //                         Icons.more_vert,
                              //                         color: Colors.black,
                              //                       ),
                              //                     ),
                              //             ),
                              //             SizedBox(
                              //               height: 4,
                              //             ),
                              //             Container(
                              //               height: 1,
                              //               color: Colors.black12,
                              //               margin: EdgeInsets.only(
                              //                   left: width * 0.23,
                              //                   right: width * 0.040,
                              //                   bottom: height * 0.018),
                              //             ),
                              //           ],
                              //         );
                              //       },
                              //             childCount: infoController
                              //                 .infoModel.value.members!.length))
                            ]);
                          }),
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
  // createGroup(
  //     BuildContext context, SearchUserModel model, Function(Map) mapData) {
  //   TextEditingController groupNameController = TextEditingController();
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
  //                         'Select Friend',
  //                         style: TextStyle(color: Colors.green, fontSize: 16),
  //                       ),
  //                       SizedBox(
  //                         height: 12,
  //                       ),
  //                       SizedBox(
  //                         height: 12,
  //                       ),
  //                       Container(
  //                         height: 300,
  //                         color: Colors.white,
  //                         child: model.friends == null
  //                             ? Center(
  //                                 child: Text('Empty list'),
  //                               )
  //                             : ListView.builder(
  //                                 itemCount: model.friends!.length,
  //                                 itemBuilder: (context, i) => Column(
  //                                   children: [
  //                                     ListTile(
  //                                       leading: CircularProfileAvatar(
  //                                         '',
  //                                         radius: 23,
  //                                         child: Image.network(
  //                                           '${model.friends![i].profilePictureUrl}',
  //                                           fit: BoxFit.cover,
  //                                         ),
  //                                       ),
  //                                       title: Text(
  //                                         '${model.friends![i].firstName} ${model.friends![i].lastName}',
  //                                         style: TextStyle(
  //                                             fontFamily: AppFonts.segoeui,
  //                                             fontSize: 13),
  //                                       ),
  //                                       trailing: Row(
  //                                         mainAxisSize: MainAxisSize.min,
  //                                         children: [
  //                                           InkWell(
  //                                             child: Container(
  //                                               height: 25,
  //                                               width: 60,
  //                                               child: Center(
  //                                                   child: Text(
  //                                                 'Add',
  //                                                 style: TextStyle(
  //                                                     color: Colors.white,
  //                                                     fontFamily:
  //                                                         AppFonts.segoeui,
  //                                                     fontSize: 11),
  //                                               )),
  //                                               decoration: BoxDecoration(
  //                                                   color: Colors.green,
  //                                                   border: Border.all(
  //                                                       color: Colors.green,
  //                                                       width: 1),
  //                                                   borderRadius:
  //                                                       BorderRadius.circular(
  //                                                           20)),
  //                                             ),
  //                                             onTap: () {
  //                                               Map data = {
  //                                                 'groupId':
  //                                                     '${infoController.infoModel.value.groupId}',
  //                                                 'userId[]':
  //                                                     '${model.friends![i].userId}'
  //                                               };
  //                                               mapData.call(data);
  //                                               Navigator.of(context).pop();
  //                                             },
  //                                           ),
  //                                         ],
  //                                       ),
  //                                     ),
  //                                     SizedBox(
  //                                       height: 8,
  //                                     ),
  //                                   ],
  //                                 ),
  //                               ),
  //                       ),
  //                       SizedBox(
  //                         height: 18,
  //                       ),
  //                       // InkWell(
  //                       //   onTap: () async {
  //                       //     if (listofmap.isNotEmpty) {
  //                       //       if (groupNameController.text.trim().isNotEmpty) {
  //                       //         Map smap = {};
  //                       //         String ids = '';
  //                       //         for (var i in listofmap) {
  //                       //           ids = ids + '$i,';
  //                       //         }
  //                       //         smap.addAll({
  //                       //           'memberId[]':
  //                       //           ids.substring(0, ids.length - 1).trim()
  //                       //         });
  //                       //         smap.addAll(
  //                       //             {'g_name': '${groupNameController.text}'});
  //                       //         smap.addAll({'description': ''});
  //                       //         mapData.call(smap);
  //                       //         Navigator.of(context).pop();
  //                       //       } else {
  //                       //         snackBarFailer('Please Add Group name First');
  //                       //       }
  //                       //     } else {
  //                       //       snackBarFailer(
  //                       //           'Please select group member first');
  //                       //     }
  //                       //   },
  //                       //   child: Container(
  //                       //     height: 40,
  //                       //     width: 130,
  //                       //     child: Center(
  //                       //       child: Text(
  //                       //         'CREATE',
  //                       //         style: TextStyle(
  //                       //             color: Colors.white,
  //                       //             fontSize: 15,
  //                       //             fontFamily: AppFonts.segoeui),
  //                       //       ),
  //                       //     ),
  //                       //     decoration: BoxDecoration(
  //                       //       borderRadius: BorderRadius.circular(12),
  //                       //       color: Color(0XFF0BAB0D),
  //                       //     ),
  //                       //   ),
  //                       // ),
  //                     ]));
  //               },
  //             ));
  //       });
  // }
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
