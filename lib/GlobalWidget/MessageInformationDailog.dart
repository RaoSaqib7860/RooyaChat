import 'package:flutter/material.dart';
import 'package:get/get.dart';

Dialog information = Dialog(
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
  backgroundColor: Colors.transparent,
  child: Container(
    width: Get.width,
    height: 100,
    decoration: BoxDecoration(color: Colors.transparent),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Cool',
          style: TextStyle(color: Colors.red),
        ),
        Text(
          'Awesome',
          style: TextStyle(color: Colors.red),
        ),
      ],
    ),
  ),
);

smsInformation({BuildContext? context}) {
  showDialog(context: context!, builder: (BuildContext context) => information);
}
