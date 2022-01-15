import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rooya/text_filed/app_font.dart';

class LinkScreen extends StatefulWidget {
  const LinkScreen({Key? key}) : super(key: key);

  @override
  _LinkScreenState createState() => _LinkScreenState();
}

class _LinkScreenState extends State<LinkScreen> {

  List imageList = [
    'assets/svg/sliderimg.svg',
    'assets/svg/sliderimg.svg',
    'assets/svg/sliderimg.svg',
    'assets/svg/sliderimg.svg',
    'assets/svg/sliderimg.svg',

  ];

  List textList = [
    'https//www.youtube.com/post\nyoutube.com/post',
    'https//www.youtube.com/post\nyoutube.com/post',
    'https//www.youtube.com/post\nyoutube.com/post',
    'https//www.youtube.com/post\nyoutube.com/post',
    'https//www.youtube.com/post\nyoutube.com/post',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            ListTile(
              title: Text('Links'),
            ),
            Expanded(
                child: ListView.builder(itemCount: imageList.length,
              itemBuilder: (context, index) => Column(
                children: [
                  Padding(
                    padding:  EdgeInsets.only(left: 13,top: 15),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            height: 70,
                            width: 70,
                            child: SvgPicture.asset(imageList[index],fit: BoxFit.fill,),
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(left: 8),
                          child: Text(textList[index],style: TextStyle(fontFamily: AppFonts.segoeui),),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
