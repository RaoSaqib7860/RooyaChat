import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:rooya/Providers/ClickController/SelectIndexController.dart';
import 'package:rooya/Screens/UserChat/Media/media_main.dart';

import 'my_request.dart';
import 'new_request.dart';

class ChatRequest extends StatefulWidget {
  const ChatRequest({Key? key}) : super(key: key);

  @override
  _ChatRequestState createState() => _ChatRequestState();
}

class _ChatRequestState extends State<ChatRequest> {

  List tabContent = [
    (NewRequest()),
    (MyRequest()),
  ];
  List textHeading = [
    'NEW REQUEST',
    'MY REQUEST',
  ];

  int currentIndex = 0;

  var selectController = Get.put(SelectIndexController());

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title: Text(
            'Chat Request',
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w800),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(top: 20, right: 10),
              child: Wrap(children: [
                Icon(CupertinoIcons.bell_solid, color: Colors.black,),
                InkWell(
                    onTap: () {
                      Get.to(MainMedia());
                    },
                    child: Icon(Icons.settings, color: Colors.green,)),
              ], spacing: 12,),
            )
          ],
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: DefaultTabController(
            length: 2,
            child: NestedScrollView(
                physics: NeverScrollableScrollPhysics(),
                headerSliverBuilder: (context, isScrool) {
                  return [
                    SliverPersistentHeader(
                      floating: true,
                      pinned: true,
                      delegate: MyDelegate(Container(
                        height: 100,
                        color: Colors.white,
                        child: ListView.builder(
                            itemCount: 2,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Obx(
                                    () =>
                                    InkWell(
                                      onTap: () {
                                        selectController.updateColor(index);
                                        setState(() {
                                          currentIndex = index;
                                        });
                                      },
                                      child: Container(
                                        margin: EdgeInsets.all(8),
                                        //height: 60,
                                        width: 110,
                                        child: Center(child: Text(
                                          textHeading[index],
                                          style: TextStyle(color:selectController
                                              .listofBool[index] ==
                                              true
                                              ? Colors.white
                                              : Colors.black,fontSize: 13),
                                        ),
                                        ),
                                        decoration: BoxDecoration(
                                            border: Border.all(),
                                            color: selectController
                                                .listofBool[index] ==
                                                true
                                                ? Color(0XFF0BAB0D)
                                                : Colors.white),
                                      ),
                                    ),
                              );
                            }),
                      )),
                    )
                  ];
                },
                body: tabContent[currentIndex]
            )
        ),
      ),
    );
  }
}

class MyDelegate extends SliverPersistentHeaderDelegate {
  MyDelegate(this.widget);

  final Widget widget;

  @override
  Widget build(BuildContext context, double shrinkOffset,
      bool overlapsContent) {
    return widget;

  }

  @override
  double get maxExtent => 45;

  @override
  double get minExtent => 40;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
