import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rooya/ApiConfig/SizeConfiq.dart';
import 'package:rooya/responsive/primary_color.dart';
import 'package:rooya/text_filed/app_font.dart';

class ChatBackgroundColor extends StatefulWidget {
  const ChatBackgroundColor({Key? key}) : super(key: key);

  @override
  _ChatBackgroundColorState createState() => _ChatBackgroundColorState();
}

class _ChatBackgroundColorState extends State<ChatBackgroundColor> {
  int selectedTab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('Chat Background Color'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: buttonColor,
      ),
      body: Container(
        width: width,
        height: height,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Seen',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: AppFonts.segoeui,
                        fontSize: 16),
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: width / 1.7),
                  child: IntrinsicWidth(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: height * 0.010, horizontal: width * 0.030),
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        children: [
                          Text(
                            'Hy there',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                                fontSize: 14),
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
                                  '12:30 PM',
                                  style: TextStyle(
                                    color: Colors.black38,
                                    fontSize: 9.0,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              FaIcon(
                                FontAwesomeIcons.checkDouble,
                                size: 15,
                                color: Colors.blue,
                              )
                            ],
                          )
                        ],
                        crossAxisAlignment: CrossAxisAlignment.end,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Receive',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: AppFonts.segoeui,
                        fontSize: 16),
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: width / 1.7),
                  child: IntrinsicWidth(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: height * 0.010, horizontal: width * 0.030),
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        children: [
                          Text(
                            'Hy there',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                                fontSize: 14),
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
                                  '12:30 PM',
                                  style: TextStyle(
                                    color: Colors.black38,
                                    fontSize: 9.0,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              FaIcon(
                                FontAwesomeIcons.checkDouble,
                                size: 15,
                                color: Colors.black38,
                              )
                            ],
                          )
                        ],
                        crossAxisAlignment: CrossAxisAlignment.end,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Sent',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: AppFonts.segoeui,
                        fontSize: 16),
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: width / 1.7),
                  child: IntrinsicWidth(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: height * 0.010, horizontal: width * 0.030),
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        children: [
                          Text(
                            'Hy there',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                                fontSize: 14),
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
                                  '12:30 PM',
                                  style: TextStyle(
                                    color: Colors.black38,
                                    fontSize: 9.0,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              FaIcon(
                                FontAwesomeIcons.check,
                                size: 15,
                                color: Colors.black38,
                              )
                            ],
                          )
                        ],
                        crossAxisAlignment: CrossAxisAlignment.end,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      selectedTab=0;
                    });
                  },
                  child: Container(
                    height: height * 0.1,
                    width: width * 0.2,
                    decoration: BoxDecoration(
                        color: Colors.blueGrey[50]!.withOpacity(0.5),
                        border: Border.all(
                            color: selectedTab == 0
                                ? buttonColor
                                : Colors.blueGrey[50]!.withOpacity(0.5),
                            width: 1),
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: Text(
                        'Standard',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: AppFonts.segoeui,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      selectedTab=1;
                    });
                  },
                  child: Container(
                    height: height * 0.1,
                    width: width * 0.2,
                    decoration: BoxDecoration(
                        color: Colors.blueGrey[50]!.withOpacity(0.5),
                        border: Border.all(color: selectedTab == 1
                            ? buttonColor
                            : Colors.blueGrey[50]!.withOpacity(0.5), width: 1),
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: Text(
                        'Custom',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: AppFonts.segoeui,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            Container(
              height: height * 0.060,
              margin: EdgeInsets.symmetric(vertical: 10),
              width: width,
              padding: EdgeInsets.symmetric(horizontal: width * 0.030),
              child: Row(
                children: [
                  Text(
                    'Text Color',
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: AppFonts.segoeui,
                        color: darkoffBlackColor),
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.black),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
            ),
            Container(
              height: height * 0.060,
              margin: EdgeInsets.symmetric(vertical: 10),
              width: width,
              padding: EdgeInsets.symmetric(horizontal: width * 0.030),
              child: Row(
                children: [
                  Text(
                    'Background Color',
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: AppFonts.segoeui,
                        color: darkoffBlackColor),
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: primaryColor),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
            ),
            Container(
              height: height * 0.060,
              margin: EdgeInsets.symmetric(vertical: 10),
              width: width,
              padding: EdgeInsets.symmetric(horizontal: width * 0.030),
              child: Row(
                children: [
                  Text(
                    'Receive tick Color',
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: AppFonts.segoeui,
                        color: darkoffBlackColor),
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.black38),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
            ),
            Container(
              height: height * 0.060,
              margin: EdgeInsets.symmetric(vertical: 10),
              width: width,
              padding: EdgeInsets.symmetric(horizontal: width * 0.030),
              child: Row(
                children: [
                  Text(
                    'Sent tick Color',
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: AppFonts.segoeui,
                        color: darkoffBlackColor),
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.black38),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
            ),
            Container(
              height: height * 0.060,
              margin: EdgeInsets.symmetric(vertical: 10),
              width: width,
              padding: EdgeInsets.symmetric(horizontal: width * 0.030),
              child: Row(
                children: [
                  Text(
                    'Time Color',
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: AppFonts.segoeui,
                        color: darkoffBlackColor),
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.black38),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
            )
          ],
        ),
      ),
    );
  }
}
