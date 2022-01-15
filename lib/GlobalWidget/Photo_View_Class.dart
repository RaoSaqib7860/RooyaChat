import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class Photo_View_Class extends StatefulWidget {
  final String? url;

  const Photo_View_Class({Key? key, this.url}) : super(key: key);

  @override
  _Photo_View_ClassState createState() => _Photo_View_ClassState();
}

class _Photo_View_ClassState extends State<Photo_View_Class> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Center(
          child: PhotoView(
            imageProvider: NetworkImage("${widget.url}"),
          ),
        ),
      ),
    );
  }
}
