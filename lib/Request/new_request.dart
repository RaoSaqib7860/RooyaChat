import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NewRequest extends StatefulWidget {
  const NewRequest({Key? key}) : super(key: key);

  @override
  _NewRequestState createState() => _NewRequestState();
}

class _NewRequestState extends State<NewRequest> {
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
    'Aleena',
    'Aleena',
    'Aleena',
    'Aleena',
    'Aleena',
    'Aleena',
    'Aleena',
    'Aleena',
    'Aleena',
    'Aleena',
    'Aleena',
    'Aleena',
    'Aleena',
    'Aleena',
    'Aleena',
    'Aleena',
    'Aleena',
    'Aleena',
  ];

  List timerList = [
    '2 hours ago',
    '2 hours ago',
    '2 hours ago',
    '2 hours ago',
    '2 hours ago',
    '2 hours ago',
    '2 hours ago',
    '2 hours ago',
    '2 hours ago',
    '2 hours ago',
    '2 hours ago',
    '2 hours ago',
    '2 hours ago',
    '2 hours ago',
    '2 hours ago',
    '2 hours ago',
    '2 hours ago',
    '2 hours ago',
  ];

  List textList = [
    '@aleena123',
    '@aleena123',
    '@aleena123',
    '@aleena123',
    '@aleena123',
    '@aleena123',
    '@aleena123',
    '@aleena123',
    '@aleena123',
    '@aleena123',
    '@aleena123',
    '@aleena123',
    '@aleena123',
    '@aleena123',
    '@aleena123',
    '@aleena123',
    '@aleena123',
    '@aleena123',
  ];

  List acceptButtonList = [
    'ACCEPT',
    'ACCEPT',
    'ACCEPT',
    'ACCEPT',
    'ACCEPT',
    'ACCEPT',
    'ACCEPT',
    'ACCEPT',
    'ACCEPT',
    'ACCEPT',
    'ACCEPT',
    'ACCEPT',
    'ACCEPT',
    'ACCEPT',
    'ACCEPT',
    'ACCEPT',
    'ACCEPT',
    'ACCEPT',
  ];

  List rejectButtonList = [
    'REJECT',
    'REJECT',
    'REJECT',
    'REJECT',
    'REJECT',
    'REJECT',
    'REJECT',
    'REJECT',
    'REJECT',
    'REJECT',
    'REJECT',
    'REJECT',
    'REJECT',
    'REJECT',
    'REJECT',
    'REJECT',
    'REJECT',
    'REJECT',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
          return Column(
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
                title: Text(nameList[index]),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(textList[index]),
                    Text(timerList[index]),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 25,
                      width: 80,
                      child: Center(
                          child: Text(
                        acceptButtonList[index],
                        style: TextStyle(color: Colors.white),
                      )),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Container(
                        height: 25,
                        width: 80,
                        child: Center(
                            child: Text(
                          rejectButtonList[index],
                          style: TextStyle(color: Colors.white),
                        )),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15,),
            ],
          );
        }, childCount: imageList.length))
      ],
    ));
  }
}
