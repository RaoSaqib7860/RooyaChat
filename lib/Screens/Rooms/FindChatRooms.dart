import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:rooya/ApiConfig/ApiUtils.dart';
import 'package:rooya/ApiConfig/BaseURL.dart';
import 'package:rooya/Providers/FindChatRoomProvider.dart';
import 'package:rooya/Utils/primary_color.dart';
import 'package:rooya/Utils/text_filed/app_font.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class FindChatRooms extends StatefulWidget {
  const FindChatRooms({Key? key}) : super(key: key);

  @override
  _FindChatRoomsState createState() => _FindChatRoomsState();
}

class _FindChatRoomsState extends State<FindChatRooms> {
  TextEditingController locationController = TextEditingController();
  double? lat;
  double? lng;
  final controller = Get.put(FindChatRoomProvider());

  @override
  void initState() {
    getCurrentLocatio();
    super.initState();
  }

  getCurrentLocatio() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    lat = position.latitude;
    lng = position.longitude;
    print('token = ${token}');
    await controller.getGroupList(mapData: {
      'server_key': serverKey,
      'type': 'get_all',
      'lat': '$lat',
      'lng': '$lng',
      'variant': 'room'
    });
    setState(() {});
  }

  String selectedFilter = 'all';
  double current_per = 60.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Find Chat Room',
        ),
        backgroundColor: buttonColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      setState(() {
                        selectedFilter = 'all';
                      });
                      await controller.getGroupList(mapData: {
                        'server_key': serverKey,
                        'type': 'get_all',
                        'privacy': 'get_all',
                        'lat': '$lat',
                        'lng': '$lng',
                        'variant': 'room'
                      });
                      setState(() {});
                    },
                    child: Container(
                      height: 30,
                      child: Center(
                        child: Text(
                          'All',
                          style: TextStyle(
                              color: selectedFilter == 'all'
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 15,
                              fontFamily: AppFonts.segoeui),
                        ),
                      ),
                      decoration: selectedFilter == 'all'
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color(0XFF0BAB0D),
                            )
                          : BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.black26, width: 1)),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      setState(() {
                        selectedFilter = 'public';
                      });
                      await controller.getGroupList(mapData: {
                        'server_key': serverKey,
                        'type': 'get_all',
                        'privacy': 'public',
                        'lat': '$lat',
                        'lng': '$lng',
                        'variant': 'room'
                      });
                      setState(() {});
                    },
                    child: Container(
                      height: 30,
                      child: Center(
                        child: Text(
                          'Public',
                          style: TextStyle(
                              color: selectedFilter == 'public'
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 15,
                              fontFamily: AppFonts.segoeui),
                        ),
                      ),
                      decoration: selectedFilter == 'public'
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color(0XFF0BAB0D),
                            )
                          : BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.black26, width: 1)),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      setState(() {
                        selectedFilter = 'private';
                      });
                      await controller.getGroupList(mapData: {
                        'server_key': serverKey,
                        'type': 'get_all',
                        'privacy': 'private',
                        'lat': '$lat',
                        'lng': '$lng',
                        'variant': 'room'
                      });
                      setState(() {});
                    },
                    child: Container(
                      height: 30,
                      child: Center(
                        child: Text(
                          'Private',
                          style: TextStyle(
                              color: selectedFilter == 'private'
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 15,
                              fontFamily: AppFonts.segoeui),
                        ),
                      ),
                      decoration: selectedFilter == 'private'
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color(0XFF0BAB0D),
                            )
                          : BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.black26, width: 1)),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: SfSlider(
                    min: 0.0,
                    max: 1000.0,
                    value: current_per,
                    interval: 50,
                    showTicks: true,
                    enableTooltip: true,
                    minorTicksPerInterval: 1,
                    onChanged: (dynamic value) {
                      setState(() {
                        current_per = value;
                      });
                    },
                  ),
                ),
                Text('${current_per.toInt()} km')
              ],
            ),
            Container(
              height: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.blueGrey[50],
              ),
              child: GooglePlaceAutoCompleteTextField(
                  textEditingController: locationController,
                  googleAPIKey: "$google_map_api_key",
                  inputDecoration: InputDecoration(
                      hintText: 'Select location',
                      hintStyle:
                          TextStyle(fontSize: 13, fontFamily: AppFonts.segoeui),
                      contentPadding: EdgeInsets.only(left: 8),
                      border: InputBorder.none),
                  getPlaceDetailWithLatLng: (Prediction prediction) async {
                    lat = double.parse(prediction.lat!);
                    lng = double.parse(prediction.lng!);
                    if (selectedFilter == 'all') {
                      await controller.getGroupList(mapData: {
                        'server_key': serverKey,
                        'type': 'get_all',
                        'lat': '$lat',
                        'lng': '$lng',
                        'variant': 'room'
                      });
                    } else {
                      await controller.getGroupList(mapData: {
                        'server_key': serverKey,
                        'type': 'get_all',
                        'privacy':
                            selectedFilter == 'private' ? 'private' : 'public',
                        'lat': '$lat',
                        'lng': '$lng',
                        'variant': 'room'
                      });
                    }
                    setState(() {});
                  },
                  itmClick: (Prediction prediction) {
                    locationController.text = prediction.description!;
                    locationController.selection = TextSelection.fromPosition(
                        TextPosition(offset: prediction.description!.length));
                  }),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: Obx(() => !controller.loadChat.value
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : controller.listofChat.isEmpty
                        ? Center(
                            child: Text('Room not found'),
                          )
                        : CustomScrollView(
                            slivers: [
                              SliverGrid(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 10),
                                  delegate: SliverChildBuilderDelegate(
                                      (BuildContext context, int index) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(7),
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: double.infinity,
                                            width: double.infinity,
                                            color: Colors.green,
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
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: InkWell(
                                                onTap: () async {
                                                  if (controller
                                                          .listofChat[index]
                                                          .groupPrivacy !=
                                                      'private') {
                                                    bool result =
                                                        await controller
                                                            .joinRoom(mapData: {
                                                      'server_key': serverKey,
                                                      'type': 'join_room',
                                                      'id': controller
                                                          .listofChat[index]
                                                          .groupId,
                                                      'password': ''
                                                    });
                                                    if (result) {
                                                      controller.listofChat
                                                          .removeAt(index);
                                                    }
                                                    setState(() {});
                                                  } else {
                                                    TextEditingController
                                                        passwordController =
                                                        TextEditingController();
                                                    showDialog(
                                                        context: context,
                                                        builder: (c) {
                                                          return AlertDialog(
                                                            content: Container(
                                                              height: 60,
                                                              child: Column(
                                                                children: [
                                                                  Container(
                                                                    height: 45,
                                                                    margin: EdgeInsets
                                                                        .only(
                                                                            top:
                                                                                12),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              30),
                                                                      color: Colors
                                                                          .blueGrey[50],
                                                                    ),
                                                                    child:
                                                                        TextField(
                                                                      controller:
                                                                          passwordController,
                                                                      keyboardType:
                                                                          TextInputType.numberWithOptions(
                                                                              signed: true),
                                                                      inputFormatters: [
                                                                        FilteringTextInputFormatter
                                                                            .digitsOnly,
                                                                      ],
                                                                      textInputAction:
                                                                          TextInputAction
                                                                              .done,
                                                                      decoration: InputDecoration(
                                                                          hintText:
                                                                              'Password',
                                                                          hintStyle: TextStyle(
                                                                              fontSize:
                                                                                  13,
                                                                              fontFamily: AppFonts
                                                                                  .segoeui),
                                                                          contentPadding: EdgeInsets.only(
                                                                              left:
                                                                                  8),
                                                                          border:
                                                                              InputBorder.none),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            title: Text(
                                                              "Write the password of Room",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      AppFonts
                                                                          .segoeui,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            actions: [
                                                              TextButton(
                                                                child: Text(
                                                                    "Join"),
                                                                onPressed:
                                                                    () async {
                                                                  if (passwordController
                                                                      .text
                                                                      .trim()
                                                                      .toString()
                                                                      .isNotEmpty) {
                                                                    bool
                                                                        result =
                                                                        await controller.joinRoom(
                                                                            mapData: {
                                                                          'server_key':
                                                                              serverKey,
                                                                          'type':
                                                                              'join_room',
                                                                          'id': controller
                                                                              .listofChat[index]
                                                                              .groupId,
                                                                          'password':
                                                                              '${passwordController.text.trim().toString()}'
                                                                        });
                                                                    if (result) {
                                                                      controller
                                                                          .listofChat
                                                                          .removeAt(
                                                                              index);
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    } else {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    }
                                                                  }
                                                                },
                                                              )
                                                            ],
                                                          );
                                                        }).then((value) {
                                                      setState(() {});
                                                    });
                                                  }
                                                },
                                                child: Container(
                                                  width: 75,
                                                  height: 40,
                                                  child: Center(
                                                    child: Text(
                                                      'Join',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily:
                                                              AppFonts.segoeui),
                                                    ),
                                                  ),
                                                  decoration: BoxDecoration(
                                                      color: buttonColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7)),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    '${controller.listofChat[index].groupName}',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            AppFonts.segoeui),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.lock,
                                                        color: Colors.white,
                                                      ),
                                                      SizedBox(
                                                        width: 3,
                                                      ),
                                                      Text(
                                                        controller
                                                                    .listofChat[
                                                                        index]
                                                                    .groupPrivacy ==
                                                                'private'
                                                            ? 'Private'
                                                            : 'Public',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily: AppFonts
                                                                .segoeui),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }, childCount: controller.listofChat.length))
                            ],
                          )))
          ],
        ),
      ),
    );
  }
}
