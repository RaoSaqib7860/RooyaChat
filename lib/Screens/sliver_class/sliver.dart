import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rooya/Providers/ClickController/SelectIndexController.dart';
import 'package:rooya/Screens/Information/UserChatInformation/user_chat_information.dart';
import 'package:rooya/Screens/SearchUser/SearchUser.dart';
import 'package:rooya/Screens/Settings/Settings.dart';
import 'package:rooya/Utils/UserDataService.dart';
import 'package:rooya/Utils/text_filed/app_font.dart';

class MySliver extends StatefulWidget {
  const MySliver({Key? key}) : super(key: key);

  @override
  _MySliverState createState() => _MySliverState();
}

class _MySliverState extends State<MySliver> {
  var selectController = Get.find<SelectIndexController>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 9,
          ),
          ListTile(
              onTap: () {
                Get.to(UserChatInformation(
                    userID:
                        '${UserDataService.userDataModel!.userData!.userId}'));
              },
              leading: CircularProfileAvatar(
                '${UserDataService.userDataModel!.userData!.avatar}',
                radius: 18,
                backgroundColor: Colors.blueGrey[100]!,
              ),
              title: Text(
                '${UserDataService.userDataModel!.userData!.firstName} ${UserDataService.userDataModel!.userData!.lastName}',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.segoeui),
              ),
              trailing: Wrap(
                children: [
                  InkWell(
                    child: Icon(
                      CupertinoIcons.search,
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (c) => SearchUser()));
                    },
                  ),
                  InkWell(
                      onTap: () {
                        // return createAlertDialoge1(context);
                      },
                      child: Icon(
                        CupertinoIcons.bell_solid,
                        color: Colors.black,
                        size: 23,
                      )),
                  InkWell(
                      onTap: () {
                        Get.to(Settings());
                      },
                      child: Container(
                        height: 20,
                        width: 20,
                        child: SvgPicture.asset('assets/user/setting.svg'),
                      )),
                ],
                spacing: 8,
              )),
          // Container(
          //   height: height * 0.045,
          //   width: width,
          //   margin: EdgeInsets.symmetric(horizontal: 10),
          //   padding: EdgeInsets.only(left: 10, right: 0),
          //   child: TextFormField(
          //     onChanged: (value) {
          //       selectController.search.value = value;
          //       print('selectController search is = ${selectController.search.value}');
          //     },
          //     style: TextStyle(fontSize: 14),
          //     decoration: InputDecoration(
          //       disabledBorder: new OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(30),
          //           borderSide: new BorderSide(
          //             color: Colors.black12,
          //           )),
          //       focusedBorder: new OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(30),
          //           borderSide: new BorderSide(
          //             color: Colors.black12,
          //           )),
          //       enabledBorder: new OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(30),
          //           borderSide: new BorderSide(
          //             color: Colors.black12,
          //           )),
          //       border: new OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(30),
          //           borderSide: new BorderSide(
          //             color: Colors.black12,
          //           )),
          //       isDense: true,
          //       hintText: 'Search here ...',
          //       hintStyle: TextStyle(fontSize: 10, color: Colors.black),
          //       suffixIcon: Icon(
          //         Icons.search,
          //         size: 20,
          //         color: Color(0XFF0BAB0D),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  createAlertDialoge1(BuildContext context) {
    TextEditingController customController = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              insetPadding: EdgeInsets.only(left: 15, right: 15),
              content: Container(
                  height: 260,
                  width: 350,
                  //color: Colors.green,
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 115),
                          child: Text(
                            'Steven',
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 25,
                                fontFamily: AppFonts.segoeui),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0XFFF9F9F9),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'online',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: AppFonts.segoeui),
                                ),
                                Icon(Icons.arrow_drop_down_outlined)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    CircularProfileAvatar(
                      '',
                      radius: 60,
                      //backgroundColor: Colors.red,
                      child: Image(
                        image: AssetImage('assets/user/logooo.png'),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 40,
                      width: 130,
                      child: Center(
                        child: Text(
                          'SAVE',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: AppFonts.segoeui),
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
