import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rooya/slidable/expendiable.dart';
import 'package:rooya/text_filed/app_font.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({Key? key}) : super(key: key);

  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {


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
              title: Text(
                'Groups',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: AppFonts.segoeui),
              ),
              trailing: Icon(
                Icons.more_vert,
                color: Colors.black,
                size: 20,
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
}
