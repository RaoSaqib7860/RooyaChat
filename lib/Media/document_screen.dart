import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rooya/text_filed/app_font.dart';

class DocumentScreen extends StatefulWidget {
  const DocumentScreen({Key? key}) : super(key: key);

  @override
  _DocumentScreenState createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  List imageList = [
    'assets/user/ms.svg',
    'assets/user/ms.svg',
    'assets/user/ms.svg',
    'assets/user/ms.svg',
    'assets/user/ms.svg',
  ];
  List firstText = [
    'Paper Scan',
    'Paper Scan',
    'Paper Scan',
    'Paper Scan',
    'Paper Scan',
  ];
  List secondText = [
    '18 Mar,2021',
    '18 Mar,2021',
    '18 Mar,2021',
    '18 Mar,2021',
    '18 Mar,2021',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: ListTile(
                title: Text(
                  '5 Documents',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(left: 12, right: 12),
              sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.blueGrey[50],
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(top: 12),
                          child: Column(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                child: SvgPicture.asset(
                                  imageList[index],
                                  fit: BoxFit.fill,
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                firstText[index],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                    fontFamily: AppFonts.segoeui
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                secondText[index],
                                style: TextStyle(fontSize: 10,fontFamily: AppFonts.segoeui),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    childCount: imageList.length,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 15.2,
                      childAspectRatio: 1,
                      mainAxisSpacing: 15.0)),
            ),
          ],
        ),
      ),
    );
  }
}
