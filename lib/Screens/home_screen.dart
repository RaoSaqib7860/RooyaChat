import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rooya/ApiConfig/SizeConfiq.dart';
import 'package:rooya/Models/UserDataModel.dart';
import 'package:rooya/Providers/ClickController/SelectIndexController.dart';
import 'package:rooya/Screens/rooms_screen.dart';
import 'package:rooya/Screens/sliver_class/sliver.dart';
import 'package:rooya/Utils/UserDataService.dart';
import 'package:rooya/Utils/primary_color.dart';
import 'package:get/get.dart';

import 'chat_screen.dart';
import 'group_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var selectController = Get.put(SelectIndexController());

  List iconList = [
    'assets/user/prs.svg',
    //'assets/user/single.svg',
    'assets/user/persons.svg',
    'assets/user/sw.svg',
    // 'assets/user/fvrt.svg',
  ];

  int currentIndex = 0;

  List tabContent = [
    (ChatScreen()),
    //(FriendsScreen()),
    (GroupScreen()),
    (RoomsScreen()),
    // (FriendsScreen()),
  ];

  @override
  void initState() {
    GetStorage storage = GetStorage();
    UserDataService.userDataModel =
        UserDataModel.fromJson(jsonDecode(storage.read('userData')));
    selectController.observeronSearch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: DefaultTabController(
                length: 2,
                child: NestedScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    headerSliverBuilder: (context, isScrool) {
                      return [
                        SliverAppBar(
                          automaticallyImplyLeading: false,
                          elevation: 0,
                          collapsedHeight: height * 0.110,
                          backgroundColor: Colors.white,
                          expandedHeight: height * 0.110,
                          flexibleSpace: MySliver(),
                        ),
                        SliverPersistentHeader(
                          floating: true,
                          pinned: true,
                          delegate: MyDelegate(Container(
                            height: 100,
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: iconList.map((e) {
                                int index = iconList.indexOf(e);
                                return Obx(
                                  () => InkWell(
                                    onTap: () {
                                      selectController.updateColor(index);
                                      setState(() {
                                        currentIndex = index;
                                      });
                                    },
                                    child: Container(
                                      width: 63.3,
                                      child: Center(
                                          child: SvgPicture.asset(
                                              iconList[index],
                                              height: 20,
                                              width: 20,
                                              fit: BoxFit.fill,
                                              color: selectController
                                                          .listofBool[index] ==
                                                      true
                                                  ? buttonColor
                                                  : Colors.black)),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          color: Colors.white),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          )),
                        ),
                      ];
                    },
                    body: tabContent[currentIndex]))));
  }
}

class MyDelegate extends SliverPersistentHeaderDelegate {
  MyDelegate(this.widget);

  final Widget widget;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return widget;
  }

  @override
  double get maxExtent => 30;

  @override
  double get minExtent => 30;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
