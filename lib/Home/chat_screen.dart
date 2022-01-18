import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rooya/ApiConfig/ApiUtils.dart';
import 'package:rooya/ClickController/SelectIndexController.dart';
import 'package:rooya/GlobalWidget/Photo_View_Class.dart';
import 'package:rooya/ModelClasses/GroupModel.dart';
import 'package:rooya/OneToOneChat.dart';
import 'package:rooya/PluginComponents/FocusedMenu/focused_menu.dart';
import 'package:rooya/PluginComponents/FocusedMenu/modals.dart';
import 'package:rooya/Providers/ChatScreenProvider.dart';
import 'package:rooya/Request/chat_request.dart';
import 'package:rooya/SearchUser/SearchUser.dart';
import 'package:rooya/responsive/primary_color.dart';
import 'package:rooya/slidable/expendiable.dart';
import 'package:rooya/text_filed/app_font.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final snackBar = SnackBar(content: Text('Yay! A SnackBar!'));
  final controller = Get.put(ChatScreenProvider());

  var selectedIndexController = Get.find<SelectIndexController>();

  @override
  void initState() {
    controller.getGroupList();
    controller.connectToSocket();
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
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
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
                              onPressed: () {},
                              icon: Icon(
                                Icons.push_pin,
                                size: 20,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                for (var i = 0;
                                    i < listOfSelectedMember.length;
                                    i++) {
                                  Map payLoad = {
                                    'g_id': listOfSelectedMember[i]
                                        .groupId
                                        .toString(),
                                    'userId': listOfSelectedMember[i].senderId.toString()
                                  };
                                  ApiUtils.removeGroupApi(map: payLoad);
                                  controller.listofMember
                                      .remove(listOfSelectedMember[i]);
                                }
                                listOfSelectedMember.clear();
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
            () => SliverList(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
              if (selectedIndexController.searchValue.value.isEmpty) {
                return "${controller.listofMember[index].recentMessage}" ==
                        'You: '
                    ? SizedBox()
                    : Column(
                        children: [
                          Slidable(
                            endActionPane: ActionPane(
                              motion: ScrollMotion(),
                              children: [
                                ClipOval(
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    child: Center(
                                      child: SlidableAction(
                                        // An action can be bigger than the others.
                                        backgroundColor: Color(0xFF7BC043),
                                        foregroundColor: Colors.white,
                                        icon: CupertinoIcons.speaker_2_fill,
                                        onPressed: (index) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: ClipOval(
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      child: Center(
                                        child: SlidableAction(
                                          onPressed: (index) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBar);
                                          },
                                          backgroundColor:
                                              CupertinoColors.destructiveRed,
                                          foregroundColor: Colors.white,
                                          icon: CupertinoIcons.delete,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            startActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              dismissible: DismissiblePane(
                                key: GlobalKey(),
                                onDismissed: () {
                                  // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                },
                              ),
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: ClipOval(
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      child: Center(
                                        child: SlidableAction(
                                          onPressed: (index) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBar);
                                          },
                                          backgroundColor: CupertinoColors.link,
                                          foregroundColor: Colors.white,
                                          icon: CupertinoIcons.italic,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: ClipOval(
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      child: Center(
                                        child: SlidableAction(
                                          onPressed: (index) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBar);
                                          },
                                          backgroundColor: Color(0xFF21B7CA),
                                          foregroundColor: Colors.white,
                                          icon: CupertinoIcons.pin_fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    listOfSelectedMember.isNotEmpty
                                        ? !listOfSelectedMember.contains(
                                                controller.listofMember[index])
                                            ? Container(
                                                height: 20,
                                                width: 20,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        width: 1,
                                                        color: buttonColor)),
                                              )
                                            : Container(
                                                height: 20,
                                                width: 20,
                                                child: Icon(
                                                  Icons.check_circle,
                                                  color: buttonColor,
                                                ),
                                              )
                                        : SizedBox(),
                                    Expanded(
                                      child: InkWell(
                                        child: ListTile(
                                          leading: CircularProfileAvatar(
                                            '',
                                            radius: 28,
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  "${controller.listofMember[index].members![0].profilePictureUrl}",
                                              placeholder: (context, url) =>
                                                  CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                              fit: BoxFit.cover,
                                            ),
                                            onTap: () {
                                              Get.to(Photo_View_Class(
                                                url:
                                                    "${controller.listofMember[index].members![0].profilePictureUrl}",
                                              ));
                                            },
                                            imageFit: BoxFit.cover,
                                          ),
                                          title: Text(
                                            "${controller.listofMember[index].members![0].firstName}" +
                                                " ${controller.listofMember[index].members![0].lastName}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontFamily: AppFonts.segoeui,
                                                fontSize: 16),
                                          ),
                                          subtitle: Text(
                                            controller.listofMember[index]
                                                        .messageType ==
                                                    'text'
                                                ? "${controller.listofMember[index].recentMessage}"
                                                : "${controller.listofMember[index].recentMessage}"
                                                        .split(':')[0] +
                                                    ' : ' +
                                                    '${controller.listofMember[index].messageType}',
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
                                              "${controller.listofMember[index].pendingMessage}" ==
                                                      '0'
                                                  ? SizedBox()
                                                  : Container(
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors.green),
                                                      child: Text(
                                                        "${controller.listofMember[index].pendingMessage}",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 10,
                                                            fontFamily: AppFonts
                                                                .segoeui),
                                                      ),
                                                      padding:
                                                          EdgeInsets.all(5),
                                                    ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                //'${timeago.format(DateTime.parse("${controller.listofMember[index].lastActive}"), locale: 'en_short')} ago',
                                                '${sdf2.format(DateTime.parse("${controller.listofMember[index].lastActive}").toUtc().toLocal())}',
                                                style: TextStyle(
                                                    color: Color(0XFF373737),
                                                    fontSize: 10,
                                                    fontFamily:
                                                        AppFonts.segoeui),
                                              )
                                            ],
                                          ),
                                        ),
                                        onTap: () {
                                          if (listOfSelectedMember.isEmpty) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (c) =>
                                                        OneToOneChat(
                                                          groupID: controller
                                                              .listofMember[
                                                                  index]
                                                              .groupId
                                                              .toString(),
                                                          name: "${controller.listofMember[index].members![0].firstName} " +
                                                              "${controller.listofMember[index].members![0].lastName}",
                                                          profilePic:
                                                              "${controller.listofMember[index].members![0].profilePictureUrl}",
                                                        ))).then((value) async {
                                              await controller.getGroupList();
                                              setState(() {});
                                            });
                                          } else {
                                            if (!listOfSelectedMember.contains(
                                                controller
                                                    .listofMember[index])) {
                                              listOfSelectedMember.add(
                                                  controller
                                                      .listofMember[index]);
                                            } else {
                                              listOfSelectedMember.remove(
                                                  controller
                                                      .listofMember[index]);
                                            }
                                            setState(() {});
                                          }
                                        },
                                        onLongPress: () {
                                          if (!listOfSelectedMember.contains(
                                              controller.listofMember[index])) {
                                            listOfSelectedMember.add(
                                                controller.listofMember[index]);
                                          } else {
                                            listOfSelectedMember.remove(
                                                controller.listofMember[index]);
                                          }
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                  ],
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
                          ),
                        ],
                      );
              } else if ("${controller.listofMember[index].members![0].firstName} ${controller.listofMember[index].members![0].lastName}"
                  .contains(selectedIndexController.searchValue.value)) {
                return Column(
                  children: [
                    Slidable(
                      endActionPane: ActionPane(
                        motion: ScrollMotion(),
                        children: [
                          ClipOval(
                            child: Container(
                              height: 50,
                              width: 50,
                              child: Center(
                                child: SlidableAction(
                                  // An action can be bigger than the others.
                                  backgroundColor: Color(0xFF7BC043),
                                  foregroundColor: Colors.white,
                                  icon: CupertinoIcons.speaker_2_fill,
                                  onPressed: (index) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  },
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: ClipOval(
                              child: Container(
                                height: 50,
                                width: 50,
                                child: Center(
                                  child: SlidableAction(
                                    onPressed: (index) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    },
                                    backgroundColor:
                                        CupertinoColors.destructiveRed,
                                    foregroundColor: Colors.white,
                                    icon: CupertinoIcons.delete,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      startActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        dismissible: DismissiblePane(
                          key: GlobalKey(),
                          onDismissed: () {
                            // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          },
                        ),
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: ClipOval(
                              child: Container(
                                height: 50,
                                width: 50,
                                child: Center(
                                  child: SlidableAction(
                                    onPressed: (index) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    },
                                    backgroundColor: CupertinoColors.link,
                                    foregroundColor: Colors.white,
                                    icon: CupertinoIcons.italic,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: ClipOval(
                              child: Container(
                                height: 50,
                                width: 50,
                                child: Center(
                                  child: SlidableAction(
                                    onPressed: (index) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    },
                                    backgroundColor: Color(0xFF21B7CA),
                                    foregroundColor: Colors.white,
                                    icon: CupertinoIcons.pin_fill,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          InkWell(
                            child: ListTile(
                              leading: CircularProfileAvatar(
                                '',
                                radius: 28,
                                child: CachedNetworkImage(
                                  imageUrl:
                                      "${controller.listofMember[index].members![0].profilePictureUrl}",
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                              title: Text(
                                "${controller.listofMember[index].members![0].firstName} " +
                                    "${controller.listofMember[index].members![0].lastName}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontFamily: AppFonts.segoeui,
                                    fontSize: 16),
                              ),
                              subtitle: Text(
                                controller.listofMember[index].messageType ==
                                        'text'
                                    ? "${controller.listofMember[index].recentMessage}"
                                    : "${controller.listofMember[index].recentMessage}"
                                            .split(':')[0] +
                                        ' : ' +
                                        '${controller.listofMember[index].messageType}',
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
                                  "${controller.listofMember[index].pendingMessage}" ==
                                          '0'
                                      ? SizedBox()
                                      : Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.green),
                                          child: Text(
                                            "${controller.listofMember[index].pendingMessage}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                fontFamily: AppFonts.segoeui),
                                          ),
                                          padding: EdgeInsets.all(5),
                                        ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '${timeago.format(DateTime.parse("${controller.listofMember[index].lastActive}"), locale: 'en_short')} ago',
                                    style: TextStyle(
                                        color: Color(0XFF373737),
                                        fontSize: 10,
                                        fontFamily: AppFonts.segoeui),
                                  )
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (c) => OneToOneChat(
                                            groupID: controller
                                                .listofMember[index].groupId
                                                .toString(),
                                            name: "${controller.listofMember[index].members![0].firstName} " +
                                                "${controller.listofMember[index].members![0].lastName}",
                                            profilePic:
                                                "${controller.listofMember[index].members![0].profilePictureUrl}",
                                          ))).then((value) async {
                                await controller.getGroupList();
                                setState(() {});
                              });
                            },
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
                    ),
                  ],
                );
              } else {
                return SizedBox();
              }
            }, childCount: controller.listofMember.length)),
          )
        ],
      ),
      // floatingActionButton: CustomButton(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(SearchUser());
        },
        child: SvgPicture.asset(
          'assets/user/prs.svg',
          color: Colors.white,
        ),
        backgroundColor: Color(0xFF0BAB0D),
      ),
    );
  }

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
