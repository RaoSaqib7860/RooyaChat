import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rooya/responsive/primary_color.dart';
import 'package:rooya/text_filed/app_font.dart';

class GroupInformation extends StatefulWidget {
  const GroupInformation({Key? key}) : super(key: key);

  @override
  _GroupInformationState createState() => _GroupInformationState();
}

class _GroupInformationState extends State<GroupInformation> {
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
    'Groups',
    'Groups',
    'Groups',
    'Groups',
    'Groups',
    'Groups',
    'Groups',
    'Groups',
    'Groups',
    'Groups',
    'Groups',
    'Groups',
    'Groups',
    'Groups',
    'Groups',
    'Groups',
    'Groups',
    'Groups',
  ];

  List textList = [
    'New Groups',
    'New Groups',
    'New Groups',
    'New Groups',
    'New Groups',
    'New Groups',
    'New Groups',
    'New Groups',
    'New Groups',
    'New Groups',
    'New Groups',
    'New Groups',
    'New Groups',
    'New Groups',
    'New Groups',
    'New Groups',
    'New Groups',
    'New Groups',
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


  bool status = false;
  bool status1 = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: CustomScrollView(slivers: [
              SliverAppBar(
                backgroundColor: primaryColor,
                expandedHeight: 200,
                elevation: 20,
                floating: false,
                pinned: true,
                snap: false,
                actions: [
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: primaryColor,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.edit,
                          size: 16,
                        ),
                      ),
                    ),
                  )
                ],
                leading: Icon(Icons.arrow_back),
                flexibleSpace: FlexibleSpaceBar(
                  //collapseMode: CollapseMode.none,
                  title: Text('Future Discussion                   ',style: TextStyle(fontSize: 18,fontFamily: AppFonts.segoeui,)),
                  centerTitle: true,
                  background: SvgPicture.asset(
                    'assets/svg/sliderimg.svg',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.05, top: height * 0.02),
                      child: Text(
                        'Hey there! I an using Rooya Chat Hey there! I an using Rooya Chat Hey there! I an using Rooya Chat Hey there! I an using Rooya Chat Hey there! I an using Rooya Chat Hey there! I an using Rooya Chat',
                        style: TextStyle(fontSize: 13,fontFamily: AppFonts.segoeui,),
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(right: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        //crossAxisAlignment: CrossAxisAlignment.end,
                        children: [

                          Text('Read more....',style: TextStyle(color: primaryColor,fontFamily: AppFonts.segoeui,),)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.007,
                    ),
                    Container(
                      width: width,
                      height: height * 0.08,
                      //color: Colors.green,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: height * 0.06,
                            width: width * 0.45,
                            color: Colors.blueGrey[50],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Notification',
                                  style: TextStyle(fontSize: 15,fontFamily: AppFonts.segoeui,),
                                ),
                                CupertinoSwitch(
                                  value: status,
                                  onChanged: (bool value) {
                                    setState(() {
                                      status = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: height * 0.06,
                            width: width * 0.45,
                            color: Colors.blueGrey[50],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Favorite Message',
                                  style: TextStyle(fontSize: 15,fontFamily: AppFonts.segoeui,),
                                ),
                                Icon(
                                  Icons.favorite,
                                  color: primaryColor,
                                  size: 25,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.035),
                      child: Container(
                        height: height * 0.06,
                        width: width * 0.93,
                        color: Colors.blueGrey[50],
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Auto Save Media to Camera Role',
                              style: TextStyle(fontSize: 15,fontFamily: AppFonts.segoeui,),
                            ),
                            CupertinoSwitch(
                              value: status1,
                              onChanged: (bool value) {
                                setState(() {
                                  status1 = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: height * 0.28,
                      width: width,
                      //color: Colors.blueGrey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Card(
                                elevation: 2,
                                child: Container(
                                  height: height * 0.10,
                                  width: width * 0.45,
                                  decoration: BoxDecoration(color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0x290bab0d),
                                        offset: Offset(0, 3),
                                        blurRadius: 6,
                                      ),
                                    ],),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        height: 40,
                                        width: 40,
                                        //color: Colors.white,
                                        child: SvgPicture.asset(
                                          'assets/user/g.svg',
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Text(
                                        'Photos',
                                        style: TextStyle(fontSize: 18,fontFamily: AppFonts.segoeui,),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                elevation: 2,
                                child: Container(
                                  height: height * 0.10,
                                  width: width * 0.45,
                                  decoration: BoxDecoration(color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0x290bab0d),
                                        offset: Offset(0, 3),
                                        blurRadius: 6,
                                      ),
                                    ],),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        height: 25,
                                        width: 50,
                                        //color: Colors.white,
                                        child: SvgPicture.asset(
                                          'assets/user/d.svg',
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Text(
                                        'Videos',
                                        style: TextStyle(fontSize: 18,fontFamily: AppFonts.segoeui,),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Card(
                                elevation: 2,
                                child: Container(
                                  height: height * 0.10,
                                  width: width * 0.45,
                                  decoration: BoxDecoration(color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0x290bab0d),
                                        offset: Offset(0, 3),
                                        blurRadius: 6,
                                      ),
                                    ],),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        height: 40,
                                        width: 40,
                                        //color: Colors.white,
                                        child: SvgPicture.asset(
                                          'assets/user/l.svg',
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Text(
                                        'Links',
                                        style: TextStyle(fontSize: 18,fontFamily: AppFonts.segoeui,),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                elevation: 2,
                                child: Container(
                                  height: height * 0.10,
                                  width: width * 0.45,
                                  decoration: BoxDecoration(color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0x290bab0d),
                                        offset: Offset(0, 3),
                                        blurRadius: 6,
                                      ),
                                    ],),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        height: 35,
                                        width: 30,
                                        //color: Colors.white,
                                        child: SvgPicture.asset(
                                          'assets/user/de.svg',
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Text(
                                        'Documents',
                                        style: TextStyle(fontSize: 18,fontFamily: AppFonts.segoeui,),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: height * 0.08,
                      width: width,
                      // color: Colors.red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                'Mutual Groups',
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontFamily: AppFonts.segoeui,
                                    color: Colors.black),
                              ),
                              Text(
                                '3 Groups',
                                style: TextStyle(fontSize: 13,fontFamily: AppFonts.segoeui,),
                              ),
                            ],
                          ),
                          Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.green,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.add,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                            height: 40,
                            width: 220,
                            decoration: BoxDecoration(
                                color: Colors.blueGrey[50],
                                borderRadius: BorderRadius.circular(20)),
                            child: TextField(
                              decoration: InputDecoration(
                                isDense: true,
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                hintText: 'Search here ....',
                                hintStyle: TextStyle(
                                    fontSize: 13, color: Colors.black,fontFamily: AppFonts.segoeui,),
                                counterStyle:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                                suffixIcon: Icon(
                                  Icons.search,
                                  size: 23,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                return Column(
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
                );
              }, childCount: imageList.length))
            ])));
  }
}
