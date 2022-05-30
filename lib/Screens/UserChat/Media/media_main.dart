import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:rooya/Providers/ClickController/SelectIndexController.dart';
import 'package:rooya/Screens/Groups/group_information.dart';
import 'package:rooya/Screens/Rooms/room_info.dart';
import 'package:rooya/Screens/UserChat/Media/photos_screen.dart';
import 'package:rooya/Screens/UserChat/Media/video_screen.dart';
import 'package:rooya/Utils/text_filed/app_font.dart';

import 'document_screen.dart';
import 'link_screen.dart';

class MainMedia extends StatefulWidget {
  const MainMedia({Key? key}) : super(key: key);

  @override
  _MainMediaState createState() => _MainMediaState();
}

class _MainMediaState extends State<MainMedia> {
  List names = ['PHOTOS', 'VIDEOS', 'LINKS', 'DOCUMENTS'];

  List tabContent = [
    (PhotosScreen()),
    (VideoScreen()),
    (LinkScreen()),
    (DocumentScreen()),
  ];

  List nameList = [
    'PHOTOS',
    'VIDEOS',
    'LINKS',
    'DOCUMENTS'
  ];

  int currentIndex = 0;

  var selectController = Get.put(SelectIndexController());

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          title: Text(
            'Media',
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w800),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(top: 20, right: 10),
              child: Wrap(
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(RoomsInformation());
                    },
                    child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blueGrey[50],
                        ),
                        child: Center(
                            child: Icon(
                          Icons.delete,
                          color: Colors.green,
                        ))),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(GroupInformation());
                    },
                    child: Container(
                      height: 30,
                      width: 70,
                      child: Center(
                        child: Text(
                          'Select',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blueGrey[50],
                      ),
                    ),
                  )
                ],
                spacing: 12,
              ),
            )
          ],
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: DefaultTabController(
            length: 4,
            child: NestedScrollView(
                physics: NeverScrollableScrollPhysics(),
                headerSliverBuilder: (context, isScroll) {
                  return [
                    SliverPersistentHeader(
                      floating: true,
                      pinned: true,
                      delegate: MyDelegate(Container(
                        height: 100,
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: nameList.map((e) {
                            int index = nameList.indexOf(e);
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
                                  width: 80.3,
                                  child: Center(
                                      child: Text(
                                          nameList[index],
                                        style: TextStyle(fontFamily: AppFonts.segoeui,color:selectController
                                            .listofBool[index] ==
                                            true
                                            ? Colors.white
                                            : Colors.black,fontSize: 11),
                                ),
                              ),
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
                                )
                                  )
                            );
                          }).toList(),
                        ),
                      )),
                    )
                  ];
                },
                body: tabContent[currentIndex])),
      ),
    );
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
  // TODO: implement maxExtent
  double get maxExtent => 29;

  @override
  // TODO: implement minExtent
  double get minExtent => 29;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
