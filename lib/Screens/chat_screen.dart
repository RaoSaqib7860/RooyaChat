import 'package:avatar_glow/avatar_glow.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:dashed_circle/dashed_circle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:rooya/ApiConfig/ApiUtils.dart';
import 'package:rooya/GlobalWidget/Photo_View_Class.dart';
import 'package:rooya/Plugins/FocusedMenu/focused_menu.dart';
import 'package:rooya/Plugins/FocusedMenu/modals.dart';
import 'package:rooya/Providers/ChatScreenProvider.dart';
import 'package:rooya/Providers/ClickController/SelectIndexController.dart';
import 'package:rooya/Providers/OneToOneModel.dart';
import 'package:rooya/Utils/StoryViewPage.dart';
import 'package:rooya/Utils/UserDataService.dart';
import 'package:rooya/Utils/primary_color.dart';
import 'package:rooya/Utils/text_filed/app_font.dart';

import 'UserChat/UserChat.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
  final snackBar = SnackBar(content: Text('Yay! A SnackBar!'));
  final controller = Get.put(ChatScreenProvider());

  var selectedIndexController = Get.find<SelectIndexController>();

  @override
  void initState() {
    controller.getChatList();
    controller.connectToSocket();
    // controller.leaveGroup();
    Future.delayed(Duration(seconds: 2), () {
      controller.connectToSocket();
    });
    if (!streamController.hasListener) {
      streamController.stream.listen((event) {
        setState(() {});
      });
    }
    getStoryData();

////anim
    animcontroller =
        AnimationController(vsync: this, duration: Duration(seconds: 4));
    base = CurvedAnimation(parent: animcontroller!, curve: Curves.easeOut);
    reverse = Tween<double>(begin: 0.0, end: -1.0).animate(base!);
    gap = Tween<double>(begin: 3.0, end: 0.0).animate(base!)
      ..addListener(() {
        setState(() {});
      });
    animcontroller!.forward();
    Future.delayed(Duration(seconds: 5), () {
      animcontroller!.repeat();
    });
    super.initState();
  }

  getStoryData() async {
    await controller.getStoryList();
    Future.delayed(Duration(milliseconds: 30), () {
      setState(() {});
    });
  }

  var listOfSelectedMember = <OneToOneChatModel>[].obs;

  Animation? gap;
  Animation<double>? base;
  Animation<double>? reverse;
  AnimationController? animcontroller;

  @override
  void dispose() {
    controller.leaveGroup();
    animcontroller!.dispose();
    super.dispose();
  }

  var selectedOneToOneChat = <OneToOneChatModel>[].obs;

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
                        var date = DateTime.fromMillisecondsSinceEpoch(int.parse(
                                "${controller.listofChat[index].lastMessage!.time}") *
                            1000);
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
                                                      .listofChat[index].userId
                                                      .toString(),
                                                  blocked: false,
                                                  name: controller
                                                          .listofChat[index]
                                                          .firstName
                                                          .toString() +
                                                      controller
                                                          .listofChat[index]
                                                          .lastName
                                                          .toString(),
                                                  profilePic: controller
                                                      .listofChat[index].avatar,
                                                  fromGroup: false,
                                                ))).then((value) async {
                                      //   controller.leaveGroup();
                                      controller.getChatList();
                                      Future.delayed(
                                          Duration(
                                              seconds: 1,
                                              milliseconds: 500), () {
                                        //   controller.connectToSocket();
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

                                    // RotationTransition(
                                    //   turns: base!,
                                    //   child: DashedCircle(
                                    //     gapSize: gap!.value,
                                    //     dashes: 40,
                                    //     color: buttonColor,
                                    //     child: RotationTransition(
                                    //       turns: reverse!,
                                    //       child: Padding(
                                    //         padding: const EdgeInsets.all(5.0),
                                    //         child: CircleAvatar(
                                    //           radius: 80.0,
                                    //           backgroundImage: NetworkImage(
                                    //               "https://images.unsplash.com/photo-1564564295391-7f24f26f568b"
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    Expanded(
                                      child: ListTile(
                                        leading: controller.idsOfUserStories
                                                .contains(
                                                    '${controller.listofChat[index].userId}')
                                            ? RotationTransition(
                                                turns: base!,
                                                child: DashedCircle(
                                                  color: buttonColor,
                                                  gapSize: gap!.value,
                                                  dashes: 20,
                                                  child: RotationTransition(
                                                    turns: reverse!,
                                                    child:
                                                        CircularProfileAvatar(
                                                      '',
                                                      radius: 28,
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            "${controller.listofChat[index].avatar!}",
                                                        placeholder: (context,
                                                                url) =>
                                                            CircularProgressIndicator(),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Icon(Icons.error),
                                                        fit: BoxFit.cover,
                                                      ),
                                                      onTap:
                                                          listOfSelectedMember
                                                                  .isNotEmpty
                                                              ? null
                                                              : () {
                                                                  if (listOfSelectedMember
                                                                      .isEmpty) {
                                                                    int i = controller
                                                                        .idsOfUserStories
                                                                        .indexWhere((element) =>
                                                                            element ==
                                                                            '${controller.listofChat[index].userId}');
                                                                    Get.to(
                                                                        StoryViewPage(
                                                                      userStories:
                                                                          controller
                                                                              .storyList[i],
                                                                    ));
                                                                  }
                                                                },
                                                      imageFit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : CircularProfileAvatar(
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
                                                onTap: listOfSelectedMember
                                                        .isNotEmpty
                                                    ? null
                                                    : () {
                                                        if (listOfSelectedMember
                                                            .isEmpty) {
                                                          Get.to(
                                                              Photo_View_Class(
                                                            url:
                                                                "${controller.listofChat[index].avatar!}",
                                                          ));
                                                        }
                                                      },
                                                imageFit: BoxFit.cover,
                                              ),
                                        title: Text(
                                          "${controller.listofChat[index].name!}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontFamily: AppFonts.segoeui,
                                              fontSize: 16),
                                        ),
                                        subtitle: Text(
                                          "${controller.listofChat[index].lastMessage!.text}",
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
                                            "${controller.listofChat[index].messageCount}" ==
                                                    '0'
                                                ? SizedBox()
                                                : Container(
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.green),
                                                    child: Text(
                                                      "${controller.listofChat[index].messageCount}",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 10,
                                                          fontFamily:
                                                              AppFonts.segoeui),
                                                    ),
                                                    padding: EdgeInsets.all(5),
                                                  ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              //'${timeago.format(DateTime.parse("${controller.listofMember[index].lastActive}"), locale: 'en_short')} ago',
                                              //"${controller.listofChat.value.data![index].lastMessage!.timeText}",
                                              '${dateFormat.format(date)}',
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
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onLongPress: () async {
              final ImagePicker _picker = ImagePicker();
              var pickedFile = await _picker.getVideo(
                source: ImageSource.camera,
              );
              print('file path is = ${pickedFile!.path}');
              var listofmap = [];
              await controller.getFriendList();
              showMaterialModalBottomSheet(
                context: context,
                builder: (context) =>
                    StatefulBuilder(builder: (context, setState) {
                  return Container(
                    height: height - 100,
                    width: width,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              InkWell(
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.blue,
                                      fontFamily: AppFonts.segoeui),
                                ),
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              listofmap.isNotEmpty
                                  ? InkWell(
                                      child: Text(
                                        'Forward',
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.blue,
                                            fontFamily: AppFonts.segoeui),
                                      ),
                                      onTap: () async {
                                        if (pickedFile != null) {
                                          for (var i in listofmap) {
                                            Map map = {
                                              'message': '',
                                              'memberId[]': '$i'
                                            };
                                            String id = await ApiUtils
                                                .newsendMessagepost(map: map);
                                            controller.sentMessageViaFile(
                                                groupId: id,
                                                filePath: '${pickedFile.path}');
                                          }
                                          Navigator.of(context).pop();
                                        }
                                      },
                                    )
                                  : SizedBox()
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: controller
                                .searchUserModel.value.friends!.length,
                            itemBuilder: (context, i) => Column(
                              children: [
                                ListTile(
                                  leading: CircularProfileAvatar(
                                    '',
                                    radius: 23,
                                    child: Image.network(
                                      '${controller.searchUserModel.value.friends![i].profilePictureUrl}',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: Text(
                                    '${controller.searchUserModel.value.friends![i].firstName} ${controller.searchUserModel.value.friends![i].lastName}',
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
                                            child: Icon(
                                              Icons.check,
                                              size: 18,
                                              color: !listofmap.contains(
                                                      controller
                                                          .searchUserModel
                                                          .value
                                                          .friends![i]
                                                          .userId
                                                          .toString())
                                                  ? Colors.transparent
                                                  : Colors.white,
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: !listofmap.contains(
                                                    controller
                                                        .searchUserModel
                                                        .value
                                                        .friends![i]
                                                        .userId
                                                        .toString())
                                                ? Colors.transparent
                                                : Colors.green,
                                            border: Border.all(
                                                color: !listofmap.contains(
                                                        controller
                                                            .searchUserModel
                                                            .value
                                                            .friends![i]
                                                            .userId
                                                            .toString())
                                                    ? Colors.black12
                                                    : Colors.green,
                                                width: 2),
                                          ),
                                        ),
                                        onTap: () {
                                          if (listofmap.contains(controller
                                              .searchUserModel
                                              .value
                                              .friends![i]
                                              .userId
                                              .toString())) {
                                            listofmap.remove(controller
                                                .searchUserModel
                                                .value
                                                .friends![i]
                                                .userId
                                                .toString());
                                            setState(() {});
                                          } else {
                                            listofmap.add(controller
                                                .searchUserModel
                                                .value
                                                .friends![i]
                                                .userId
                                                .toString()
                                                .trim());
                                            setState(() {});
                                          }
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
                        )
                      ],
                    ),
                  );
                }),
              ).then((value) {
                if (value is bool) {
                  selectedOneToOneChat.clear();
                  setState(() {});
                }
              });
            },
            onTap: () async {
              final ImagePicker _picker = ImagePicker();
              var pickedFile = await _picker.getImage(
                source: ImageSource.camera,
              );
              print('file path is = ${pickedFile!.path}');
              var listofmap = [];
              await controller.getFriendList();
              showMaterialModalBottomSheet(
                context: context,
                builder: (context) =>
                    StatefulBuilder(builder: (context, setState) {
                  return Container(
                    height: height - 100,
                    width: width,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              InkWell(
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.blue,
                                      fontFamily: AppFonts.segoeui),
                                ),
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              listofmap.isNotEmpty
                                  ? InkWell(
                                      child: Text(
                                        'Forward',
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.blue,
                                            fontFamily: AppFonts.segoeui),
                                      ),
                                      onTap: () async {
                                        if (pickedFile != null) {
                                          for (var i in listofmap) {
                                            Map map = {
                                              'message': '',
                                              'memberId[]': '$i'
                                            };
                                            String id = await ApiUtils
                                                .newsendMessagepost(map: map);
                                            controller.sentMessageViaFile(
                                                groupId: id,
                                                filePath: '${pickedFile.path}');
                                          }
                                          Navigator.of(context).pop();
                                        }
                                      },
                                    )
                                  : SizedBox()
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: controller
                                .searchUserModel.value.friends!.length,
                            itemBuilder: (context, i) => Column(
                              children: [
                                ListTile(
                                  leading: CircularProfileAvatar(
                                    '',
                                    radius: 23,
                                    child: Image.network(
                                      '${controller.searchUserModel.value.friends![i].profilePictureUrl}',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: Text(
                                    '${controller.searchUserModel.value.friends![i].firstName} ${controller.searchUserModel.value.friends![i].lastName}',
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
                                            child: Icon(
                                              Icons.check,
                                              size: 18,
                                              color: !listofmap.contains(
                                                      controller
                                                          .searchUserModel
                                                          .value
                                                          .friends![i]
                                                          .userId
                                                          .toString())
                                                  ? Colors.transparent
                                                  : Colors.white,
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: !listofmap.contains(
                                                    controller
                                                        .searchUserModel
                                                        .value
                                                        .friends![i]
                                                        .userId
                                                        .toString())
                                                ? Colors.transparent
                                                : Colors.green,
                                            border: Border.all(
                                                color: !listofmap.contains(
                                                        controller
                                                            .searchUserModel
                                                            .value
                                                            .friends![i]
                                                            .userId
                                                            .toString())
                                                    ? Colors.black12
                                                    : Colors.green,
                                                width: 2),
                                          ),
                                        ),
                                        onTap: () {
                                          if (listofmap.contains(controller
                                              .searchUserModel
                                              .value
                                              .friends![i]
                                              .userId
                                              .toString())) {
                                            listofmap.remove(controller
                                                .searchUserModel
                                                .value
                                                .friends![i]
                                                .userId
                                                .toString());
                                            setState(() {});
                                          } else {
                                            listofmap.add(controller
                                                .searchUserModel
                                                .value
                                                .friends![i]
                                                .userId
                                                .toString()
                                                .trim());
                                            setState(() {});
                                          }
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
                        )
                      ],
                    ),
                  );
                }),
              ).then((value) {
                if (value is bool) {
                  selectedOneToOneChat.clear();
                  setState(() {});
                }
              });
            },
            child: Container(
              child: Icon(
                Icons.camera_alt,
                color: Colors.white,
              ),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Color(0xFF0BAB0D), shape: BoxShape.circle),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            heroTag: "btn2",
            onPressed: () {
              // Get.to(NewUserSearchpage())!.then((value) async {
              //   await controller.getGroupList();
              //   Future.delayed(Duration(seconds: 1, milliseconds: 500), () {
              //     controller.connectToSocket();
              //   });
              //   setState(() {});
              // });
            },
            child: SvgPicture.asset(
              'assets/user/prs.svg',
              color: Colors.white,
            ),
            backgroundColor: Color(0xFF0BAB0D),
          ),
        ],
      ),
    );
  }

  String typeReturn(String value) {
    if (value.contains('Contacts#=-:')) {
      return 'Contact';
    } else if (value.contains('.jpg') ||
        value.contains('.png') ||
        value.contains('.jpeg')) {
      return 'Image';
    } else if (value.contains('.mp4')) {
      return 'Video';
    } else if (value.contains('.mp3') ||
        value.contains('.aac') ||
        value.contains('.ac3') ||
        value.contains('.h264') ||
        value.contains('.wav') ||
        value.contains('.csv') ||
        value.contains('.wma') ||
        value.contains('.wmv')) {
      return 'Audio';
    } else if (value.contains('.pdf')) {
      return 'Documents';
    } else {
      return value;
    }
  }

  doNothing(BuildContext context) {}

  createAlertDialoge(BuildContext context) {
    TextEditingController customController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
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
          );
        });
  }
}
