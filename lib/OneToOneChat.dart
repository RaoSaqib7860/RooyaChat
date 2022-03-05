import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:record_mp3/record_mp3.dart';
import 'package:rooya/ApiConfig/ApiUtils.dart';
import 'package:rooya/GlobalWidget/Contacts/GetAllContactsPage.dart';
import 'package:rooya/GlobalWidget/CustomAudioPlayer/CustomAudioPlayer.dart';
import 'package:rooya/GlobalWidget/GoogleMapView.dart';
import 'package:rooya/Providers/OneToOneChatProvider.dart';
import 'package:rooya/responsive/primary_color.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'GlobalWidget/Contacts/ContactView.dart';
import 'GlobalWidget/CustomVideoPlayer.dart';
import 'package:record/record.dart' as record;
import 'GlobalWidget/FileUploader.dart';
import 'GlobalWidget/MapsClass.dart';
import 'GlobalWidget/MarqueWidget.dart';
import 'package:path/path.dart' as p;
import 'package:intl/intl.dart';
import 'GlobalWidget/MessageInformationDailog.dart';
import 'GlobalWidget/Photo_View_Class.dart';
import 'GlobalWidget/SnackBarApp.dart';
import 'PluginComponents/FocusedMenu/focused_menu.dart';
import 'PluginComponents/FocusedMenu/modals.dart';
import 'Providers/OneToOneModel.dart';
import 'User/UserChatInformation/user_chat_information.dart';

class OneToOneChat extends StatefulWidget {
  final String? groupID;
  final String? profilePic;
  final String? name;
  final bool? fromGroup;

  const OneToOneChat(
      {Key? key,
      this.groupID,
      this.profilePic,
      this.name,
      this.fromGroup = false})
      : super(key: key);

  @override
  _OneToOneChatState createState() => _OneToOneChatState();
}

class _OneToOneChatState extends State<OneToOneChat> {
  TextEditingController controller = TextEditingController();
  bool isfirst = false;
  DateFormat sdf2 = DateFormat("hh.mm aa");
  var replyModel = OneToOneChatModel().obs;
  var isActivereply = false.obs;
  OneToOneChatProvider? getcontroller;

  String audio_path = '';

  @override
  void initState() {
    print('token = ${storage.read('token')}');
    getcontroller = Get.put(OneToOneChatProvider(), tag: '${widget.groupID}');
    getcontroller!.onConnectScocket(groupID: widget.groupID);
    getcontroller!.getAllMessage(groupId: widget.groupID);
    getcontroller!.checkTypnigStatus(groupId: widget.groupID);
    super.initState();
  }

  @override
  void dispose() {
    getcontroller!.leaveRoom(groupId: widget.groupID);
    getcontroller!.searchText.value = '';
    super.dispose();
  }

  Stopwatch watch = Stopwatch();
  Timer? timer;
  bool startStop = false;
  String elapsedTime = '';

  updateTime(Timer timer) {
    if (watch.isRunning) {
      setState(() {
        print("startstop Inside=$startStop");
        elapsedTime = transformMilliSeconds(watch.elapsedMilliseconds);
      });
    }
  }

  startOrStop() {
    if (startStop) {
      startWatch();
    } else {
      stopWatch();
    }
  }

  startWatch() {
    setState(() {
      startStop = false;
      watch.start();
      timer = Timer.periodic(Duration(milliseconds: 100), updateTime);
    });
  }

  stopWatch() {
    setState(() {
      startStop = true;
      watch.stop();
      setTime();
    });
  }

  setTime() {
    var timeSoFar = watch.elapsedMilliseconds;
    setState(() {
      elapsedTime = transformMilliSeconds(timeSoFar);
    });
  }

  transformMilliSeconds(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();
    String hoursStr = (hours % 60).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');
    return "$hoursStr:$minutesStr:$secondsStr";
  }

  var selectedOneToOneChat = <OneToOneChatModel>[].obs;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
                                      Clipboard.setData(ClipboardData(
                                          text:
                                              "${getcontroller!.oneToOneChat[i].message!.message}"));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text("Coped"),
                                              duration: Duration(seconds: 1)));
                                    },
                                    icon: Icon(
                                      Icons.copy,
                                      size: 20,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      for (var i = 0;
                                          i < selectedOneToOneChat.length;
                                          i++) {
                                        Map payLoad = {
                                          'm_id':
                                              '${selectedOneToOneChat[i].message!.mId}',
                                          'userId':
                                              '${selectedOneToOneChat[i].sender!.userId}'
                                        };

                                        ApiUtils.removeMessageApi(map: payLoad);
                                        getcontroller!.oneToOneChat
                                            .remove(selectedOneToOneChat[i]);
                                      }
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
                                  if (widget.fromGroup!) {
                                    Get.to(UserChatInformation(
                                      groupID: widget.groupID,
                                    ))!
                                        .then((value) {
                                      Navigator.of(context).pop();
                                    });
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
                              itemBuilder: (c, i) {
                                String? extension = '';
                                if (getcontroller!
                                    .oneToOneChat[i].message!.message!
                                    .contains('.')) {
                                  extension = p.extension(getcontroller!
                                      .oneToOneChat[i].message!.message!);
                                }
                                return "${getcontroller!.oneToOneChat[i].message!.message}"
                                        .isEmpty
                                    ? SizedBox()
                                    : SwipeTo(
                                        child:
                                            storage.read('userID') !=
                                                    getcontroller!
                                                        .oneToOneChat[i]
                                                        .sender!
                                                        .userId
                                                        .toString()
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
                                                                              .oneToOneChat[i])
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
                                                          ConstrainedBox(
                                                              constraints:
                                                                  BoxConstraints(
                                                                      maxWidth:
                                                                          width /
                                                                              1.7),
                                                              child:
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
                                                                            "Favorite"),
                                                                        onPressed:
                                                                            () {},
                                                                        trailingIcon:
                                                                            Icon(
                                                                          CupertinoIcons
                                                                              .heart,
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
                                                                            () {},
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
                                                                              ClipboardData(text: "${getcontroller!.oneToOneChat[i].message!.message}"));
                                                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                              content: Text('Copyed'),
                                                                              duration: Duration(seconds: 1)));
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
                                                                            () {},
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
                                                                  menuWidth:
                                                                      width *
                                                                          0.4,
                                                                  animateMenuItems:
                                                                      false,
                                                                  blurBackgroundColor:
                                                                      Colors
                                                                          .black54,
                                                                  menuOffset:
                                                                      10,
                                                                  onPressed:
                                                                      () {
                                                                    if (selectedOneToOneChat
                                                                        .isNotEmpty) {
                                                                      if (!selectedOneToOneChat
                                                                          .contains(
                                                                              getcontroller!.oneToOneChat[i])) {
                                                                        selectedOneToOneChat
                                                                            .add(getcontroller!.oneToOneChat[i]);
                                                                      } else {
                                                                        selectedOneToOneChat
                                                                            .remove(getcontroller!.oneToOneChat[i]);
                                                                      }
                                                                      setState(
                                                                          () {});
                                                                    }
                                                                  },
                                                                  onlongPress:
                                                                      () {
                                                                    if (!selectedOneToOneChat
                                                                        .contains(
                                                                            getcontroller!.oneToOneChat[i])) {
                                                                      selectedOneToOneChat.add(
                                                                          getcontroller!
                                                                              .oneToOneChat[i]);
                                                                    } else {
                                                                      selectedOneToOneChat
                                                                          .remove(
                                                                              getcontroller!.oneToOneChat[i]);
                                                                    }
                                                                    setState(
                                                                        () {});
                                                                  },
                                                                  openWithTap:
                                                                      true,
                                                                  child: Column(
                                                                    children: [
                                                                      '${getcontroller!.oneToOneChat[i].message!.message}'.contains(
                                                                              'Contacts#=-:')
                                                                          ? Builder(builder:
                                                                              (context) {
                                                                              List list = '${getcontroller!.oneToOneChat[i].message!.message}'.split(':');
                                                                              return ContactView(
                                                                                result: list[1],
                                                                              );
                                                                            })
                                                                          : '${getcontroller!.oneToOneChat[i].message!.message}'.contains('latitude') && '${getcontroller!.oneToOneChat[i].message!.message}'.contains('longitude')
                                                                              ? Builder(builder: (context) {
                                                                                  List list = '${getcontroller!.oneToOneChat[i].message!.message}'.split(',');
                                                                                  return ClipRRect(
                                                                                    borderRadius: BorderRadius.circular(5),
                                                                                    child: Container(
                                                                                      width: width,
                                                                                      height: height * 0.210,
                                                                                      padding: EdgeInsets.all(3),
                                                                                      decoration: BoxDecoration(color: Colors.blueGrey[50]),
                                                                                      child: GoogleMapView(
                                                                                        lat: list[0].toString().split(':')[1],
                                                                                        lng: list[1].toString().split(':')[1],
                                                                                        ontap: () async {
                                                                                          print('Clicked on map');
                                                                                          Position? position = await Geolocator.getLastKnownPosition();
                                                                                          launchURL('https://www.google.com/maps/dir/?api=1&origin=${position!.latitude},${position.longitude}&destination=${list[0].toString().split(':')[1]},${list[1].toString().split(':')[1]}&travelmode=driving&dir_action=navigate');
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                  );
                                                                                })
                                                                              : extension.contains('.jpg') || extension.contains('.png') || extension.contains('.jpeg')
                                                                                  ? InkWell(
                                                                                      child: Container(
                                                                                        height: height * 0.3,
                                                                                        child: Stack(
                                                                                          children: [
                                                                                            Column(
                                                                                              children: [
                                                                                                widget.fromGroup!
                                                                                                    ? Column(
                                                                                                        children: [
                                                                                                          Text(
                                                                                                            '${getcontroller!.oneToOneChat[i].sender!.firstName}' '${getcontroller!.oneToOneChat[i].sender!.lastName}',
                                                                                                            style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold, fontSize: 12),
                                                                                                          ),
                                                                                                          SizedBox(
                                                                                                            height: height / 100,
                                                                                                          ),
                                                                                                        ],
                                                                                                      )
                                                                                                    : SizedBox(),
                                                                                                Container(
                                                                                                  height: height * 0.3,
                                                                                                  child: ClipRRect(
                                                                                                    child: CachedNetworkImage(
                                                                                                      fit: BoxFit.cover,
                                                                                                      imageUrl: "${getcontroller!.oneToOneChat[i].message!.message}",
                                                                                                      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                                                                                      errorWidget: (context, url, error) => Icon(Icons.error),
                                                                                                    ),
                                                                                                    borderRadius: BorderRadius.circular(8),
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                            Align(
                                                                                              child: Padding(
                                                                                                padding: const EdgeInsets.all(8.0),
                                                                                                child: Text(
                                                                                                  '${sdf2.format(DateTime.parse("${getcontroller!.oneToOneChat[i].message!.iosDateTime}").toUtc().toLocal())}',
                                                                                                  style: TextStyle(
                                                                                                    color: Colors.white60,
                                                                                                    fontSize: 9.0,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              alignment: Alignment.bottomRight,
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                      onTap: () {
                                                                                        Get.to(Photo_View_Class(
                                                                                          url: "${getcontroller!.oneToOneChat[i].message!.message}",
                                                                                        ));
                                                                                      },
                                                                                    )
                                                                                  : extension.contains('.mp4') || extension.contains('.mov') || extension.contains('.avi') || extension.contains('.mpeg4') || extension.contains('.flv') || extension.contains('.3gp') || extension.contains('.mov')
                                                                                      ? InkWell(
                                                                                          child: Container(
                                                                                            width: width / 1.7,
                                                                                            height: height * 0.3,
                                                                                            child: Stack(
                                                                                              children: [
                                                                                                Column(
                                                                                                  children: [
                                                                                                    widget.fromGroup!
                                                                                                        ? Column(
                                                                                                            children: [
                                                                                                              Text(
                                                                                                                '${getcontroller!.oneToOneChat[i].sender!.firstName}' '${getcontroller!.oneToOneChat[i].sender!.lastName}',
                                                                                                                style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold, fontSize: 12),
                                                                                                              ),
                                                                                                              SizedBox(
                                                                                                                height: height / 100,
                                                                                                              ),
                                                                                                            ],
                                                                                                          )
                                                                                                        : SizedBox(),
                                                                                                    Container(
                                                                                                      width: width / 1.7,
                                                                                                      height: height * 0.3,
                                                                                                      decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(5)),
                                                                                                      child: Center(
                                                                                                        child: Icon(
                                                                                                          Icons.play_circle_fill,
                                                                                                          size: 40,
                                                                                                          color: Colors.white,
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                                Align(
                                                                                                  child: Padding(
                                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                                    child: Text(
                                                                                                      '${sdf2.format(DateTime.parse("${getcontroller!.oneToOneChat[i].message!.iosDateTime}").toUtc().toLocal())}',
                                                                                                      style: TextStyle(
                                                                                                        color: Colors.white60,
                                                                                                        fontSize: 9.0,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  alignment: Alignment.bottomRight,
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                          onTap: () {
                                                                                            Get.to(CustomVideoPlayer(
                                                                                              url: getcontroller!.oneToOneChat[i].message!.message,
                                                                                            ));
                                                                                            // Get.to(
                                                                                            //     VideoApp(
                                                                                            //   assetsPath:
                                                                                            //       '${getcontroller!.oneToOneChat[i].message!.message}',
                                                                                            // ));
                                                                                          },
                                                                                        )
                                                                                      : extension.contains('.mp3') || extension.contains('.aac') || extension.contains('.ac3') || extension.contains('.h264') || extension.contains('.wav') || extension.contains('.csv') || extension.contains('.wma') || extension.contains('.wmv')
                                                                                          ? Container(
                                                                                              height: height * 0.1,
                                                                                              width: width / 1.7,
                                                                                              child: Column(
                                                                                                children: [
                                                                                                  widget.fromGroup!
                                                                                                      ? Column(
                                                                                                          children: [
                                                                                                            Text(
                                                                                                              '${getcontroller!.oneToOneChat[i].sender!.firstName}' '${getcontroller!.oneToOneChat[i].sender!.lastName}',
                                                                                                              style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold, fontSize: 12),
                                                                                                            ),
                                                                                                            SizedBox(
                                                                                                              height: height / 100,
                                                                                                            ),
                                                                                                          ],
                                                                                                        )
                                                                                                      : SizedBox(),
                                                                                                  Container(
                                                                                                    height: height * 0.080,
                                                                                                    width: width / 1.7,
                                                                                                    child: CustomAudioPlayer(
                                                                                                      url: getcontroller!.oneToOneChat[i].message!.message,
                                                                                                    ),
                                                                                                  ),
                                                                                                  Align(
                                                                                                    child: Text(
                                                                                                      '${sdf2.format(DateTime.parse("${getcontroller!.oneToOneChat[i].message!.iosDateTime}").toUtc().toLocal())}',
                                                                                                      style: TextStyle(
                                                                                                        color: Colors.black26,
                                                                                                        fontSize: 9.0,
                                                                                                      ),
                                                                                                    ),
                                                                                                    alignment: Alignment.centerRight,
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            )
                                                                                          : extension.contains('.pdf') || extension.contains('.docx') || extension.contains('.doc') || extension.contains('.xlsx') || extension.contains('.xls') || extension.contains('.ppt') || extension.contains('.pptx') || extension.contains('.ppm') || extension.contains('.zip') || extension.contains('.rar')
                                                                                              ? InkWell(
                                                                                                  child: Container(
                                                                                                    padding: EdgeInsets.all(5),
                                                                                                    width: width / 3,
                                                                                                    child: Column(
                                                                                                      children: [
                                                                                                        widget.fromGroup!
                                                                                                            ? Column(
                                                                                                                children: [
                                                                                                                  Text(
                                                                                                                    '${getcontroller!.oneToOneChat[i].sender!.firstName}' '${getcontroller!.oneToOneChat[i].sender!.lastName}',
                                                                                                                    style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold, fontSize: 12),
                                                                                                                  ),
                                                                                                                  SizedBox(
                                                                                                                    height: height / 100,
                                                                                                                  ),
                                                                                                                ],
                                                                                                              )
                                                                                                            : SizedBox(),
                                                                                                        Icon(
                                                                                                          Icons.file_copy_outlined,
                                                                                                          size: 40,
                                                                                                          color: primaryColor,
                                                                                                        ),
                                                                                                        SizedBox(
                                                                                                          height: 5,
                                                                                                        ),
                                                                                                        Padding(
                                                                                                          padding: EdgeInsets.symmetric(horizontal: 10),
                                                                                                          child: Text(
                                                                                                            p
                                                                                                                .basename(
                                                                                                                  '${getcontroller!.oneToOneChat[i].message!.message}',
                                                                                                                )
                                                                                                                .toString(),
                                                                                                            style: TextStyle(fontSize: 10),
                                                                                                            maxLines: 10,
                                                                                                            overflow: TextOverflow.ellipsis,
                                                                                                          ),
                                                                                                        ),
                                                                                                        SizedBox(
                                                                                                          height: 5,
                                                                                                        ),
                                                                                                        Align(
                                                                                                          child: Text(
                                                                                                            '${sdf2.format(DateTime.parse("${getcontroller!.oneToOneChat[i].message!.iosDateTime}").toUtc().toLocal())}',
                                                                                                            style: TextStyle(
                                                                                                              color: Colors.black26,
                                                                                                              fontSize: 9.0,
                                                                                                            ),
                                                                                                          ),
                                                                                                          alignment: Alignment.centerRight,
                                                                                                        ),
                                                                                                      ],
                                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                    ),
                                                                                                    decoration: BoxDecoration(
                                                                                                        border: Border.all(
                                                                                                          width: 1,
                                                                                                          color: Colors.black12,
                                                                                                        ),
                                                                                                        borderRadius: BorderRadius.circular(10)),
                                                                                                  ),
                                                                                                  onTap: () async {
                                                                                                    String filePath = await saveAudioFile(url: '${getcontroller!.oneToOneChat[i].message!.message}', extension: extension, fileNName: p.basename('${getcontroller!.oneToOneChat[i].message!.message}'));
                                                                                                    await OpenFile.open(filePath);
                                                                                                  },
                                                                                                )
                                                                                              : Container(
                                                                                                  padding: EdgeInsets.all(width / 30),
                                                                                                  decoration: BoxDecoration(color: Color(0xffF3F3F3), borderRadius: BorderRadius.circular(8)),
                                                                                                  child: Column(
                                                                                                    children: [
                                                                                                      widget.fromGroup!
                                                                                                          ? Column(
                                                                                                              children: [
                                                                                                                Text(
                                                                                                                  '${getcontroller!.oneToOneChat[i].sender!.firstName}' '${getcontroller!.oneToOneChat[i].sender!.lastName}',
                                                                                                                  style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold, fontSize: 12),
                                                                                                                ),
                                                                                                                SizedBox(
                                                                                                                  height: height / 100,
                                                                                                                ),
                                                                                                              ],
                                                                                                            )
                                                                                                          : SizedBox(),
                                                                                                      Text(
                                                                                                        '${getcontroller!.oneToOneChat[i].message!.message}',
                                                                                                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300, fontSize: 14),
                                                                                                      ),
                                                                                                      SizedBox(
                                                                                                        height: height / 100,
                                                                                                      ),
                                                                                                      Row(
                                                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                                                        children: <Widget>[
                                                                                                          Padding(
                                                                                                            padding: EdgeInsets.only(left: width / 50),
                                                                                                            child: Text(
                                                                                                              //  '${timeago.format(DateTime.parse("${getcontroller!.oneToOneChat[i].message!.iosDateTime}"), locale: 'en_short')} ago',
                                                                                                              //${DateTime.parse("${getcontroller!.oneToOneChat[i].message!.iosDateTime}").day} ${DateFormat.yMMM().format(DateTime.parse("${getcontroller!.oneToOneChat[i].message!.iosDateTime}")).toString().split(' ')[0]} ,
                                                                                                              '${sdf2.format(DateTime.parse("${getcontroller!.oneToOneChat[i].message!.iosDateTime}").toUtc().toLocal())}',
                                                                                                              style: TextStyle(
                                                                                                                color: Colors.black26,
                                                                                                                fontSize: 9.0,
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ],
                                                                                                      )
                                                                                                    ],
                                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                  ),
                                                                                                ),
                                                                      SizedBox(
                                                                        height: height /
                                                                            200,
                                                                      ),
                                                                    ],
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                  ),
                                                                ),
                                                              )),
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
                                                                              .contains(getcontroller!.oneToOneChat[i])
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
                                                                              1.7),
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
                                                                      () {
                                                                    if (!selectedOneToOneChat
                                                                        .contains(
                                                                            getcontroller!.oneToOneChat[i])) {
                                                                      selectedOneToOneChat.add(
                                                                          getcontroller!
                                                                              .oneToOneChat[i]);
                                                                    } else {
                                                                      selectedOneToOneChat
                                                                          .remove(
                                                                              getcontroller!.oneToOneChat[i]);
                                                                    }
                                                                    setState(
                                                                        () {});
                                                                  },
                                                                  onCneTapMenuItems: <
                                                                      FocusedMenuItem>[
                                                                    FocusedMenuItem(
                                                                        title: Text(
                                                                            "Favorite"),
                                                                        onPressed:
                                                                            () {},
                                                                        trailingIcon:
                                                                            Icon(
                                                                          CupertinoIcons
                                                                              .heart,
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
                                                                            () {},
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
                                                                          Clipboard.setData(
                                                                              ClipboardData(text: "${getcontroller!.oneToOneChat[i].message!.message}"));
                                                                          ScaffoldMessenger.of(context)
                                                                              .showSnackBar(SnackBar(
                                                                            content:
                                                                                Text('Copyed'),
                                                                            duration:
                                                                                Duration(seconds: 1),
                                                                          ));
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
                                                                          Map payLoad =
                                                                              {
                                                                            'm_id':
                                                                                '${getcontroller!.oneToOneChat[i].message!.mId}',
                                                                            'userId':
                                                                                '${getcontroller!.oneToOneChat[i].sender!.userId}'
                                                                          };

                                                                          ApiUtils.removeMessageApi(
                                                                              map: payLoad);
                                                                          getcontroller!
                                                                              .oneToOneChat
                                                                              .removeAt(i);
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
                                                                    if (selectedOneToOneChat
                                                                        .isNotEmpty) {
                                                                      if (!selectedOneToOneChat
                                                                          .contains(
                                                                              getcontroller!.oneToOneChat[i])) {
                                                                        selectedOneToOneChat
                                                                            .add(getcontroller!.oneToOneChat[i]);
                                                                      } else {
                                                                        selectedOneToOneChat
                                                                            .remove(getcontroller!.oneToOneChat[i]);
                                                                      }
                                                                      setState(
                                                                          () {});
                                                                    }
                                                                  },
                                                                  child: Column(
                                                                    children: [
                                                                      '${getcontroller!.oneToOneChat[i].message!.message}'.contains(
                                                                              'Contacts#=-:')
                                                                          ? Builder(builder:
                                                                              (context) {
                                                                              List list = '${getcontroller!.oneToOneChat[i].message!.message}'.split(':');
                                                                              return ContactView(
                                                                                result: list[1],
                                                                              );
                                                                            })
                                                                          : '${getcontroller!.oneToOneChat[i].message!.message}'.contains('latitude') && '${getcontroller!.oneToOneChat[i].message!.message}'.contains('longitude')
                                                                              ? Builder(builder: (context) {
                                                                                  List list = '${getcontroller!.oneToOneChat[i].message!.message}'.split(',');
                                                                                  return ClipRRect(
                                                                                    borderRadius: BorderRadius.circular(5),
                                                                                    child: Container(
                                                                                      width: width,
                                                                                      height: height * 0.210,
                                                                                      padding: EdgeInsets.all(3),
                                                                                      decoration: BoxDecoration(color: Colors.blueGrey[50]),
                                                                                      child: GoogleMapView(
                                                                                        lat: list[0].toString().split(':')[1],
                                                                                        lng: list[1].toString().split(':')[1],
                                                                                        ontap: () async {
                                                                                          print('Clicked on map');
                                                                                          Position? position = await Geolocator.getLastKnownPosition();
                                                                                          launchURL('https://www.google.com/maps/dir/?api=1&origin=${position!.latitude},${position.longitude}&destination=${list[0].toString().split(':')[1]},${list[1].toString().split(':')[1]}&travelmode=driving&dir_action=navigate');
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                  );
                                                                                })
                                                                              : extension.contains('.jpg') || extension.contains('.png') || extension.contains('.jpeg')
                                                                                  ? InkWell(
                                                                                      child: Container(
                                                                                        height: height * 0.3,
                                                                                        child: Stack(
                                                                                          children: [
                                                                                            Container(
                                                                                              height: height * 0.3,
                                                                                              child: ClipRRect(
                                                                                                child: CachedNetworkImage(
                                                                                                  imageUrl: "${getcontroller!.oneToOneChat[i].message!.message}",
                                                                                                  placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                                                                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                                                                                ),
                                                                                                borderRadius: BorderRadius.circular(8),
                                                                                              ),
                                                                                            ),
                                                                                            Align(
                                                                                              child: Padding(
                                                                                                padding: const EdgeInsets.all(8.0),
                                                                                                child: Text(
                                                                                                  '${sdf2.format(DateTime.parse("${getcontroller!.oneToOneChat[i].message!.iosDateTime}").toUtc().toLocal())}',
                                                                                                  style: TextStyle(
                                                                                                    color: Colors.white,
                                                                                                    fontSize: 9.0,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              alignment: Alignment.bottomRight,
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                      onTap: () {
                                                                                        Get.to(Photo_View_Class(
                                                                                          url: "${getcontroller!.oneToOneChat[i].message!.message}",
                                                                                        ));
                                                                                      },
                                                                                    )
                                                                                  : extension.contains('.mp4')
                                                                                      ? InkWell(
                                                                                          child: Container(
                                                                                            width: width / 1.7,
                                                                                            height: height * 0.3,
                                                                                            decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(5)),
                                                                                            child: Stack(
                                                                                              children: [
                                                                                                Center(
                                                                                                  child: Icon(
                                                                                                    Icons.play_circle_fill,
                                                                                                    size: 40,
                                                                                                    color: Colors.white,
                                                                                                  ),
                                                                                                ),
                                                                                                Align(
                                                                                                  child: Padding(
                                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                                    child: Text(
                                                                                                      '${sdf2.format(DateTime.parse("${getcontroller!.oneToOneChat[i].message!.iosDateTime}").toUtc().toLocal())}',
                                                                                                      style: TextStyle(
                                                                                                        color: Colors.white60,
                                                                                                        fontSize: 9.0,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  alignment: Alignment.bottomRight,
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                          onTap: () {
                                                                                            Get.to(CustomVideoPlayer(
                                                                                              url: getcontroller!.oneToOneChat[i].message!.message,
                                                                                            ));
                                                                                            // Get.to(
                                                                                            //     VideoApp(
                                                                                            //   assetsPath:
                                                                                            //       '${getcontroller!.oneToOneChat[i].message!.message}',
                                                                                            // ));
                                                                                          },
                                                                                        )
                                                                                      : extension.contains('.mp3') || extension.contains('.aac') || extension.contains('.ac3') || extension.contains('.h264') || extension.contains('.wav') || extension.contains('.csv') || extension.contains('.wma') || extension.contains('.wmv')
                                                                                          ? Container(
                                                                                              height: height * 0.1,
                                                                                              width: width / 1.7,
                                                                                              child: Stack(
                                                                                                children: [
                                                                                                  Container(
                                                                                                    height: height * 0.080,
                                                                                                    width: width / 1.7,
                                                                                                    child: CustomAudioPlayer(
                                                                                                      url: getcontroller!.oneToOneChat[i].message!.message,
                                                                                                    ),
                                                                                                  ),
                                                                                                  Align(
                                                                                                    child: Padding(
                                                                                                      padding: const EdgeInsets.all(8.0),
                                                                                                      child: Text(
                                                                                                        '${sdf2.format(DateTime.parse("${getcontroller!.oneToOneChat[i].message!.iosDateTime}").toUtc().toLocal())}',
                                                                                                        style: TextStyle(
                                                                                                          color: Colors.black26,
                                                                                                          fontSize: 9.0,
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                    alignment: Alignment.bottomRight,
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            )
                                                                                          : extension.contains('.pdf')
                                                                                              ? InkWell(
                                                                                                  child: Container(
                                                                                                    padding: EdgeInsets.all(5),
                                                                                                    width: width / 3,
                                                                                                    child: Column(
                                                                                                      children: [
                                                                                                        Icon(
                                                                                                          Icons.file_copy_outlined,
                                                                                                          size: 40,
                                                                                                          color: primaryColor,
                                                                                                        ),
                                                                                                        SizedBox(
                                                                                                          height: 5,
                                                                                                        ),
                                                                                                        Padding(
                                                                                                          padding: EdgeInsets.symmetric(horizontal: 10),
                                                                                                          child: Text(
                                                                                                            p.basename('${getcontroller!.oneToOneChat[i].message!.message}').toString(),
                                                                                                            style: TextStyle(fontSize: 10),
                                                                                                            maxLines: 10,
                                                                                                            overflow: TextOverflow.ellipsis,
                                                                                                          ),
                                                                                                        ),
                                                                                                        SizedBox(
                                                                                                          height: 5,
                                                                                                        ),
                                                                                                        Align(
                                                                                                          child: Text(
                                                                                                            '${sdf2.format(DateTime.parse("${getcontroller!.oneToOneChat[i].message!.iosDateTime}").toUtc().toLocal())}',
                                                                                                            style: TextStyle(
                                                                                                              color: Colors.black26,
                                                                                                              fontSize: 9.0,
                                                                                                            ),
                                                                                                          ),
                                                                                                          alignment: Alignment.centerRight,
                                                                                                        ),
                                                                                                      ],
                                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                    ),
                                                                                                    decoration: BoxDecoration(
                                                                                                        border: Border.all(
                                                                                                          width: 1,
                                                                                                          color: Colors.black12,
                                                                                                        ),
                                                                                                        borderRadius: BorderRadius.circular(10)),
                                                                                                  ),
                                                                                                  onTap: () async {
                                                                                                    String filePath = await saveAudioFile(url: '${getcontroller!.oneToOneChat[i].message!.message}', extension: extension, fileNName: p.basename('${getcontroller!.oneToOneChat[i].message!.message}'));
                                                                                                    await OpenFile.open(filePath);
                                                                                                  },
                                                                                                )
                                                                                              : Container(
                                                                                                  padding: EdgeInsets.symmetric(vertical: height * 0.010, horizontal: width * 0.030),
                                                                                                  decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(8)),
                                                                                                  child: Column(
                                                                                                    children: [
                                                                                                      Text(
                                                                                                        '${getcontroller!.oneToOneChat[i].message!.message}',
                                                                                                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300, fontSize: 14),
                                                                                                      ),
                                                                                                      SizedBox(
                                                                                                        height: height / 100,
                                                                                                      ),
                                                                                                      Row(
                                                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                                                        children: <Widget>[
                                                                                                          Padding(
                                                                                                            padding: EdgeInsets.only(left: width / 50),
                                                                                                            child: Text(
                                                                                                              //  '${timeago.format(DateTime.parse("${getcontroller!.oneToOneChat[i].message!.iosDateTime}"), locale: 'en_short')} ago',
                                                                                                              //${DateTime.parse("${getcontroller!.oneToOneChat[i].message!.iosDateTime}").day} ${DateFormat.yMMM().format(DateTime.parse("${getcontroller!.oneToOneChat[i].message!.iosDateTime}")).toString().split(' ')[0]} ,
                                                                                                              '${sdf2.format(DateTime.parse("${getcontroller!.oneToOneChat[i].message!.iosDateTime}").toUtc().toLocal())}',
                                                                                                              style: TextStyle(
                                                                                                                color: Colors.black38,
                                                                                                                fontSize: 9.0,
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ],
                                                                                                      )
                                                                                                    ],
                                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                  ),
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
                                          replyModel.value =
                                              getcontroller!.oneToOneChat[i];
                                          isActivereply.value = true;
                                          setState(() {});
                                        },
                                        onLeftSwipe: () {
                                          smsInformation(context: context);
                                        },
                                        leftSwipeWidget: SizedBox(),
                                        iconOnRightSwipe: CupertinoIcons.reply,
                                      );
                              },
                              reverse: true,
                              itemCount: getcontroller!.oneToOneChat.length,
                            ),
                            padding: EdgeInsets.only(
                                left: width / 25, right: width / 25),
                          ))),
                  isActivereply.value == true
                      ? Container(
                          decoration: BoxDecoration(color: Colors.blueGrey[50]),
                          child: Row(
                            children: [
                              Container(
                                height: height * 0.060,
                                width: 3,
                                decoration:
                                    BoxDecoration(color: Colors.deepPurple),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      storage.read('userID') !=
                                              replyModel.value.sender!.userId
                                                  .toString()
                                          ? '${replyModel.value.sender!.firstName} ${replyModel.value.sender!.lastName}'
                                          : 'You',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.deepPurple),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      replyModel.value.message!.type == 'text'
                                          ? '${replyModel.value.message!.message}'
                                          : '${replyModel.value.message!.type}',
                                      maxLines: 1,
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        replyModel.value = OneToOneChatModel();
                                        isActivereply.value = false;
                                        setState(() {});
                                      },
                                      child: Container(
                                        child: Icon(
                                          Icons.close,
                                          size: 17,
                                        ),
                                        decoration: BoxDecoration(
                                            color: Colors.black12,
                                            shape: BoxShape.circle),
                                        padding: EdgeInsets.all(3),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      : SizedBox(),
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
                              Row(
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
                              )
                            ],
                          ),
                        )
                      : Container(
                          height: height / 22,
                          width: width,
                          decoration: BoxDecoration(color: Colors.white),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Wrap(
                                          children: [
                                            ListTile(
                                              leading: Icon(
                                                Icons.image,
                                                color: primaryColor,
                                              ),
                                              title: Text(
                                                'Photo & Video',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    letterSpacing: 0.5),
                                              ),
                                              onTap: () async {
                                                FilePickerResult? result =
                                                    await FilePicker.platform
                                                        .pickFiles(
                                                  type: FileType.custom,
                                                  allowedExtensions: [
                                                    'jpg',
                                                    'jpeg',
                                                    'mp4',
                                                    'png',
                                                  ],
                                                );
                                                if (result!.files.isNotEmpty) {
                                                  print(
                                                      'file path is = ${result.files[0].path}');
                                                  getcontroller!.sentMessageViaFile(
                                                      groupId: widget.groupID,
                                                      filePath:
                                                          '${result.files[0].path}');
                                                  Navigator.of(context).pop();
                                                }
                                              },
                                            ),
                                            ListTile(
                                              leading: Icon(
                                                Icons.file_copy_outlined,
                                                color: primaryColor,
                                              ),
                                              title: Text(
                                                'Documents',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    letterSpacing: 0.5),
                                              ),
                                              onTap: () async {
                                                FilePickerResult? result =
                                                    await FilePicker.platform
                                                        .pickFiles(
                                                  type: FileType.custom,
                                                  allowedExtensions: [
                                                    'pdf',
                                                    'doc'
                                                  ],
                                                );
                                                if (result!.files.isNotEmpty) {
                                                  print(
                                                      'file path is = ${result.files[0].path}');
                                                  getcontroller!.sentMessageViaFile(
                                                      groupId: widget.groupID,
                                                      filePath:
                                                          '${result.files[0].path}');
                                                  Navigator.of(context).pop();
                                                }
                                              },
                                            ),
                                            ListTile(
                                              leading: Icon(
                                                Icons.camera_alt_outlined,
                                                color: primaryColor,
                                              ),
                                              title: Text(
                                                'Camera',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    letterSpacing: 0.5),
                                              ),
                                            ),
                                            ListTile(
                                              leading: Icon(
                                                Icons.location_on_outlined,
                                                color: primaryColor,
                                              ),
                                              title: Text(
                                                'Location',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    letterSpacing: 0.5),
                                              ),
                                              onTap: () {
                                                Get.to(MapClass())!
                                                    .then((value) {
                                                  if (value is String) {
                                                    print(
                                                        'locatoin ia = $value');
                                                    getcontroller!
                                                        .onSentMessage(
                                                            message: value,
                                                            groupId:
                                                                widget.groupID);
                                                  }
                                                  Navigator.of(context).pop();
                                                });
                                              },
                                            ),
                                            ListTile(
                                              leading: Icon(
                                                Icons.person_outline,
                                                color: primaryColor,
                                              ),
                                              title: Text(
                                                'Contacts',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    letterSpacing: 0.5),
                                              ),
                                              onTap: () {
                                                Get.to(GetAllContactsPage())!
                                                    .then((value) {
                                                  if (value is String) {
                                                    print(
                                                        'Contacts ia = $value');
                                                    getcontroller!
                                                        .onSentMessage(
                                                            message: value,
                                                            groupId:
                                                                widget.groupID);
                                                  }
                                                  Navigator.of(context).pop();
                                                });
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                },
                                child: Icon(
                                  Icons.add,
                                  size: 35,
                                  color: primaryColor,
                                ),
                              ),

                              // InkWell(
                              //   onTap: () async {
                              //     showModalBottomSheet(
                              //         context: context,
                              //         builder: (context) {
                              //           return Wrap(
                              //             children: [
                              //               ListTile(
                              //                 leading: Icon(
                              //                   Icons.image,
                              //                   color: primaryColor,
                              //                 ),
                              //                 title: Text(
                              //                   'Image',
                              //                   style: TextStyle(
                              //                       fontSize: 16, letterSpacing: 0.5),
                              //                 ),
                              //                 onTap: () async {
                              //                   String path = await getcontroller!
                              //                       .onImageButtonPressed(
                              //                       tag: 'image',
                              //                       source: ImageSource.camera);
                              //                   if (path.isNotEmpty) {
                              //                     getcontroller!.sentMessageViaFile(
                              //                         groupId: widget.groupID,
                              //                         filePath: '$path');
                              //                     Navigator.of(context).pop();
                              //                   }
                              //                 },
                              //               ),
                              //               ListTile(
                              //                 leading: Icon(
                              //                   Icons.image,
                              //                   color: primaryColor,
                              //                 ),
                              //                 title: Text(
                              //                   'Video',
                              //                   style: TextStyle(
                              //                       fontSize: 16, letterSpacing: 0.5),
                              //                 ),
                              //                 onTap: () async {
                              //                   String path = await getcontroller!
                              //                       .onImageButtonPressed(
                              //                       tag: 'image',
                              //                       source: ImageSource.camera);
                              //                   if (path.isNotEmpty) {
                              //                     getcontroller!.sentMessageViaFile(
                              //                         groupId: widget.groupID,
                              //                         filePath: '$path');
                              //                     Navigator.of(context).pop();
                              //                   }
                              //                 },
                              //               ),
                              //             ],
                              //           );
                              //         });
                              //   },
                              //   child: Icon(
                              //     Icons.camera_alt_outlined,
                              //     color: primaryColor,
                              //     size: 25,
                              //   ),
                              // ),
                              SizedBox(
                                width: 7,
                              ),
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  child: TextFormField(
                                    controller: controller,
                                    onChanged: (value) {
                                      if (!getcontroller!.startTyping.value) {
                                        getcontroller!.startTyping.value = true;
                                        getcontroller!.userTypingStart(
                                            groupId: widget.groupID);
                                      }
                                      getcontroller!.searchText.value = value;
                                    },
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                    decoration: InputDecoration(
                                        disabledBorder: new OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: new BorderSide(
                                              color: Colors.black12,
                                            )),
                                        focusedBorder: new OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: new BorderSide(
                                              color: Colors.black12,
                                            )),
                                        enabledBorder: new OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: new BorderSide(
                                              color: Colors.black12,
                                            )),
                                        border: new OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: new BorderSide(
                                              color: Colors.black12,
                                            )),
                                        contentPadding: EdgeInsets.all(12),
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
                              Obx(
                                () => getcontroller!.searchText.value.isEmpty
                                    ? Row(
                                        children: [
                                          SizedBox(
                                            width: 5,
                                          ),
                                          InkWell(
                                              onTap: () async {
                                                RecordMp3.instance.stop();
                                                getcontroller!.recording_start
                                                    .value = false;
                                                Future.delayed(
                                                    Duration(milliseconds: 500),
                                                    () {
                                                  getcontroller!
                                                      .sentMessageViaFile(
                                                          groupId:
                                                              widget.groupID,
                                                          filePath:
                                                              '$audio_path');
                                                });
                                              },
                                              onLongPress: () async {
                                                bool result =
                                                    await record.Record()
                                                        .hasPermission();
                                                String path =
                                                    await getFilePath();
                                                audio_path = path;
                                                if (result) {
                                                  RecordMp3.instance
                                                      .start(path, (type) {});
                                                  getcontroller!.recording_start
                                                      .value = true;
                                                } else {
                                                  print('access deny');
                                                }
                                              },
                                              child: Obx(
                                                () => getcontroller!
                                                        .recording_start.value
                                                    ? MarqueeWidget(
                                                        direction:
                                                            Axis.vertical,
                                                        child: Icon(
                                                          Icons
                                                              .keyboard_voice_outlined,
                                                          color: Colors.red,
                                                          size: 30,
                                                        ),
                                                      )
                                                    : Icon(
                                                        Icons
                                                            .keyboard_voice_outlined,
                                                        color: Colors.black26,
                                                        size: 30,
                                                      ),
                                              )),
                                          SizedBox(
                                            width: 10,
                                          ),
                                        ],
                                      )
                                    : InkWell(
                                        onTap: () {
                                          if (controller.text
                                              .trim()
                                              .isNotEmpty) {
                                            getcontroller!.onSentMessage(
                                                message: controller.text,
                                                groupId: widget.groupID);
                                            controller.clear();
                                            getcontroller!.searchText.value =
                                                '';
                                          }
                                        },
                                        child: Container(
                                          height: height / 18,
                                          width: width / 9,
                                          child: Center(
                                            child: Icon(
                                              Icons.send_outlined,
                                              color: Colors.white,
                                            ),
                                          ),
                                          margin: EdgeInsets.only(
                                              right: 10, left: 5),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: primaryColor),
                                        ),
                                      ),
                              )
                            ],
                          ),
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
    return sdPath + "/test_${i++}.png";
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
