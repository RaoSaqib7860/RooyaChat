import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rooya/ApiConfig/ApiUtils.dart';
import 'package:rooya/ApiConfig/SizeConfiq.dart';
import 'package:rooya/Utils/primary_color.dart';
import 'package:rooya/Utils/text_filed/app_font.dart';

class CustomChatView extends StatefulWidget {
  final Function()? StandardChatTap;

  const CustomChatView({Key? key, this.StandardChatTap}) : super(key: key);

  @override
  _CustomChatViewState createState() => _CustomChatViewState();
}

class _CustomChatViewState extends State<CustomChatView> {
  String seenTextColor = '';
  String receiveTextColor = '';
  String sentTextColor = '';

  String seenCheck = '';
  String receiveCheck = '';
  String sentCheck = '';

  String seenTimeColor = '';
  String receiveTimeColor = '';
  String sentTimeColor = '';

  String seenBackColor = '';
  String receiveBackColor = '';
  String sentBackColor = '';

  @override
  void initState() {
    seenTextColor = storage.read('seenTextColor');
    receiveTextColor = storage.read('receiveTextColor');
    sentTextColor = storage.read('sentTextColor');

    seenCheck = storage.read('seenCheck');
    receiveCheck = storage.read('receiveCheck');
    sentCheck = storage.read('sentCheck');

    seenTimeColor = storage.read('seenTimeColor');
    receiveTimeColor = storage.read('receiveTimeColor');
    sentTimeColor = storage.read('sentTimeColor');

    seenBackColor = storage.read('seenBackColor');
    receiveBackColor = storage.read('receiveBackColor');
    sentBackColor = storage.read('sentBackColor');

    super.initState();
  }

  Color returnColor(String value) {
    return Color.fromARGB(
        int.parse(value.split(',')[0]),
        int.parse(value.split(',')[1]),
        int.parse(value.split(',')[2]),
        int.parse(value.split(',')[3]));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
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
                        color: returnColor(seenBackColor),
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      children: [
                        Text(
                          'Hy there',
                          style: TextStyle(
                              color:returnColor(seenTextColor),
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
                                  color:returnColor(seenTimeColor),
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
                              color:returnColor(seenCheck),
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
                  'Delivered',
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
                        color:returnColor(receiveBackColor),
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      children: [
                        Text(
                          'Hy there',
                          style: TextStyle(
                              color:returnColor(receiveTextColor),
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
                                  color:returnColor(receiveTimeColor),
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
                              color:returnColor(receiveCheck),
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
                        color: Color.fromARGB(
                            int.parse(sentBackColor.split(',')[0]),
                            int.parse(sentBackColor.split(',')[1]),
                            int.parse(sentBackColor.split(',')[2]),
                            int.parse(sentBackColor.split(',')[3])),
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      children: [
                        Text(
                          'Hy there',
                          style: TextStyle(
                              color: Color.fromARGB(
                                  int.parse(sentTextColor.split(',')[0]),
                                  int.parse(sentTextColor.split(',')[1]),
                                  int.parse(sentTextColor.split(',')[2]),
                                  int.parse(sentTextColor.split(',')[3])),
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
                                  color: Color.fromARGB(
                                      int.parse(sentTimeColor.split(',')[0]),
                                      int.parse(sentTimeColor.split(',')[1]),
                                      int.parse(sentTimeColor.split(',')[2]),
                                      int.parse(sentTimeColor.split(',')[3])),
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
                              color: Color.fromARGB(
                                  int.parse(sentCheck.split(',')[0]),
                                  int.parse(sentCheck.split(',')[1]),
                                  int.parse(sentCheck.split(',')[2]),
                                  int.parse(sentCheck.split(',')[3])),
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
                onTap: widget.StandardChatTap,
                child: Container(
                  height: height * 0.070,
                  width: width * 0.2,
                  decoration: BoxDecoration(
                      color: Colors.blueGrey[50]!.withOpacity(0.5),
                      border: Border.all(
                          color: Colors.blueGrey[50]!.withOpacity(0.5),
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
              Container(
                height: height * 0.070,
                width: width * 0.2,
                decoration: BoxDecoration(
                    color: Colors.blueGrey[50]!.withOpacity(0.5),
                    border: Border.all(color: buttonColor, width: 1),
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
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          Expanded(child: ListView(children: [
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Pick a color!'),
                      content: SingleChildScrollView(
                        child: ColorPicker(
                          pickerColor: Color.fromARGB(
                              int.parse(seenTextColor.split(',')[0]),
                              int.parse(seenTextColor.split(',')[1]),
                              int.parse(seenTextColor.split(',')[2]),
                              int.parse(seenTextColor.split(',')[3])),
                          onColorChanged: (Color color) {
                            setState(() {
                              seenTextColor =
                              '${color.alpha},${color.red},${color.green},${color.blue}';
                            });
                            storage.write('seenTextColor', seenTextColor);
                          },
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                height: height * 0.060,
                margin: EdgeInsets.symmetric(vertical: 10),
                width: width,
                padding: EdgeInsets.symmetric(horizontal: width * 0.030),
                child: Row(
                  children: [
                    Text(
                      'Seen Text Color',
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: AppFonts.segoeui,
                          color: darkoffBlackColor),
                    ),
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(
                            int.parse(seenTextColor.split(',')[0]),
                            int.parse(seenTextColor.split(',')[1]),
                            int.parse(seenTextColor.split(',')[2]),
                            int.parse(seenTextColor.split(',')[3])),
                      ),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(5)),
              ),
            ),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Pick a color!'),
                      content: SingleChildScrollView(
                        child: ColorPicker(
                          pickerColor: Color.fromARGB(
                              int.parse(receiveTextColor.split(',')[0]),
                              int.parse(receiveTextColor.split(',')[1]),
                              int.parse(receiveTextColor.split(',')[2]),
                              int.parse(receiveTextColor.split(',')[3])),
                          onColorChanged: (Color color) {
                            setState(() {
                              receiveTextColor =
                              '${color.alpha},${color.red},${color.green},${color.blue}';
                            });
                            storage.write('receiveTextColor', receiveTextColor);
                          },
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                height: height * 0.060,
                margin: EdgeInsets.symmetric(vertical: 10),
                width: width,
                padding: EdgeInsets.symmetric(horizontal: width * 0.030),
                child: Row(
                  children: [
                    Text(
                      'Delivered Text Color',
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: AppFonts.segoeui,
                          color: darkoffBlackColor),
                    ),
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(
                            int.parse(receiveTextColor.split(',')[0]),
                            int.parse(receiveTextColor.split(',')[1]),
                            int.parse(receiveTextColor.split(',')[2]),
                            int.parse(receiveTextColor.split(',')[3])),
                      ),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(5)),
              ),
            ),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Pick a color!'),
                      content: SingleChildScrollView(
                        child: ColorPicker(
                          pickerColor: Color.fromARGB(
                              int.parse(sentTextColor.split(',')[0]),
                              int.parse(sentTextColor.split(',')[1]),
                              int.parse(sentTextColor.split(',')[2]),
                              int.parse(sentTextColor.split(',')[3])),
                          onColorChanged: (Color color) {
                            setState(() {
                              sentTextColor =
                              '${color.alpha},${color.red},${color.green},${color.blue}';
                            });
                            storage.write('sentTextColor', sentTextColor);
                          },
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                height: height * 0.060,
                margin: EdgeInsets.symmetric(vertical: 10),
                width: width,
                padding: EdgeInsets.symmetric(horizontal: width * 0.030),
                child: Row(
                  children: [
                    Text(
                      'Sent Text Color',
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: AppFonts.segoeui,
                          color: darkoffBlackColor),
                    ),
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(
                            int.parse(sentTextColor.split(',')[0]),
                            int.parse(sentTextColor.split(',')[1]),
                            int.parse(sentTextColor.split(',')[2]),
                            int.parse(sentTextColor.split(',')[3])),
                      ),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(5)),
              ),
            ),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Pick a color!'),
                      content: SingleChildScrollView(
                        child: ColorPicker(
                          pickerColor: Color.fromARGB(
                              int.parse(seenBackColor.split(',')[0]),
                              int.parse(seenBackColor.split(',')[1]),
                              int.parse(seenBackColor.split(',')[2]),
                              int.parse(seenBackColor.split(',')[3])),
                          onColorChanged: (Color color) {
                            setState(() {
                              seenBackColor =
                              '${color.alpha},${color.red},${color.green},${color.blue}';
                            });
                            storage.write('seenBackColor', seenBackColor);
                          },
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                height: height * 0.060,
                margin: EdgeInsets.symmetric(vertical: 10),
                width: width,
                padding: EdgeInsets.symmetric(horizontal: width * 0.030),
                child: Row(
                  children: [
                    Text(
                      'Seen Background Color',
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: AppFonts.segoeui,
                          color: darkoffBlackColor),
                    ),
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(
                            int.parse(seenBackColor.split(',')[0]),
                            int.parse(seenBackColor.split(',')[1]),
                            int.parse(seenBackColor.split(',')[2]),
                            int.parse(seenBackColor.split(',')[3])),
                      ),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(5)),
              ),
            ),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Pick a color!'),
                      content: SingleChildScrollView(
                        child: ColorPicker(
                          pickerColor: Color.fromARGB(
                              int.parse(receiveBackColor.split(',')[0]),
                              int.parse(receiveBackColor.split(',')[1]),
                              int.parse(receiveBackColor.split(',')[2]),
                              int.parse(receiveBackColor.split(',')[3])),
                          onColorChanged: (Color color) {
                            setState(() {
                              receiveBackColor =
                              '${color.alpha},${color.red},${color.green},${color.blue}';
                            });
                            storage.write('receiveBackColor', receiveBackColor);
                          },
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                height: height * 0.060,
                margin: EdgeInsets.symmetric(vertical: 10),
                width: width,
                padding: EdgeInsets.symmetric(horizontal: width * 0.030),
                child: Row(
                  children: [
                    Text(
                      'Delivered Background Color',
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: AppFonts.segoeui,
                          color: darkoffBlackColor),
                    ),
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(
                            int.parse(receiveBackColor.split(',')[0]),
                            int.parse(receiveBackColor.split(',')[1]),
                            int.parse(receiveBackColor.split(',')[2]),
                            int.parse(receiveBackColor.split(',')[3])),
                      ),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(5)),
              ),
            ),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Pick a color!'),
                      content: SingleChildScrollView(
                        child: ColorPicker(
                          pickerColor: Color.fromARGB(
                              int.parse(sentBackColor.split(',')[0]),
                              int.parse(sentBackColor.split(',')[1]),
                              int.parse(sentBackColor.split(',')[2]),
                              int.parse(sentBackColor.split(',')[3])),
                          onColorChanged: (Color color) {
                            setState(() {
                              sentBackColor =
                              '${color.alpha},${color.red},${color.green},${color.blue}';
                            });
                            storage.write('sentBackColor', sentBackColor);
                          },
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                height: height * 0.060,
                margin: EdgeInsets.symmetric(vertical: 10),
                width: width,
                padding: EdgeInsets.symmetric(horizontal: width * 0.030),
                child: Row(
                  children: [
                    Text(
                      'Sent Background Color',
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: AppFonts.segoeui,
                          color: darkoffBlackColor),
                    ),
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(
                            int.parse(sentBackColor.split(',')[0]),
                            int.parse(sentBackColor.split(',')[1]),
                            int.parse(sentBackColor.split(',')[2]),
                            int.parse(sentBackColor.split(',')[3])),
                      ),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(5)),
              ),
            ),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Pick a color!'),
                      content: SingleChildScrollView(
                        child: ColorPicker(
                          pickerColor: Color.fromARGB(
                              int.parse(sentBackColor.split(',')[0]),
                              int.parse(sentBackColor.split(',')[1]),
                              int.parse(sentBackColor.split(',')[2]),
                              int.parse(sentBackColor.split(',')[3])),
                          onColorChanged: (Color color) {
                            setState(() {
                              sentBackColor =
                              '${color.alpha},${color.red},${color.green},${color.blue}';
                            });
                            storage.write('sentBackColor', sentBackColor);
                          },
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                height: height * 0.060,
                margin: EdgeInsets.symmetric(vertical: 10),
                width: width,
                padding: EdgeInsets.symmetric(horizontal: width * 0.030),
                child: Row(
                  children: [
                    Text(
                      'Seen tick Color',
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: AppFonts.segoeui,
                          color: darkoffBlackColor),
                    ),
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(
                              int.parse(seenCheck.split(',')[0]),
                              int.parse(seenCheck.split(',')[1]),
                              int.parse(seenCheck.split(',')[2]),
                              int.parse(seenCheck.split(',')[3]))),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(5)),
              ),
            ),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Pick a color!'),
                      content: SingleChildScrollView(
                        child: ColorPicker(
                          pickerColor: Color.fromARGB(
                              int.parse(receiveCheck.split(',')[0]),
                              int.parse(receiveCheck.split(',')[1]),
                              int.parse(receiveCheck.split(',')[2]),
                              int.parse(receiveCheck.split(',')[3])),
                          onColorChanged: (Color color) {
                            setState(() {
                              receiveCheck =
                              '${color.alpha},${color.red},${color.green},${color.blue}';
                            });
                            storage.write('receiveCheck', receiveCheck);
                          },
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                height: height * 0.060,
                margin: EdgeInsets.symmetric(vertical: 10),
                width: width,
                padding: EdgeInsets.symmetric(horizontal: width * 0.030),
                child: Row(
                  children: [
                    Text(
                      'Delivered tick Color',
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: AppFonts.segoeui,
                          color: darkoffBlackColor),
                    ),
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(
                              int.parse(receiveCheck.split(',')[0]),
                              int.parse(receiveCheck.split(',')[1]),
                              int.parse(receiveCheck.split(',')[2]),
                              int.parse(receiveCheck.split(',')[3]))),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(5)),
              ),
            ),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Pick a color!'),
                      content: SingleChildScrollView(
                        child: ColorPicker(
                          pickerColor: Color.fromARGB(
                              int.parse(sentCheck.split(',')[0]),
                              int.parse(sentCheck.split(',')[1]),
                              int.parse(sentCheck.split(',')[2]),
                              int.parse(sentCheck.split(',')[3])),
                          onColorChanged: (Color color) {
                            setState(() {
                              sentCheck =
                              '${color.alpha},${color.red},${color.green},${color.blue}';
                            });
                            storage.write('sentCheck', sentCheck);
                          },
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
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
                          shape: BoxShape.circle,
                          color: Color.fromARGB(
                              int.parse(sentCheck.split(',')[0]),
                              int.parse(sentCheck.split(',')[1]),
                              int.parse(sentCheck.split(',')[2]),
                              int.parse(sentCheck.split(',')[3]))),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(5)),
              ),
            ),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Pick a color!'),
                      content: SingleChildScrollView(
                        child: ColorPicker(
                          pickerColor: Color.fromARGB(
                              int.parse(seenTimeColor.split(',')[0]),
                              int.parse(seenTimeColor.split(',')[1]),
                              int.parse(seenTimeColor.split(',')[2]),
                              int.parse(seenTimeColor.split(',')[3])),
                          onColorChanged: (Color color) {
                            setState(() {
                              seenTimeColor =
                              '${color.alpha},${color.red},${color.green},${color.blue}';
                            });
                            storage.write('seenTimeColor', seenTimeColor);
                          },
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                height: height * 0.060,
                margin: EdgeInsets.symmetric(vertical: 10),
                width: width,
                padding: EdgeInsets.symmetric(horizontal: width * 0.030),
                child: Row(
                  children: [
                    Text(
                      'Seen Time Color',
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: AppFonts.segoeui,
                          color: darkoffBlackColor),
                    ),
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(
                              int.parse(seenTimeColor.split(',')[0]),
                              int.parse(seenTimeColor.split(',')[1]),
                              int.parse(seenTimeColor.split(',')[2]),
                              int.parse(seenTimeColor.split(',')[3]))),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(5)),
              ),
            ),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Pick a color!'),
                      content: SingleChildScrollView(
                        child: ColorPicker(
                          pickerColor: Color.fromARGB(
                              int.parse(receiveTimeColor.split(',')[0]),
                              int.parse(receiveTimeColor.split(',')[1]),
                              int.parse(receiveTimeColor.split(',')[2]),
                              int.parse(receiveTimeColor.split(',')[3])),
                          onColorChanged: (Color color) {
                            setState(() {
                              receiveTimeColor =
                              '${color.alpha},${color.red},${color.green},${color.blue}';
                            });
                            storage.write('receiveTimeColor', receiveTimeColor);
                          },
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                height: height * 0.060,
                margin: EdgeInsets.symmetric(vertical: 10),
                width: width,
                padding: EdgeInsets.symmetric(horizontal: width * 0.030),
                child: Row(
                  children: [
                    Text(
                      'Delivered Time Color',
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: AppFonts.segoeui,
                          color: darkoffBlackColor),
                    ),
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(
                              int.parse(receiveTimeColor.split(',')[0]),
                              int.parse(receiveTimeColor.split(',')[1]),
                              int.parse(receiveTimeColor.split(',')[2]),
                              int.parse(receiveTimeColor.split(',')[3]))),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(5)),
              ),
            ),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Pick a color!'),
                      content: SingleChildScrollView(
                        child: ColorPicker(
                          pickerColor: Color.fromARGB(
                              int.parse(sentTimeColor.split(',')[0]),
                              int.parse(sentTimeColor.split(',')[1]),
                              int.parse(sentTimeColor.split(',')[2]),
                              int.parse(sentTimeColor.split(',')[3])),
                          onColorChanged: (Color color) {
                            setState(() {
                              sentTimeColor =
                              '${color.alpha},${color.red},${color.green},${color.blue}';
                            });
                            storage.write('sentTimeColor', sentTimeColor);
                          },
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                height: height * 0.060,
                margin: EdgeInsets.symmetric(vertical: 10),
                width: width,
                padding: EdgeInsets.symmetric(horizontal: width * 0.030),
                child: Row(
                  children: [
                    Text(
                      'Sent Time Color',
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: AppFonts.segoeui,
                          color: darkoffBlackColor),
                    ),
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(
                              int.parse(sentTimeColor.split(',')[0]),
                              int.parse(sentTimeColor.split(',')[1]),
                              int.parse(sentTimeColor.split(',')[2]),
                              int.parse(sentTimeColor.split(',')[3]))),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(5)),
              ),
            )
          ],),),
        ],
      ),
    );
  }
}
