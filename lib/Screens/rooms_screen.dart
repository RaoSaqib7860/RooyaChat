import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:intl/intl.dart';
import 'package:rooya/ApiConfig/ApiUtils.dart';
import 'package:rooya/ApiConfig/BaseURL.dart';
import 'package:rooya/GlobalWidget/Photo_View_Class.dart';
import 'package:rooya/GlobalWidget/SnackBarApp.dart';
import 'package:rooya/Models/FriendsListModel.dart';
import 'package:rooya/Models/GroupModel.dart';
import 'package:rooya/Plugins/FocusedMenu/focused_menu.dart';
import 'package:rooya/Plugins/FocusedMenu/modals.dart';
import 'package:rooya/Providers/ClickController/SelectIndexController.dart';
import 'package:rooya/Providers/RoomProvider/RoomProvider.dart';
import 'package:rooya/Utils/UserDataService.dart';
import 'package:rooya/Utils/primary_color.dart';
import 'package:rooya/Utils/text_filed/app_font.dart';

import 'Rooms/FindChatRooms.dart';
import 'UserChat/UserChat.dart';

class RoomsScreen extends StatefulWidget {
  const RoomsScreen({Key? key}) : super(key: key);

  @override
  _RoomsScreenState createState() => _RoomsScreenState();
}

class _RoomsScreenState extends State<RoomsScreen> {
  final controller = Get.put(RoomProvider());
  var selectedIndexController = Get.find<SelectIndexController>();

  @override
  void initState() {
    print('Click on group');
    controller.getGroupList();
    controller.connectToSocket();
    if (controller.friendList.isEmpty) {
      controller.getFriendList().then((value) {
        print('friend list length is =${controller.friendList.length}');
      });
    }
    // controller.leaveGroup();
    // Future.delayed(Duration(seconds: 2), () {
    //   controller.connectToSocket();
    // });
    if (!streamController.hasListener) {
      streamController.stream.listen((event) {
        setState(() {});
      });
    }
    super.initState();
  }

  DateFormat sdf2 = DateFormat("hh.mm aa");
  var listOfSelectedMember = <GroupModel>[].obs;

  @override
  void dispose() {
    controller.leaveGroup();
    super.dispose();
  }

  bool isloading = false;
  doNothing(BuildContext context) {}
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: listOfSelectedMember.isNotEmpty
                    ? Container(
                        decoration:
                            BoxDecoration(color: primaryColor.withOpacity(0.5)),
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  listOfSelectedMember.clear();
                                  setState(() {});
                                },
                                icon: Icon(Icons.clear)),
                            Text('${listOfSelectedMember.length}'),
                            Expanded(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.volume_off,
                                    size: 20,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return CupertinoAlertDialog(
                                            title: Text("Alert"),
                                            actions: [
                                              CupertinoDialogAction(
                                                  onPressed: () {
                                                    listOfSelectedMember
                                                        .clear();
                                                    setState(() {});
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text("Cancel")),
                                              CupertinoDialogAction(
                                                  onPressed: () {
                                                    // for (var i = 0;
                                                    //     i <
                                                    //         listOfSelectedMember
                                                    //             .length;
                                                    //     i++) {
                                                    //   Map payLoad = {
                                                    //     'g_id':
                                                    //         listOfSelectedMember[
                                                    //                 i]
                                                    //             .groupId
                                                    //             .toString(),
                                                    //     'userId':
                                                    //         listOfSelectedMember[
                                                    //                 i]
                                                    //             .senderId
                                                    //             .toString()
                                                    //   };
                                                    //   print(
                                                    //       'Delete payLoad = $payLoad');
                                                    //   ApiUtils.removeGroupApi(
                                                    //       map: payLoad);
                                                    //   controller.listofMember
                                                    //       .remove(
                                                    //           listOfSelectedMember[
                                                    //               i]);
                                                    // }
                                                    // listOfSelectedMember
                                                    //     .clear();
                                                    // setState(() {});
                                                    // Navigator.of(context).pop();
                                                  },
                                                  child: Text("Ok")),
                                            ],
                                            content: Text(
                                                "You want to delete the chat?"),
                                          );
                                        });
                                  },
                                  icon: Icon(
                                    CupertinoIcons.delete,
                                    size: 20,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.more_vert,
                                    size: 20,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                )
                              ],
                            ))
                          ],
                        ),
                      )
                    : ListTile(
                        title: InkWell(
                          onTap: () {
                            return createAlertDialoge(context);
                          },
                          child: Text(
                            'Chats',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: AppFonts.segoeui),
                          ),
                        ),
                        trailing: FocusedMenuHolder(
                          blurSize: 5.0,
                          menuItemExtent: 45,
                          menuWidth: width * 0.4,
                          menuOffset: 0,
                          openWithTap: true,
                          blurBackgroundColor: Colors.black54,
                          onCneTapMenuItems: <FocusedMenuItem>[
                            FocusedMenuItem(
                                title: Text("Select All"), onPressed: () {}),
                            FocusedMenuItem(
                                title: Text("Delete All"), onPressed: () {}),
                            FocusedMenuItem(
                                title: Text("Mark All"), onPressed: () {}),
                          ],
                          onPressed: () {},
                          child: Icon(
                            Icons.more_vert,
                            color: Colors.black,
                            size: 20,
                          ),
                        ),
                      ),
              ),
              Obx(
                () => !controller.loadChat.value
                    ? SliverToBoxAdapter(
                        child: SizedBox(
                        child: Center(child: CircularProgressIndicator()),
                        height: height - 150,
                        width: width,
                      ))
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                        var date;
                        if (controller.listofChat[index].lastMessage == null) {
                          date = '';
                        } else {
                          date = DateTime.fromMillisecondsSinceEpoch(int.parse(
                                  "${controller.listofChat[index].lastMessage!.time}") *
                              1000);
                        }
                        return Slidable(
                          key: const ValueKey(0),
                          startActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            dismissible: DismissiblePane(onDismissed: () {}),
                            children: [
                              SlidableAction(
                                onPressed: doNothing,
                                backgroundColor: Color(0xFFFE4A49),
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                              SlidableAction(
                                onPressed: doNothing,
                                backgroundColor: Color(0xFF21B7CA),
                                foregroundColor: Colors.white,
                                icon: Icons.share,
                                label: 'Share',
                              ),
                            ],
                          ),
                          endActionPane: ActionPane(
                            motion: ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) async {
                                  // if (controller.listofMember[index].block == 0) {
                                  //   Map map = {
                                  //     'userId':
                                  //         '${controller.listofMember[index].members![controller.listofMember[index].members!.indexWhere((element) => element.userId.toString() != storage.read('userID'))]}',
                                  //     'groupId':
                                  //         '${controller.listofMember[index].groupId}'
                                  //   };
                                  //   await ApiUtils.blockUser(map: map);
                                  //   await controller.getGroupList();
                                  //   setState(() {});
                                  // } else {
                                  //   Map map = {
                                  //     'userId':
                                  //         '${controller.listofMember[index].members![controller.listofMember[index].members!.indexWhere((element) => element.userId.toString() != storage.read('userID'))]}',
                                  //     'groupId':
                                  //         '${controller.listofMember[index].groupId}'
                                  //   };
                                  //   await ApiUtils.unblockUser(map: map);
                                  //   await controller.getGroupList();
                                  //   setState(() {});
                                  // }
                                },
                                backgroundColor: Color(0xFF7BC043),
                                foregroundColor: Colors.white,
                                icon: Icons.block,
                                // label: controller.listofMember[index].block == 0
                                //     ? 'Block'
                                //     : 'Unblock',
                              ),
                              SlidableAction(
                                onPressed: doNothing,
                                backgroundColor: Color(0xFF0392CF),
                                foregroundColor: Colors.white,
                                icon: Icons.save,
                                label: 'Save',
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  if (listOfSelectedMember.isEmpty) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (c) => UserChat(
                                                  groupID: controller
                                                      .listofChat[index].groupId
                                                      .toString(),
                                                  blocked: false,
                                                  name: controller
                                                      .listofChat[index]
                                                      .groupName
                                                      .toString(),
                                                  profilePic: controller
                                                      .listofChat[index].avatar,
                                                  fromGroup: true,
                                                  groupModel: controller
                                                      .listofChat[index],
                                                ))).then((value) async {
                                      controller.leaveGroup();
                                      await controller.getGroupList();
                                      Future.delayed(
                                          Duration(
                                              seconds: 1,
                                              milliseconds: 500), () {
                                        controller.connectToSocket();
                                      });
                                      setState(() {});
                                    });
                                  } else {
                                    // if (!listOfSelectedMember.contains(
                                    //     controller.listofMember[index])) {
                                    //   listOfSelectedMember
                                    //       .add(controller.listofMember[index]);
                                    // } else {
                                    //   listOfSelectedMember.remove(
                                    //       controller.listofMember[index]);
                                    // }
                                    // setState(() {});
                                  }
                                },
                                onLongPress: () {
                                  // if (!listOfSelectedMember
                                  //     .contains(controller.listofMember[index])) {
                                  //   listOfSelectedMember
                                  //       .add(controller.listofMember[index]);
                                  // } else {
                                  //   listOfSelectedMember
                                  //       .remove(controller.listofMember[index]);
                                  // }
                                  // setState(() {});
                                },
                                child: Row(
                                  children: [
                                    // listOfSelectedMember.isNotEmpty
                                    //     ? !listOfSelectedMember.contains(
                                    //             controller.listofMember[index])
                                    //         ? Container(
                                    //             height: 20,
                                    //             width: 20,
                                    //             decoration: BoxDecoration(
                                    //                 shape: BoxShape.circle,
                                    //                 border: Border.all(
                                    //                     width: 1,
                                    //                     color: buttonColor)),
                                    //           )
                                    //         : Container(
                                    //             height: 20,
                                    //             width: 20,
                                    //             child: Icon(
                                    //               Icons.check_circle,
                                    //               color: buttonColor,
                                    //             ),
                                    //           )
                                    //     : SizedBox(),
                                    Expanded(
                                      child: ListTile(
                                        leading: CircularProfileAvatar(
                                          '',
                                          radius: 28,
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                "${controller.listofChat[index].avatar!}",
                                            placeholder: (context, url) =>
                                                CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                            fit: BoxFit.cover,
                                          ),
                                          onTap: listOfSelectedMember.isNotEmpty
                                              ? null
                                              : () {
                                                  if (listOfSelectedMember
                                                      .isEmpty) {
                                                    Get.to(Photo_View_Class(
                                                      url:
                                                          "${controller.listofChat[index].avatar!}",
                                                    ));
                                                  }
                                                },
                                          imageFit: BoxFit.cover,
                                        ),
                                        title: Text(
                                          "${controller.listofChat[index].groupName}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontFamily: AppFonts.segoeui,
                                              fontSize: 16),
                                        ),
                                        subtitle: Text(
                                          date == ''
                                              ? ''
                                              : "${controller.listofChat[index].lastMessage!.text}",
                                          style: TextStyle(
                                              color: Color(0XFF373737),
                                              fontFamily: AppFonts.segoeui,
                                              fontSize: 12),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        trailing: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            // "${controller.listofChat[index].messageCount}" ==
                                            //         '0'
                                            //     ? SizedBox()
                                            //     : Container(
                                            //         decoration: BoxDecoration(
                                            //             shape: BoxShape.circle,
                                            //             color: Colors.green),
                                            //         child: Text(
                                            //           "${controller.listofChat[index].messageCount}",
                                            //           style: TextStyle(
                                            //               color: Colors.white,
                                            //               fontSize: 10,
                                            //               fontFamily:
                                            //                   AppFonts.segoeui),
                                            //         ),
                                            //         padding: EdgeInsets.all(5),
                                            //       ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              //'${timeago.format(DateTime.parse("${controller.listofMember[index].lastActive}"), locale: 'en_short')} ago',
                                              //"${controller.listofChat.value.data![index].lastMessage!.timeText}",
                                              date == ''
                                                  ? ''
                                                  : '${dateFormat.format(date)}',
                                              style: TextStyle(
                                                  color: Color(0XFF373737),
                                                  fontSize: 10,
                                                  fontFamily: AppFonts.segoeui),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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
                          ),
                        );
                      }, childCount: controller.listofChat.length)),
              )
            ],
          ),
          Obx(() => controller.isLoading.value == true
              ? InkWell(
                  onTap: () {
                    controller.isLoading.value = false;
                  },
                  child: Container(
                    height: height,
                    width: width,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                    decoration:
                        BoxDecoration(color: Colors.black.withOpacity(0.5)),
                  ),
                )
              : SizedBox())
        ],
      ),
      // floatingActionButton: CustomButton(),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                heroTag: "btn1",
                onPressed: () async {
                  Navigator.push(context,
                          MaterialPageRoute(builder: (c) => FindChatRooms()))
                      .then((value) async {
                    controller.leaveGroup();
                    await controller.getGroupList();
                    Future.delayed(Duration(seconds: 1, milliseconds: 500), () {
                      controller.connectToSocket();
                    });
                    setState(() {});
                  });
                },
                child: Icon(Icons.search),
                backgroundColor: Color(0xFF0BAB0D),
              ),
              SizedBox(
                width: 10,
              ),
              FloatingActionButton(
                heroTag: "btn2",
                onPressed: () async {
                  createGroup(context, controller.friendList.value,
                      (Map smap) async {
                    setState(() {
                      isloading = true;
                    });
                    await ApiUtils.createGroup(map: smap);
                    setState(() {
                      isloading = false;
                    });
                    controller.getGroupList();
                    setState(() {});
                    print('Over all object is = $smap');
                  });
                },
                child: Icon(Icons.add),
                backgroundColor: Color(0xFF0BAB0D),
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool public = true;
  createGroup(
      BuildContext context, List<Following> friendList, Function(Map) mapData) {
    public = true;
    var listofmap = [];
    TextEditingController groupNameController = TextEditingController();
    TextEditingController locationController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    double? lat;
    double? lng;
    String address;
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
                          'Create Room',
                          style: TextStyle(color: Colors.green, fontSize: 16),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.blueGrey[50],
                          ),
                          child: TextField(
                            controller: groupNameController,
                            decoration: InputDecoration(
                                hintText: 'Room Name',
                                hintStyle: TextStyle(
                                    fontSize: 13, fontFamily: AppFonts.segoeui),
                                contentPadding: EdgeInsets.only(left: 8),
                                border: InputBorder.none),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.blueGrey[50],
                          ),
                          child: GooglePlaceAutoCompleteTextField(
                              textEditingController: locationController,
                              googleAPIKey: "$google_map_api_key",
                              inputDecoration: InputDecoration(
                                  hintText: 'Select location',
                                  hintStyle: TextStyle(
                                      fontSize: 13,
                                      fontFamily: AppFonts.segoeui),
                                  contentPadding: EdgeInsets.only(left: 8),
                                  border: InputBorder.none),
                              getPlaceDetailWithLatLng:
                                  (Prediction prediction) {
                                lat = double.parse(prediction.lat!);
                                lng = double.parse(prediction.lng!);
                              },
                              itmClick: (Prediction prediction) {
                                locationController.text =
                                    prediction.description!;
                              }),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          height: 35,
                          padding: EdgeInsets.only(left: 10, right: 0),
                          decoration: BoxDecoration(
                              color: Colors.blueGrey[50],
                              borderRadius: BorderRadius.circular(40)),
                          child: TextField(
                            decoration: InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              hintText: 'Search Member ...',
                              hintStyle: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontFamily: AppFonts.segoeui),
                              suffixIcon: Icon(
                                Icons.search,
                                size: 20,
                                color: Color(0XFF0BAB0D),
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: !public,
                          child: Container(
                            height: 45,
                            margin: EdgeInsets.only(top: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.blueGrey[50],
                            ),
                            child: TextField(
                              controller: passwordController,
                              keyboardType:
                                  TextInputType.numberWithOptions(signed: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                  hintText: 'password',
                                  hintStyle: TextStyle(
                                      fontSize: 13,
                                      fontFamily: AppFonts.segoeui),
                                  contentPadding: EdgeInsets.only(left: 8),
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  public = true;
                                });
                              },
                              child: Container(
                                height: 30,
                                width: 130,
                                child: Center(
                                  child: Text(
                                    'Public',
                                    style: TextStyle(
                                        color: public
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 15,
                                        fontFamily: AppFonts.segoeui),
                                  ),
                                ),
                                decoration: public
                                    ? BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Color(0XFF0BAB0D),
                                      )
                                    : BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Colors.black26, width: 1)),
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  public = false;
                                });
                              },
                              child: Container(
                                height: 30,
                                width: 130,
                                child: Center(
                                  child: Text(
                                    'Private',
                                    style: TextStyle(
                                        color: !public
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 15,
                                        fontFamily: AppFonts.segoeui),
                                  ),
                                ),
                                decoration: !public
                                    ? BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Color(0XFF0BAB0D),
                                      )
                                    : BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Colors.black26, width: 1)),
                              ),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Expanded(
                          child: Container(
                            color: Colors.white,
                            child: friendList.isEmpty
                                ? Center(
                                    child: Text('Empty list'),
                                  )
                                : ListView.builder(
                                    itemCount: friendList.length,
                                    itemBuilder: (context, i) => Column(
                                      children: [
                                        ListTile(
                                          leading: CircularProfileAvatar(
                                            '',
                                            radius: 23,
                                            child: Image.network(
                                              '${friendList[i].avatar}',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          title: Text(
                                            '${friendList[i].firstName} ${friendList[i].lastName}',
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
                                                    !listofmap.contains(
                                                            friendList[i]
                                                                .userId
                                                                .toString())
                                                        ? 'Add'
                                                        : 'Cancel',
                                                    style: TextStyle(
                                                        color: !listofmap.contains(
                                                                friendList[i]
                                                                    .userId
                                                                    .toString())
                                                            ? Colors.green
                                                            : Colors.white,
                                                        fontFamily:
                                                            AppFonts.segoeui,
                                                        fontSize: 11),
                                                  )),
                                                  decoration: BoxDecoration(
                                                      color: !listofmap.contains(
                                                              friendList[i]
                                                                  .userId
                                                                  .toString())
                                                          ? Colors.transparent
                                                          : Colors.green,
                                                      border: Border.all(
                                                          color: Colors.green,
                                                          width: 1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                ),
                                                onTap: () {
                                                  listofmap.add(friendList[i]
                                                      .userId
                                                      .toString()
                                                      .trim());
                                                  setState(() {});
                                                },
                                              ),
                                              !listofmap.contains(friendList[i]
                                                      .userId
                                                      .toString())
                                                  ? SizedBox(
                                                      height: 25,
                                                      width: 25,
                                                    )
                                                  : InkWell(
                                                      onTap: () {
                                                        listofmap.remove(
                                                            friendList[i]
                                                                .userId
                                                                .toString());
                                                        setState(() {});
                                                      },
                                                      child: Container(
                                                        height: 22,
                                                        width: 22,
                                                        margin:
                                                            EdgeInsets.all(3),
                                                        decoration:
                                                            BoxDecoration(
                                                                color:
                                                                    Colors.red,
                                                                shape: BoxShape
                                                                    .circle),
                                                        child: Center(
                                                            child: Icon(
                                                          Icons.close,
                                                          size: 15,
                                                          color: Colors.white,
                                                        )),
                                                      ),
                                                    ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        InkWell(
                          onTap: () async {
                            if (listofmap.isNotEmpty) {
                              if (groupNameController.text.trim().isNotEmpty) {
                                if (locationController.text.trim().isNotEmpty) {
                                  String ids = '';
                                  for (var i in listofmap) {
                                    if (i == listofmap.last) {
                                      ids = ids + '$i';
                                    } else {
                                      ids = ids + '$i,';
                                    }
                                  }
                                  if (public) {
                                    mapData.call({
                                      'server_key': serverKey,
                                      'type': 'create',
                                      'group_name':
                                          '${groupNameController.text.trim()}',
                                      'parts': ids,
                                      'variant': 'room',
                                      'privacy': 'public',
                                      'lat': lat.toString(),
                                      'lng': lng.toString()
                                    });
                                  } else {
                                    mapData.call({
                                      'server_key': serverKey,
                                      'type': 'create',
                                      'group_name':
                                          '${groupNameController.text.trim()}',
                                      'parts': ids,
                                      'variant': 'room',
                                      'privacy': 'private',
                                      'password': passwordController.text
                                          .trim()
                                          .toString(),
                                      'lat': lat.toString(),
                                      'lng': lng.toString()
                                    });
                                  }
                                  Navigator.of(context).pop();
                                } else {
                                  snackBarFailer(
                                      'Please Select location First');
                                }
                              } else {
                                snackBarFailer('Please Add Group name First');
                              }
                            } else {
                              snackBarFailer(
                                  'Please select group member first');
                            }
                          },
                          child: Container(
                            height: 40,
                            width: 130,
                            child: Center(
                              child: Text(
                                'CREATE',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontFamily: AppFonts.segoeui),
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Color(0XFF0BAB0D),
                            ),
                          ),
                        ),
                      ]));
                },
              ));
        });
  }

  createAlertDialoge(BuildContext context) {
    var map = [].obs;
    TextEditingController customController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return Obx(
            () => AlertDialog(
              insetPadding: EdgeInsets.only(left: 15, right: 15),
              // contentPadding: EdgeInsets.zero,
              // clipBehavior: Clip.antiAliasWithSaveLayer,
              content: Container(
                height: 260,
                width: 350,
                // color: Colors.green,
                child: Column(
                  children: [
                    Text(
                      'Edit your Status',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        fontFamily: AppFonts.segoeui,
                        color: Color(0XFF0BAB0D),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Current Status',
                          style: TextStyle(
                              fontSize: 12, fontFamily: AppFonts.segoeui),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 80,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color(0XFFF5F5F5),
                              borderRadius: BorderRadius.circular(8)),
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'I Love Rooya',
                                hintStyle: TextStyle(
                                    fontSize: 13, fontFamily: AppFonts.segoeui),
                                contentPadding: EdgeInsets.only(left: 8)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 40,
                      width: 130,
                      child: Center(
                        child: Text(
                          'SAVE',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: AppFonts.segoeui),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color(0XFF0BAB0D),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 40,
                      width: 130,
                      child: Center(
                        child: Text(
                          'NO THANKS',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: AppFonts.segoeui),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color(0XFFCCCCCC),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
