import 'dart:async';
import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record_mp3/record_mp3.dart';
import 'package:rooya/AllDialog/showMessageDetaildDialog.dart';
import 'package:rooya/ApiConfig/ApiUtils.dart';
import 'package:rooya/GlobalWidget/Photo_View_Class.dart';
import 'package:rooya/Models/GroupModel.dart';
import 'package:rooya/Models/UserChatModel.dart';
import 'package:rooya/Plugins/AudioAnimationSource/record_button.dart';
import 'package:rooya/Plugins/FocusedMenu/focused_menu.dart';
import 'package:rooya/Plugins/FocusedMenu/modals.dart';
import 'package:rooya/Screens/Information/GroupInformation/GroupInformation.dart';
import 'package:rooya/Screens/Information/UserChatInformation/user_chat_information.dart';
import 'package:rooya/Utils/primary_color.dart';
import 'package:rooya/Utils/text_filed/app_font.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:intl/intl.dart';
import 'UserChatProvider.dart';
import 'UserChatWidget/AudioChatUser.dart';
import 'UserChatWidget/ContactViewUserChat.dart';
import 'UserChatWidget/DocumentUserChat.dart';
import 'UserChatWidget/LocationViewUserChat.dart';
import 'UserChatWidget/TextUserChat.dart';
import 'UserChatWidget/VideoUserChat.dart';
import 'UserChatWidget/imageViewUserChat.dart';
import 'UserChatWidget/replyChat.dart';

String seenTextColor = '';
String receiveTextColor = '';
String sentTextColor = '';

String seenCheck = '';
String receiveCheck = '';
String sentCheck = '';

String seenTimeColor = '';
String receiveTimeColor = '';
String sentTimeColor = '';

String seenBackColor = '';
String receiveBackColor = '';
String sentBackColor = '';

class UserChat extends StatefulWidget {
  final String? groupID;
  final String? profilePic;
  final String? name;
  final bool? fromGroup;
  final String? unseenMessage;
  final bool? blocked;
  final GroupModel? groupModel;

  const UserChat(
      {Key? key,
      this.groupID,
      this.profilePic,
      this.name,
      this.fromGroup = false,
      this.unseenMessage = '0',
      this.blocked = false,
      this.groupModel})
      : super(key: key);

  @override
  _UserChatState createState() => _UserChatState();
}

class _UserChatState extends State<UserChat>
    with SingleTickerProviderStateMixin {
  late AnimationController animcontroller;
  TextEditingController controller = TextEditingController();
  bool isfirst = false;
  DateFormat sdf2 = DateFormat("hh.mm aa");
  DateFormat sdf1 = DateFormat("hh:mm:ss aa");
  var replyModel = <Messages>[].obs;
  var isActivereply = false.obs;
  UserChatProvider? getcontroller;

  String audio_path = '';

  @override
  void initState() {
    if (storage.read('selectedTab') == '0') {
      seenTextColor = '255,0,0,0';
      receiveTextColor = '255,0,0,0';
      sentTextColor = '255,0,0,0';

      seenCheck = '255,33,150,243';
      receiveCheck = '100,0,0,0';
      sentCheck = '100,0,0,0';

      seenTimeColor = '100,0,0,0';
      receiveTimeColor = '100,0,0,0';
      sentTimeColor = '100,0,0,0';

      seenBackColor = '255,219,247,199';
      receiveBackColor = '255,219,247,199';
      sentBackColor = '255,219,247,199';
    } else {
      seenTextColor = storage.read('seenTextColor');
      receiveTextColor = storage.read('receiveTextColor');
      sentTextColor = storage.read('sentTextColor');

      seenCheck = storage.read('seenCheck');
      receiveCheck = storage.read('receiveCheck');
      sentCheck = storage.read('sentCheck');

      seenTimeColor = storage.read('seenTimeColor');
      receiveTimeColor = storage.read('receiveTimeColor');
      sentTimeColor = storage.read('sentTimeColor');

      seenBackColor = storage.read('seenBackColor');
      receiveBackColor = storage.read('receiveBackColor');
      sentBackColor = storage.read('sentBackColor');
    }
    print('group id =${widget.groupID}');
    getcontroller =
        Get.put(UserChatProvider(), tag: '${widget.groupID}' + 'fromGroup');
    getcontroller!
        .onConnectScocket(groupID: widget.groupID, fromGroup: widget.fromGroup);
    getcontroller!
        .getAllMessage(userID: widget.groupID, fromGroup: widget.fromGroup);
    getcontroller!.checkTypnigStatus(
      groupId: widget.groupID,
    );
    super.initState();
    animcontroller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    getcontroller!.block_user.value = widget.blocked!;
    autoScrollController = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: scrollDirection);
  }

  @override
  void dispose() {
    getcontroller!.leaveRoom(groupId: widget.groupID);
    getcontroller!.searchText.value = '';
    animcontroller.dispose();
    getcontroller!.isReciverTyping.value = false;
    getcontroller!.isOnline.value = false;
    super.dispose();
  }

  var selectedOneToOneChat = <Messages>[].obs;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool isReply = false;

  final scrollDirection = Axis.vertical;
  AutoScrollController? autoScrollController;
  List<List<int>>? randomList;

  Future _scrollToIndex(int? index) async {
    print('old message index is =$index');
    await autoScrollController!
        .scrollToIndex(index!, preferPosition: AutoScrollPosition.begin);
    Future.delayed(Duration(seconds: 1), () {
      fadeIndex = -1;
    });
  }

  int fadeIndex = -1;

  Widget fadeChild({Widget? child, bool? animate}) {
    if (animate!) {
      return Flash(
        child: child!,
      );
    } else {
      return child!;
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = Get.height;
    var width = Get.width;
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              height: height,
              width: width,
              child: Column(
                children: [
                  selectedOneToOneChat.isNotEmpty
                      ? Container(
                          decoration: BoxDecoration(color: primaryColor),
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    selectedOneToOneChat.clear();
                                    setState(() {});
                                  },
                                  icon: Icon(Icons.clear)),
                              Text('${selectedOneToOneChat.length}'),
                              Expanded(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.edit,
                                      size: 20,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.redo,
                                      size: 20,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      // Clipboard.setData(ClipboardData(
                                      //     text:
                                      //     "${getcontroller!.oneToOneChat[i].message!.message}"));
                                      // ScaffoldMessenger.of(context)
                                      //     .showSnackBar(SnackBar(
                                      //     content: Text("Coped"),
                                      //     duration: Duration(seconds: 1)));
                                    },
                                    icon: Icon(
                                      Icons.copy,
                                      size: 20,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      // for (var i = 0;
                                      // i < selectedOneToOneChat.length;
                                      // i++) {
                                      //   Map payLoad = {
                                      //     'm_id':
                                      //     '${selectedOneToOneChat[i].message!.mId}',
                                      //     'userId':
                                      //     '${selectedOneToOneChat[i].sender!.userId}'
                                      //   };
                                      //   ApiUtils.removeMessageApi(map: payLoad);
                                      //   getcontroller!.oneToOneChat
                                      //       .remove(selectedOneToOneChat[i]);
                                      //   selectedOneToOneChat.clear();
                                      //   setState(() {});
                                      // }
                                    },
                                    icon: Icon(
                                      CupertinoIcons.delete,
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
                      : Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                Get.back();
                              },
                            ),
                            CircularProfileAvatar(
                              '${widget.profilePic}',
                              borderColor: Colors.black26,
                              borderWidth: 0.5,
                              onTap: () {
                                Get.to(Photo_View_Class(
                                  url: '${widget.profilePic}',
                                ));
                              },
                              radius: height / 40,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  if (!widget.fromGroup!) {
                                    Get.to(UserChatInformation(
                                        userID: widget.groupID));
                                  } else {
                                    Get.to(GroupInformation(
                                      groupModel: widget.groupModel,
                                    ));
                                  }
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${widget.name}',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                    Obx(
                                      () => getcontroller!.isReciverTyping.value
                                          ? Text(
                                              'Typing ...',
                                              style: TextStyle(
                                                  fontSize: 9,
                                                  color: Colors.black26),
                                            )
                                          : getcontroller!.isOnline.value
                                              ? Text(
                                                  'Online',
                                                  style: TextStyle(
                                                      fontSize: 9,
                                                      color: Colors.black26),
                                                )
                                              : SizedBox(),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                  SizedBox(
                    height: height / 50,
                  ),
                  Expanded(
                      child: Obx(() => Container(
                            child: ListView.builder(
                              scrollDirection: scrollDirection,
                              controller: autoScrollController,
                              itemBuilder: (c, i) {
                                String? extension = '';
                                if (getcontroller!.userChat[i].media != '') {
                                  // extension = p.extension(getcontroller!
                                  //     .oneToOneChat[i].message!.message!);
                                }
                                return AutoScrollTag(
                                    key: ValueKey(i),
                                    controller: autoScrollController!,
                                    index: i,
                                    child: fadeChild(
                                      animate: fadeIndex == i ? true : false,
                                      child: SwipeTo(
                                        child:
                                            getcontroller!
                                                        .userChat[i].position !=
                                                    'right'
                                                ? Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      SizedBox(
                                                        height: width / 20,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          selectedOneToOneChat
                                                                  .isNotEmpty
                                                              ? !selectedOneToOneChat
                                                                      .contains(
                                                                          getcontroller!
                                                                              .userChat[i])
                                                                  ? Container(
                                                                      height:
                                                                          20,
                                                                      width: 20,
                                                                      decoration: BoxDecoration(
                                                                          shape: BoxShape
                                                                              .circle,
                                                                          border: Border.all(
                                                                              width: 1,
                                                                              color: buttonColor)),
                                                                    )
                                                                  : Container(
                                                                      height:
                                                                          20,
                                                                      width: 20,
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .check_circle,
                                                                        color:
                                                                            buttonColor,
                                                                      ),
                                                                    )
                                                              : SizedBox(),
                                                          SizedBox(
                                                            width: width / 100,
                                                          ),
                                                          IntrinsicWidth(
                                                            child:
                                                                FocusedMenuHolder(
                                                              blurSize: 5.0,
                                                              menuItemExtent:
                                                                  45,
                                                              enableMenu:
                                                                  selectedOneToOneChat
                                                                          .isEmpty
                                                                      ? true
                                                                      : false,
                                                              onCneTapMenuItems: <
                                                                  FocusedMenuItem>[
                                                                FocusedMenuItem(
                                                                    title: Text(
                                                                        "Info"),
                                                                    onPressed:
                                                                        () {},
                                                                    trailingIcon:
                                                                        Icon(
                                                                      CupertinoIcons
                                                                          .info,
                                                                      size: 20,
                                                                    )),
                                                                FocusedMenuItem(
                                                                    title: Text(
                                                                        "Reply"),
                                                                    onPressed:
                                                                        () {},
                                                                    trailingIcon: Icon(
                                                                        CupertinoIcons
                                                                            .reply,
                                                                        size:
                                                                            20)),
                                                                FocusedMenuItem(
                                                                    title: Text(
                                                                        "Forward"),
                                                                    onPressed:
                                                                        () {
                                                                      if (!selectedOneToOneChat
                                                                          .contains(
                                                                              getcontroller!.userChat[i])) {
                                                                        selectedOneToOneChat
                                                                            .add(getcontroller!.userChat[i]);
                                                                      } else {
                                                                        selectedOneToOneChat
                                                                            .remove(getcontroller!.userChat[i]);
                                                                      }
                                                                      setState(
                                                                          () {});
                                                                    },
                                                                    trailingIcon: Icon(
                                                                        CupertinoIcons
                                                                            .goforward,
                                                                        size:
                                                                            20)),
                                                                FocusedMenuItem(
                                                                    title: Text(
                                                                        "Copy"),
                                                                    onPressed:
                                                                        () {
                                                                      Clipboard.setData(
                                                                          ClipboardData(
                                                                              text: "${getcontroller!.userChat[i].text}"));
                                                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                          content: Text(
                                                                              'Copyed'),
                                                                          duration:
                                                                              Duration(seconds: 1)));
                                                                    },
                                                                    trailingIcon: Icon(
                                                                        CupertinoIcons
                                                                            .square_on_circle,
                                                                        size:
                                                                            20)),
                                                                FocusedMenuItem(
                                                                    title: Text(
                                                                      "Delete",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.red),
                                                                    ),
                                                                    onPressed:
                                                                        () {},
                                                                    trailingIcon:
                                                                        Icon(
                                                                      CupertinoIcons
                                                                          .delete,
                                                                      size: 20,
                                                                      color: Colors
                                                                          .red,
                                                                    )),
                                                              ],
                                                              menuWidth:
                                                                  width * 0.4,
                                                              animateMenuItems:
                                                                  false,
                                                              blurBackgroundColor:
                                                                  Colors
                                                                      .black54,
                                                              menuOffset: 10,
                                                              onPressed: () {
                                                                // if (getcontroller!
                                                                //         .oneToOneChat[i]
                                                                //         .oldmessage !=
                                                                //     null) {
                                                                //   isActivePositionTap
                                                                //           .value =
                                                                //       false;
                                                                //   _scrollToIndex(getcontroller!
                                                                //       .oneToOneChat
                                                                //       .indexWhere((element) =>
                                                                //           element.message!.message == getcontroller!.oneToOneChat[i].oldmessage!.oMessage &&
                                                                //           element.sender!.userId.toString() == getcontroller!.oneToOneChat[i].oldmessage!.oSender.toString()));
                                                                //   fadeIndex = getcontroller!
                                                                //       .oneToOneChat
                                                                //       .indexWhere((element) =>
                                                                //           element.message!.message == getcontroller!.oneToOneChat[i].oldmessage!.oMessage &&
                                                                //           element.sender!.userId.toString() == getcontroller!.oneToOneChat[i].oldmessage!.oSender.toString());
                                                                //   setState(
                                                                //       () {});
                                                                //   Future.delayed(
                                                                //       Duration(
                                                                //           seconds: 1),
                                                                //       () {
                                                                //     fadeIndex =
                                                                //         -1;
                                                                //     isActivePositionTap.value =
                                                                //         true;
                                                                //     setState(
                                                                //         () {});
                                                                //   });
                                                                // } else {
                                                                //   if (selectedOneToOneChat
                                                                //       .isNotEmpty) {
                                                                //     if (!selectedOneToOneChat
                                                                //         .contains(getcontroller!.oneToOneChat[i])) {
                                                                //       selectedOneToOneChat
                                                                //           .add(getcontroller!.oneToOneChat[i]);
                                                                //     } else {
                                                                //       selectedOneToOneChat
                                                                //           .remove(getcontroller!.oneToOneChat[i]);
                                                                //     }
                                                                //     setState(
                                                                //         () {});
                                                                //   }
                                                                // }
                                                              },
                                                              onlongPress: () {
                                                                // if (!selectedOneToOneChat
                                                                //     .contains(
                                                                //         getcontroller!.oneToOneChat[i])) {
                                                                //   selectedOneToOneChat.add(
                                                                //       getcontroller!
                                                                //           .oneToOneChat[i]);
                                                                // } else {
                                                                //   selectedOneToOneChat
                                                                //       .remove(
                                                                //           getcontroller!.oneToOneChat[i]);
                                                                // }
                                                                // setState(
                                                                //     () {});
                                                              },
                                                              openWithTap: true,
                                                              child: Column(
                                                                children: [
                                                                  ''.contains(
                                                                          'Contacts#=-:')
                                                                      ? ContactViewChat()
                                                                      : ''.contains(
                                                                              'longitude')
                                                                          ? LocationViewUserChat()
                                                                          : extension.contains('image')
                                                                              ? ImageViewUserChat()
                                                                              : extension.contains('video')
                                                                                  ? VideoUserChat()
                                                                                  : extension.contains('audio')
                                                                                      ? AudioChatUser()
                                                                                      : extension.contains('Doc')
                                                                                          ? DocumentUserChat()
                                                                                          : TextUserChat(
                                                                                              model: getcontroller!.userChat[i],
                                                                                              fromGroup: widget.fromGroup,
                                                                                            ),
                                                                  SizedBox(
                                                                    height:
                                                                        height /
                                                                            200,
                                                                  ),
                                                                ],
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )
                                                : Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: <Widget>[
                                                      SizedBox(
                                                        height: width / 20,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          selectedOneToOneChat
                                                                  .isNotEmpty
                                                              ? Expanded(
                                                                  child: Row(
                                                                    children: [
                                                                      !selectedOneToOneChat
                                                                              .contains(getcontroller!.userChat[i])
                                                                          ? Container(
                                                                              height: 20,
                                                                              width: 20,
                                                                              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(width: 1, color: buttonColor)),
                                                                            )
                                                                          : Container(
                                                                              height: 20,
                                                                              width: 20,
                                                                              child: Icon(
                                                                                Icons.check_circle,
                                                                                color: buttonColor,
                                                                              ),
                                                                            ),
                                                                    ],
                                                                  ),
                                                                )
                                                              : SizedBox(),
                                                          SizedBox(
                                                            width: width / 100,
                                                          ),
                                                          ConstrainedBox(
                                                              constraints:
                                                                  BoxConstraints(
                                                                      maxWidth:
                                                                          width /
                                                                              1.5),
                                                              child:
                                                                  IntrinsicWidth(
                                                                child:
                                                                    FocusedMenuHolder(
                                                                  blurSize: 5.0,
                                                                  menuItemExtent:
                                                                      45,
                                                                  menuWidth:
                                                                      width *
                                                                          0.4,
                                                                  animateMenuItems:
                                                                      false,
                                                                  enableMenu:
                                                                      selectedOneToOneChat
                                                                              .isEmpty
                                                                          ? true
                                                                          : false,
                                                                  menuOffset:
                                                                      10,
                                                                  onlongPress:
                                                                      () async {
                                                                    // if (!selectedOneToOneChat
                                                                    //     .contains(
                                                                    //         getcontroller!.oneToOneChat[i])) {
                                                                    //   selectedOneToOneChat.add(
                                                                    //       getcontroller!
                                                                    //           .oneToOneChat[i]);
                                                                    // } else {
                                                                    //   selectedOneToOneChat
                                                                    //       .remove(
                                                                    //           getcontroller!.oneToOneChat[i]);
                                                                    // }
                                                                    // setState(
                                                                    //     () {});
                                                                  },
                                                                  onCneTapMenuItems: <
                                                                      FocusedMenuItem>[
                                                                    FocusedMenuItem(
                                                                        title: Text(
                                                                            "Info"),
                                                                        onPressed:
                                                                            () {
                                                                          showMessageDetailedDialog(
                                                                              context: context,
                                                                              model: getcontroller!.userChat[i]);
                                                                        },
                                                                        trailingIcon:
                                                                            Icon(
                                                                          CupertinoIcons
                                                                              .info,
                                                                          size:
                                                                              20,
                                                                        )),
                                                                    FocusedMenuItem(
                                                                        title: Text(
                                                                            "Reply"),
                                                                        onPressed:
                                                                            () {},
                                                                        trailingIcon: Icon(
                                                                            CupertinoIcons
                                                                                .reply,
                                                                            size:
                                                                                20)),
                                                                    FocusedMenuItem(
                                                                        title: Text(
                                                                            "Forward"),
                                                                        onPressed:
                                                                            () {
                                                                          // if (!selectedOneToOneChat
                                                                          //     .contains(getcontroller!.oneToOneChat[i])) {
                                                                          //   selectedOneToOneChat.add(getcontroller!.oneToOneChat[i]);
                                                                          // } else {
                                                                          //   selectedOneToOneChat.remove(getcontroller!.oneToOneChat[i]);
                                                                          // }
                                                                          // setState(
                                                                          //     () {});
                                                                        },
                                                                        trailingIcon: Icon(
                                                                            CupertinoIcons
                                                                                .goforward,
                                                                            size:
                                                                                20)),
                                                                    FocusedMenuItem(
                                                                        title: Text(
                                                                            'Copy'),
                                                                        onPressed:
                                                                            () {
                                                                          // Clipboard.setData(
                                                                          //     ClipboardData(text: "${getcontroller!.oneToOneChat[i].message!.message}"));
                                                                          // ScaffoldMessenger.of(context)
                                                                          //     .showSnackBar(SnackBar(
                                                                          //   content:
                                                                          //       Text('Copyed'),
                                                                          //   duration:
                                                                          //       Duration(seconds: 1),
                                                                          // ));
                                                                        },
                                                                        trailingIcon: Icon(
                                                                            CupertinoIcons
                                                                                .square_on_circle,
                                                                            size:
                                                                                20)),
                                                                    FocusedMenuItem(
                                                                        title:
                                                                            Text(
                                                                          "Delete",
                                                                          style:
                                                                              TextStyle(color: Colors.red),
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          // Map payLoad =
                                                                          //     {
                                                                          //   'm_id':
                                                                          //       '${getcontroller!.oneToOneChat[i].message!.mId}',
                                                                          //   'userId':
                                                                          //       '${getcontroller!.oneToOneChat[i].sender!.userId}'
                                                                          // };
                                                                          //
                                                                          // ApiUtils.removeMessageApi(
                                                                          //     map: payLoad);
                                                                          // getcontroller!
                                                                          //     .oneToOneChat
                                                                          //     .removeAt(i);
                                                                        },
                                                                        trailingIcon:
                                                                            Icon(
                                                                          CupertinoIcons
                                                                              .delete,
                                                                          size:
                                                                              20,
                                                                          color:
                                                                              Colors.red,
                                                                        )),
                                                                  ],
                                                                  onPressed:
                                                                      () {
                                                                    // if (getcontroller!
                                                                    //         .oneToOneChat[i]
                                                                    //         .oldmessage !=
                                                                    //     null) {
                                                                    //   isActivePositionTap
                                                                    //           .value =
                                                                    //       false;
                                                                    //   _scrollToIndex(getcontroller!
                                                                    //       .oneToOneChat
                                                                    //       .indexWhere((element) =>
                                                                    //           element.message!.message == getcontroller!.oneToOneChat[i].oldmessage!.oMessage &&
                                                                    //           element.sender!.userId.toString() == getcontroller!.oneToOneChat[i].oldmessage!.oSender.toString()));
                                                                    //   fadeIndex = getcontroller!
                                                                    //       .oneToOneChat
                                                                    //       .indexWhere((element) =>
                                                                    //           element.message!.message == getcontroller!.oneToOneChat[i].oldmessage!.oMessage &&
                                                                    //           element.sender!.userId.toString() == getcontroller!.oneToOneChat[i].oldmessage!.oSender.toString());
                                                                    //   setState(
                                                                    //       () {});
                                                                    //   Future.delayed(
                                                                    //       Duration(
                                                                    //           seconds: 1),
                                                                    //       () {
                                                                    //     fadeIndex =
                                                                    //         -1;
                                                                    //     isActivePositionTap.value =
                                                                    //         true;
                                                                    //     setState(
                                                                    //         () {});
                                                                    //   });
                                                                    // } else {
                                                                    //   if (selectedOneToOneChat
                                                                    //       .isNotEmpty) {
                                                                    //     if (!selectedOneToOneChat
                                                                    //         .contains(getcontroller!.oneToOneChat[i])) {
                                                                    //       selectedOneToOneChat
                                                                    //           .add(getcontroller!.oneToOneChat[i]);
                                                                    //     } else {
                                                                    //       selectedOneToOneChat
                                                                    //           .remove(getcontroller!.oneToOneChat[i]);
                                                                    //     }
                                                                    //     setState(
                                                                    //         () {});
                                                                    //   }
                                                                    // }
                                                                  },
                                                                  child: Column(
                                                                    children: [
                                                                      ''.contains(
                                                                              'Contacts#=-:')
                                                                          ? ContactViewChat()
                                                                          : ''.contains('longitude')
                                                                              ? LocationViewUserChat()
                                                                              : extension.contains('image')
                                                                                  ? ImageViewUserChat()
                                                                                  : extension.contains('video')
                                                                                      ? VideoUserChat()
                                                                                      : extension.contains('audio')
                                                                                          ? AudioChatUser()
                                                                                          : extension.contains('Doc')
                                                                                              ? DocumentUserChat()
                                                                                              : extension.contains('.reply')
                                                                                                  ? ReplyUserChat()
                                                                                                  : TextUserChat(
                                                                                                      model: getcontroller!.userChat[i],
                                                                                                      fromGroup: widget.fromGroup,
                                                                                                    ),
                                                                      SizedBox(
                                                                        height: height /
                                                                            200,
                                                                      ),
                                                                    ],
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .end,
                                                                  ),
                                                                ),
                                                              )),
                                                          SizedBox(
                                                            width: width / 100,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                        onRightSwipe: () {
                                          // replyModel.value =
                                          //     getcontroller!.oneToOneChat[i];
                                          // isActivereply.value = true;
                                          // setState(() {});
                                        },
                                        onLeftSwipe: () {
                                          //smsInformation(context: context);
                                        },
                                        leftSwipeWidget: SizedBox(),
                                        iconOnRightSwipe: CupertinoIcons.reply,
                                      ),
                                    ),
                                    highlightColor: Colors.black);
                              },
                              reverse: true,
                              itemCount: getcontroller!.userChat.length,
                            ),
                            padding: EdgeInsets.only(
                                left: width / 25, right: width / 25),
                          ))),
                  // isActivereply.value == true
                  //     ? Container(
                  //         decoration: BoxDecoration(color: Colors.blueGrey[50]),
                  //         child: Row(
                  //           children: [
                  //             Container(
                  //               height: height * 0.060,
                  //               width: 3,
                  //               decoration:
                  //                   BoxDecoration(color: Colors.deepPurple),
                  //             ),
                  //             SizedBox(
                  //               width: 5,
                  //             ),
                  //             Expanded(
                  //               child: Column(
                  //                 mainAxisAlignment: MainAxisAlignment.center,
                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                 children: [
                  //                   Text(
                  //                     storage.read('userID') !=
                  //                             replyModel.value.sender!.userId
                  //                                 .toString()
                  //                         ? '${replyModel.value.sender!.firstName} ${replyModel.value.sender!.lastName}'
                  //                         : 'You',
                  //                     style: TextStyle(
                  //                         fontSize: 13,
                  //                         fontWeight: FontWeight.w500,
                  //                         color: Colors.deepPurple),
                  //                   ),
                  //                   SizedBox(
                  //                     height: 2,
                  //                   ),
                  //                   Text(
                  //                     replyModel.value.message!.type == 'text'
                  //                         ? '${replyModel.value.message!.message}'
                  //                         : '${replyModel.value.message!.type}',
                  //                     maxLines: 1,
                  //                     style: TextStyle(fontSize: 10),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //             SizedBox(
                  //               height: 10,
                  //             ),
                  //             Container(
                  //               child: Row(
                  //                 children: [
                  //                   InkWell(
                  //                     onTap: () {
                  //                       replyModel.value = OneToOneChatModel();
                  //                       isActivereply.value = false;
                  //                       setState(() {});
                  //                     },
                  //                     child: Container(
                  //                       child: Icon(
                  //                         Icons.close,
                  //                         size: 17,
                  //                       ),
                  //                       decoration: BoxDecoration(
                  //                           color: Colors.black12,
                  //                           shape: BoxShape.circle),
                  //                       padding: EdgeInsets.all(3),
                  //                     ),
                  //                   ),
                  //                   SizedBox(
                  //                     width: 10,
                  //                   )
                  //                 ],
                  //               ),
                  //             )
                  //           ],
                  //         ),
                  //       )
                  //     : SizedBox(),
                  selectedOneToOneChat.isNotEmpty
                      ? Container(
                          height: height * 0.050,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(color: primaryColor),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              selectedOneToOneChat.length > 1
                                  ? SizedBox()
                                  : Row(
                                      children: [
                                        Icon(Icons.undo),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          'Reply',
                                          style: TextStyle(fontSize: 13),
                                        )
                                      ],
                                    ),
                              InkWell(
                                onTap: () async {
                                  var listofmap = [];
                                  await getcontroller!.getFriendList();
                                  showMaterialModalBottomSheet(
                                    context: context,
                                    builder: (context) => StatefulBuilder(
                                        builder: (context, setState) {
                                      return Container(
                                        height: height - 100,
                                        width: width,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: Row(
                                                children: [
                                                  InkWell(
                                                    child: Text(
                                                      'Cancel',
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          color: Colors.blue,
                                                          fontFamily:
                                                              AppFonts.segoeui),
                                                    ),
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                  listofmap.isNotEmpty
                                                      ? InkWell(
                                                          child: Text(
                                                            'Forward',
                                                            style: TextStyle(
                                                                fontSize: 17,
                                                                color:
                                                                    Colors.blue,
                                                                fontFamily:
                                                                    AppFonts
                                                                        .segoeui),
                                                          ),
                                                          onTap: () {
                                                            // for (var i
                                                            //     in listofmap) {
                                                            //   for (var j
                                                            //       in selectedOneToOneChat) {
                                                            //     Map map = {
                                                            //       'message':
                                                            //           '${j.message!.message}',
                                                            //       'memberId[]':
                                                            //           '$i'
                                                            //     };
                                                            //     ApiUtils
                                                            //         .sendMessagepost(
                                                            //             map:
                                                            //                 map);
                                                            //   }
                                                            // }
                                                            Navigator.of(
                                                                    context)
                                                                .pop(true);
                                                          },
                                                        )
                                                      : SizedBox()
                                                ],
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                              ),
                                            ),
                                            // Expanded(
                                            //   child: ListView.builder(
                                            //     itemCount: getcontroller!
                                            //         .searchUserModel
                                            //         .value
                                            //         .friends!
                                            //         .length,
                                            //     itemBuilder: (context, i) =>
                                            //         Column(
                                            //       children: [
                                            //         ListTile(
                                            //           leading:
                                            //               CircularProfileAvatar(
                                            //             '',
                                            //             radius: 23,
                                            //             child: Image.network(
                                            //               '${getcontroller!.searchUserModel.value.friends![i].profilePictureUrl}',
                                            //               fit: BoxFit.cover,
                                            //             ),
                                            //           ),
                                            //           title: Text(
                                            //             '${getcontroller!.searchUserModel.value.friends![i].firstName} ${getcontroller!.searchUserModel.value.friends![i].lastName}',
                                            //             style: TextStyle(
                                            //                 fontFamily: AppFonts
                                            //                     .segoeui,
                                            //                 fontSize: 13),
                                            //           ),
                                            //           trailing: Row(
                                            //             mainAxisSize:
                                            //                 MainAxisSize.min,
                                            //             children: [
                                            //               InkWell(
                                            //                 child: Container(
                                            //                   height: 25,
                                            //                   width: 60,
                                            //                   child: Center(
                                            //                     child: Icon(
                                            //                       Icons.check,
                                            //                       size: 18,
                                            //                       color: !listofmap.contains(getcontroller!
                                            //                               .searchUserModel
                                            //                               .value
                                            //                               .friends![
                                            //                                   i]
                                            //                               .userId
                                            //                               .toString())
                                            //                           ? Colors
                                            //                               .transparent
                                            //                           : Colors
                                            //                               .white,
                                            //                     ),
                                            //                   ),
                                            //                   decoration:
                                            //                       BoxDecoration(
                                            //                     shape: BoxShape
                                            //                         .circle,
                                            //                     color: !listofmap.contains(getcontroller!
                                            //                             .searchUserModel
                                            //                             .value
                                            //                             .friends![
                                            //                                 i]
                                            //                             .userId
                                            //                             .toString())
                                            //                         ? Colors
                                            //                             .transparent
                                            //                         : Colors
                                            //                             .green,
                                            //                     border: Border.all(
                                            //                         color: !listofmap.contains(getcontroller!
                                            //                                 .searchUserModel
                                            //                                 .value
                                            //                                 .friends![
                                            //                                     i]
                                            //                                 .userId
                                            //                                 .toString())
                                            //                             ? Colors
                                            //                                 .black12
                                            //                             : Colors
                                            //                                 .green,
                                            //                         width: 2),
                                            //                   ),
                                            //                 ),
                                            //                 onTap: () {
                                            //                   if (listofmap.contains(
                                            //                       getcontroller!
                                            //                           .searchUserModel
                                            //                           .value
                                            //                           .friends![
                                            //                               i]
                                            //                           .userId
                                            //                           .toString())) {
                                            //                     listofmap.remove(
                                            //                         getcontroller!
                                            //                             .searchUserModel
                                            //                             .value
                                            //                             .friends![
                                            //                                 i]
                                            //                             .userId
                                            //                             .toString());
                                            //                     setState(() {});
                                            //                   } else {
                                            //                     listofmap.add(getcontroller!
                                            //                         .searchUserModel
                                            //                         .value
                                            //                         .friends![i]
                                            //                         .userId
                                            //                         .toString()
                                            //                         .trim());
                                            //                     setState(() {});
                                            //                   }
                                            //                 },
                                            //               ),
                                            //             ],
                                            //           ),
                                            //         ),
                                            //         SizedBox(
                                            //           height: 8,
                                            //         ),
                                            //       ],
                                            //     ),
                                            //   ),
                                            // )
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
                                child: Row(
                                  children: [
                                    Icon(Icons.redo),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Forward',
                                      style: TextStyle(fontSize: 13),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      : Container(
                          height: height / 22,
                          width: width,
                          decoration: BoxDecoration(color: Colors.white),
                          child: Obx(() => getcontroller!.block_user.value
                              ? Center(
                                  child: Text(
                                      'You cannot reply to this conversation'),
                                )
                              : Row(
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        // showModalBottomSheet(
                                        //     context: context,
                                        //     builder: (context) {
                                        //       return Wrap(
                                        //         children: [
                                        //           ListTile(
                                        //             leading: Icon(
                                        //               Icons.image,
                                        //               color: primaryColor,
                                        //             ),
                                        //             title: Text(
                                        //               'Photo & Video',
                                        //               style: TextStyle(
                                        //                   fontSize: 16,
                                        //                   letterSpacing: 0.5),
                                        //             ),
                                        //             onTap: () async {
                                        //               FilePickerResult? result =
                                        //                   await FilePicker
                                        //                       .platform
                                        //                       .pickFiles(
                                        //                 type: FileType.media,
                                        //               );
                                        //               if (result!
                                        //                   .files.isNotEmpty) {
                                        //                 print(
                                        //                     'file path is = ${result.files[0].path}');
                                        //                 getcontroller!
                                        //                     .sentMessageViaFile(
                                        //                         groupId: widget
                                        //                             .groupID,
                                        //                         filePath:
                                        //                             '${result.files[0].path}');
                                        //                 Navigator.of(context)
                                        //                     .pop();
                                        //               }
                                        //             },
                                        //           ),
                                        //           ListTile(
                                        //             leading: Icon(
                                        //               Icons.file_copy_outlined,
                                        //               color: primaryColor,
                                        //             ),
                                        //             title: Text(
                                        //               'Documents',
                                        //               style: TextStyle(
                                        //                   fontSize: 16,
                                        //                   letterSpacing: 0.5),
                                        //             ),
                                        //             onTap: () async {
                                        //               FilePickerResult? result =
                                        //                   await FilePicker
                                        //                       .platform
                                        //                       .pickFiles(
                                        //                 type: FileType.custom,
                                        //                 allowedExtensions: [
                                        //                   'pdf',
                                        //                   'doc'
                                        //                 ],
                                        //               );
                                        //               if (result!
                                        //                   .files.isNotEmpty) {
                                        //                 print(
                                        //                     'file path is = ${result.files[0].path}');
                                        //                 getcontroller!
                                        //                     .sentMessageViaFile(
                                        //                         groupId: widget
                                        //                             .groupID,
                                        //                         filePath:
                                        //                             '${result.files[0].path}');
                                        //                 Navigator.of(context)
                                        //                     .pop();
                                        //               }
                                        //             },
                                        //           ),
                                        //           ListTile(
                                        //             leading: Icon(
                                        //               Icons
                                        //                   .location_on_outlined,
                                        //               color: primaryColor,
                                        //             ),
                                        //             title: Text(
                                        //               'Location',
                                        //               style: TextStyle(
                                        //                   fontSize: 16,
                                        //                   letterSpacing: 0.5),
                                        //             ),
                                        //             onTap: () {
                                        //               Get.to(MapClass())!
                                        //                   .then((value) {
                                        //                 if (value is String) {
                                        //                   print(
                                        //                       'locatoin ia = $value');
                                        //                   getcontroller!
                                        //                       .onSentMessage(
                                        //                           message:
                                        //                               value,
                                        //                           groupId: widget
                                        //                               .groupID);
                                        //                 }
                                        //                 Navigator.of(context)
                                        //                     .pop();
                                        //               });
                                        //             },
                                        //           ),
                                        //           ListTile(
                                        //             leading: Icon(
                                        //               Icons.person_outline,
                                        //               color: primaryColor,
                                        //             ),
                                        //             title: Text(
                                        //               'Contacts',
                                        //               style: TextStyle(
                                        //                   fontSize: 16,
                                        //                   letterSpacing: 0.5),
                                        //             ),
                                        //             onTap: () {
                                        //               Get.to(GetAllContactsPage())!
                                        //                   .then((value) {
                                        //                 if (value is String) {
                                        //                   print(
                                        //                       'Contacts ia = $value');
                                        //                   getcontroller!
                                        //                       .onSentMessage(
                                        //                           message:
                                        //                               value,
                                        //                           groupId: widget
                                        //                               .groupID);
                                        //                 }
                                        //                 Navigator.of(context)
                                        //                     .pop();
                                        //               });
                                        //             },
                                        //           ),
                                        //         ],
                                        //       );
                                        //     });
                                      },
                                      child: Icon(
                                        Icons.add,
                                        size: 35,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Expanded(
                                      child: Container(
                                        width: double.infinity,
                                        child: TextFormField(
                                          controller: controller,
                                          onChanged: (value) {
                                            if (!getcontroller!
                                                .startTyping.value) {
                                              getcontroller!.startTyping.value =
                                                  true;
                                              getcontroller!.userTypingStart(
                                                  groupId: widget.groupID);
                                            }
                                            getcontroller!.searchText.value =
                                                value;
                                          },
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14),
                                          decoration: InputDecoration(
                                              disabledBorder:
                                                  new OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      borderSide:
                                                          new BorderSide(
                                                        color: Colors.black12,
                                                      )),
                                              focusedBorder:
                                                  new OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      borderSide:
                                                          new BorderSide(
                                                        color: Colors.black12,
                                                      )),
                                              enabledBorder:
                                                  new OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      borderSide:
                                                          new BorderSide(
                                                        color: Colors.black12,
                                                      )),
                                              border: new OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  borderSide: new BorderSide(
                                                    color: Colors.black12,
                                                  )),
                                              contentPadding:
                                                  EdgeInsets.all(12),
                                              hintText: '',
                                              isDense: true,
                                              hintStyle: TextStyle(
                                                  fontSize: 11,
                                                  letterSpacing: 0.5,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400)),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        // final ImagePicker _picker =
                                        //     ImagePicker();
                                        // var pickedFile = await _picker.getImage(
                                        //   source: ImageSource.camera,
                                        // );
                                        // print(
                                        //     'file path is = ${pickedFile!.path}');
                                        // if (pickedFile != null) {
                                        //   getcontroller!.sentMessageViaFile(
                                        //       groupId: widget.groupID,
                                        //       filePath: '${pickedFile.path}');
                                        //   Navigator.of(context).pop();
                                        // }
                                      },
                                      child: Icon(
                                        Icons.camera_alt_outlined,
                                        color: primaryColor,
                                        size: 35,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Obx(
                                      () => getcontroller!
                                              .searchText.value.isEmpty
                                          ? RecordButton(
                                              controller: animcontroller,
                                              RecordStart: () async {
                                                // bool result =
                                                //     await record.Record()
                                                //         .hasPermission();
                                                // String path =
                                                //     await getFilePath();
                                                // audio_path = path;
                                                // if (result) {
                                                //   RecordMp3.instance
                                                //       .start(path, (type) {});
                                                //   getcontroller!.recording_start
                                                //       .value = true;
                                                // } else {
                                                //   print('access deny');
                                                // }
                                                // setState(() {});
                                              },
                                              recordStop: () async {
                                                RecordMp3.instance.stop();
                                                getcontroller!.recording_start
                                                    .value = false;
                                                Future.delayed(
                                                    Duration(milliseconds: 500),
                                                    () {
                                                  print(
                                                      'audio path is =${audio_path}');
                                                  getcontroller!
                                                      .sentMessageViaFile(
                                                          groupId:
                                                              widget.groupID,
                                                          filePath:
                                                              '$audio_path');
                                                });
                                                setState(() {});
                                              },
                                            )
                                          : InkWell(
                                              onTap: () {
                                                if (isActivereply.value) {
                                                  // Map map = {
                                                  //   'message':
                                                  //       '${controller.text}',
                                                  //   'groupId': widget.groupID,
                                                  //   'reply_msg_id':
                                                  //       '${replyModel.value.message!.mId}'
                                                  // };
                                                  // ApiUtils.sendMessagepost(
                                                  //     map: map);
                                                  // replyModel.value =
                                                  //     OneToOneChatModel();
                                                  // isActivereply.value = false;
                                                  // controller.clear();
                                                  // getcontroller!
                                                  //     .searchText.value = '';
                                                  // setState(() {});
                                                } else {
                                                  if (controller.text
                                                      .trim()
                                                      .isNotEmpty) {
                                                    getcontroller!
                                                        .onSentMessage(
                                                            message:
                                                                controller.text,
                                                            to_userId:
                                                                widget.groupID,
                                                            fromGroup: widget
                                                                .fromGroup);
                                                    controller.clear();
                                                    getcontroller!
                                                        .searchText.value = '';
                                                  }
                                                }
                                              },
                                              child: Container(
                                                height: height / 18,
                                                width: width / 10,
                                                child: Center(
                                                  child: Icon(
                                                    Icons.send_outlined,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: primaryColor),
                                              ),
                                            ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                  ],
                                )),
                        ),
                  SizedBox(
                    height: 5,
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.start,
              ),
            ),
          ],
        ),
      ),
    );
  }

  int i = 0;

  Future<String> getFilePath() async {
    Directory storageDirectory = await getApplicationDocumentsDirectory();
    String sdPath = storageDirectory.path + "/record";
    var d = Directory(sdPath);
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }
    return sdPath + "/test_${i++}.mp3";
  }
}

class SmsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = Color(0xffF3F3F3)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path_0 = Path();
    path_0.moveTo(size.width, size.height * 0.0300000);
    path_0.lineTo(0, size.height * 0.5014000);
    path_0.lineTo(size.width, size.height * 0.9393000);
    path_0.lineTo(size.width, size.height * 0.0300000);
    path_0.close();

    canvas.drawPath(path_0, paint_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class SmsPainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = primaryColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path_0 = Path();
    path_0.moveTo(0, size.height);
    path_0.lineTo(0, 0);
    path_0.lineTo(size.width, size.height * 0.5019000);
    path_0.lineTo(0, size.height);
    path_0.close();

    canvas.drawPath(path_0, paint_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

Color returnColorFromString(String value) {
  return Color.fromARGB(
      int.parse(value.split(',')[0]),
      int.parse(value.split(',')[1]),
      int.parse(value.split(',')[2]),
      int.parse(value.split(',')[3]));
}
