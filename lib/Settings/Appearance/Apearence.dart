import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rooya/ApiConfig/SizeConfiq.dart';
import 'package:rooya/responsive/primary_color.dart';
import 'package:rooya/text_filed/app_font.dart';

class Apearennce extends StatefulWidget {
  const Apearennce({Key? key}) : super(key: key);

  @override
  _ApearennceState createState() => _ApearennceState();
}

class _ApearennceState extends State<Apearennce> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('Appearance'),
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            apearenceTile(
              width: width,
              height: height,
              title: 'Chat background color',
            ),
          ],
        ),
      ),
    );
  }
}

Widget apearenceTile({double? height, double? width, String? title}) {
  return Container(
    height: height! * 0.060,
    margin: EdgeInsets.symmetric(vertical: 10),
    width: width,
    padding: EdgeInsets.symmetric(horizontal: width! * 0.030),
    child: Row(
      children: [
        Text(
          '$title',
          style: TextStyle(
              fontSize: 15,
              fontFamily: AppFonts.segoeui,
              color: darkoffBlackColor),
        ),
        Icon(
          Icons.arrow_forward_ios,
          color: Colors.black38,
        )
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
    ),
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(5)),
  );
}
