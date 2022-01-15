import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rooya/ClickController/SelectIndexController.dart';
import 'package:rooya/Home/chat_screen.dart';
import 'package:rooya/Home/friends_screen.dart';
import 'package:rooya/Home/group_screen.dart';
import 'package:rooya/Home/rooms_screen.dart';
import 'package:rooya/sliver_class/sliver.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var selectController = Get.put(SelectIndexController());

  List iconList = [
    'assets/user/prs.svg',
    'assets/user/single.svg',
    'assets/user/persons.svg',
    'assets/user/sw.svg',
    'assets/user/fvrt.svg',
  ];

  int currentIndex = 0;

  List tabContent = [
    (ChatScreen()),
    (FriendsScreen()),
    (GroupScreen()),
    (RoomsScreen()),
    (FriendsScreen()),
  ];

  @override
  void initState() {
    selectController.observeronSearch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: DefaultTabController(
                length: 5,
                child: NestedScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    headerSliverBuilder: (context, isScrool) {
                      return [
                        SliverAppBar(
                          automaticallyImplyLeading: false,
                          collapsedHeight: 130,
                          expandedHeight: 130,
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
                                      //height: 60,
                                      width: 63.3,
                                      child: Center(
                                          child: SvgPicture.asset(
                                              iconList[index],
                                              fit: BoxFit.fill,
                                              color: selectController
                                                          .listofBool[index] ==
                                                      true
                                                  ? Colors.white
                                                  : Color(0XFF5A5A5A))),
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black12),
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          color: selectController
                                                      .listofBool[index] ==
                                                  true
                                              ? Color(0XFF0BAB0D)
                                              : Colors.white),
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
