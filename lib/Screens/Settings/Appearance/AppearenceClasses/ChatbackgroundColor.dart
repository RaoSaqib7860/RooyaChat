import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rooya/ApiConfig/ApiUtils.dart';
import 'package:rooya/Utils/primary_color.dart';

import 'CustomChatView.dart';
import 'StandardChatView.dart';

class ChatBackgroundColor extends StatefulWidget {
  const ChatBackgroundColor({Key? key}) : super(key: key);

  @override
  _ChatBackgroundColorState createState() => _ChatBackgroundColorState();
}

class _ChatBackgroundColorState extends State<ChatBackgroundColor> {
  int selectedTab = 0;

  @override
  void initState() {
    selectedTab = int.parse(storage.read('selectedTab'));
    super.initState();
  }

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
      body: selectedTab == 0
          ? StandardChatView(
              oncustomTap: () {
                setState(() {
                  selectedTab = 1;
                });
                storage.write('selectedTab', '1');
              },
            )
          : CustomChatView(
              StandardChatTap: () {
                setState(() {
                  selectedTab = 0;
                });
                storage.write('selectedTab', '0');
              },
            ),
    );
  }
}
