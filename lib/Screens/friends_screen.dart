import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rooya/GlobalWidget/slidable/expendiable.dart';
import 'package:rooya/Utils/text_filed/app_font.dart';

import 'Settings/Settings.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({Key? key}) : super(key: key);

  @override
  _FriendsScreenState createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  List imageList = [
    'assets/svg/sliderimg.svg',
    'assets/svg/sliderimg.svg',
    'assets/svg/sliderimg.svg',
    'assets/svg/sliderimg.svg',
    'assets/svg/sliderimg.svg',
    'assets/svg/sliderimg.svg',
    'assets/svg/sliderimg.svg',
    'assets/svg/sliderimg.svg',
    'assets/svg/sliderimg.svg',
    'assets/svg/sliderimg.svg',
    'assets/svg/sliderimg.svg',
    'assets/svg/sliderimg.svg',
    'assets/svg/sliderimg.svg',
    'assets/svg/sliderimg.svg',
    'assets/svg/sliderimg.svg',
    'assets/svg/sliderimg.svg',
    'assets/svg/sliderimg.svg',
    'assets/svg/sliderimg.svg',
  ];

  List nameList = [
    'Friends',
    'Friends',
    'Friends',
    'Friends',
    'Friends',
    'Friends',
    'Friends',
    'Friends',
    'Friends',
    'Friends',
    'Friends',
    'Friends',
    'Friends',
    'Friends',
    'Friends',
    'Friends',
    'Friends',
    'Friends',
  ];

  List textList = [
    'New Messages',
    'New Messages',
    'New Messages',
    'New Messages',
    'New Messages',
    'New Messages',
    'New Messages',
    'New Messages',
    'New Messages',
    'New Messages',
    'New Messages',
    'New Messages',
    'New Messages',
    'New Messages',
    'New Messages',
    'New Messages',
    'New Messages',
    'New Messages',
  ];

  List timeList = [
    '3:30pm',
    '3:30pm',
    '3:30pm',
    '3:30pm',
    '3:30pm',
    '3:30pm',
    '3:30pm',
    '3:30pm',
    '3:30pm',
    '3:30pm',
    '3:30pm',
    '3:30pm',
    '3:30pm',
    '3:30pm',
    '3:30pm',
    '3:30pm',
    '3:30pm',
    '3:30pm',
  ];
  List notificationList = [
    '33',
    '2',
    '1',
    '4',
    '8',
    '4',
    '3',
    '6',
    '87',
    '98',
    '89',
    '9',
    '3',
    '6',
    '87',
    '98',
    '89',
    '9',
  ];

  List imageList1 = [
    'assets/svg/sliderimg.svg',
    'assets/svg/sliderimg.svg',
    'assets/svg/sliderimg.svg',
    'assets/svg/sliderimg.svg',
    'assets/svg/sliderimg.svg',

  ];

  List nameList1 = [
    'Aleena',
    'Aleena',
    'Aleena',
    'Aleena',
    'Aleena',
  ];

  List textList1 = [
    '@aleena123',
    '@aleena123',
    '@aleena123',
    '@aleena123',
    '@aleena123',
  ];

  List acceptButtonList1 = [
    'Admin',
    'Admin',
    'Admin',
    'Admin',
    'Admin',
  ];


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: ListTile(
              title: InkWell(
                        onTap: (){
                          Get.to(Settings());
                        },
                child: Text(
                  'Friends',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: AppFonts.segoeui),
                ),
              ),
              trailing: InkWell(
                onTap: (){
                  return createAlertDialoge(context);
                },
                child: Icon(
                  Icons.more_vert,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
          ),
          SliverList(
              delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
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
                                    // ScaffoldMessenger.of(context)
                                    //     .showSnackBar(snackBar);
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

                                    },
                                    backgroundColor: CupertinoColors.destructiveRed,
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
                          ListTile(
                            leading: CircularProfileAvatar(
                              '',
                              radius: 28,
                              child: SvgPicture.asset(
                                imageList[index],
                                fit: BoxFit.fill,
                              ),
                            ),
                            title: Text(
                              nameList[index],
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontFamily: AppFonts.segoeui,
                                  fontSize: 16),
                            ),
                            subtitle: Text(
                              textList[index],
                              style: TextStyle(
                                  color: Color(0XFF373737),
                                  fontFamily: AppFonts.segoeui,
                                  fontSize: 12),
                            ),
                            trailing: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: Container(
                                    height: height * 0.060,
                                    width: width * 0.060,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.green),
                                    child: Center(
                                      child: Text(
                                        notificationList[index],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontFamily: AppFonts.segoeui),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  timeList[index],
                                  style: TextStyle(
                                      color: Color(0XFF373737),
                                      fontSize: 10,
                                      fontFamily: AppFonts.segoeui),
                                )
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
                    ),
                  ],
                );
              }, childCount: imageList.length))
        ],
      ),
      floatingActionButton: CustomButton(),
    );
  }

  createAlertDialoge(BuildContext context) {
    TextEditingController customController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              insetPadding: EdgeInsets.only(left: 15, right: 15),
              content: Container(
                  height: 500,
                  width: 400,
                  //color: Colors.green,
                  child: Column(children: [
                    Text('Create Group',style: TextStyle(color: Colors.green,fontSize: 20),),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      height: 45,
                      width: 300,
                      color: Colors.blueGrey[50],
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: 'Write Group Name',
                            hintStyle: TextStyle(fontSize: 13,fontFamily: AppFonts.segoeui),
                            contentPadding: EdgeInsets.only(left: 8),
                            border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      height: 35,
                      // width: 350,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      padding: EdgeInsets.only(left: 10, right: 0),
                      decoration: BoxDecoration(
                          color: Colors.blueGrey[50],
                          borderRadius: BorderRadius.circular(40)),
                      child: TextField(
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          hintText: 'Search Member ...',
                          hintStyle:
                          TextStyle(fontSize: 12, color: Colors.black,fontFamily: AppFonts.segoeui),
                          suffixIcon: Icon(
                            Icons.search,
                            size: 20,
                            color: Color(0XFF0BAB0D),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      height: 300,
                      color: Colors.white,
                      child: ListView.builder(
                        itemCount: imageList1.length,
                        itemBuilder: (context, index) => Column(
                          children: [
                            ListTile(
                              leading: CircularProfileAvatar(
                                '',
                                radius: 23,
                                child: SvgPicture.asset(
                                  imageList1[index],
                                  fit: BoxFit.fill,
                                ),
                              ),
                              title: Text(nameList1[index],style: TextStyle(fontFamily: AppFonts.segoeui),),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(textList1[index],style: TextStyle(fontFamily: AppFonts.segoeui),),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    height: 30,
                                    width: 70,
                                    child: Center(
                                        child: Text(
                                          acceptButtonList1[index],
                                          style: TextStyle(color: Colors.green,fontFamily: AppFonts.segoeui),
                                        )),
                                    decoration: BoxDecoration(
                                      //color: Colors.grey,
                                        border: Border.all(color: Colors.green),
                                        borderRadius:
                                        BorderRadius.circular(20)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Container(
                                      height: 25,
                                      width: 25,
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle),
                                      child: Center(
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.white,
                                          )),
                                    ),
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
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Container(
                      height: 40,
                      width: 130,
                      child: Center(
                        child: Text(
                          'CREATE',
                          style: TextStyle(color: Colors.white, fontSize: 15,fontFamily: AppFonts.segoeui),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color(0XFF0BAB0D),
                      ),
                    ),
                  ])));
        });
  }

}
