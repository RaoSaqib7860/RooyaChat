import 'package:flutter/material.dart';
import 'package:rooya/ApiConfig/SizeConfiq.dart';

class VideoUserChat extends StatefulWidget {
  final bool? right;
  const VideoUserChat({Key? key, this.right}) : super(key: key);

  @override
  _VideoUserChatState createState() => _VideoUserChatState();
}

class _VideoUserChatState extends State<VideoUserChat> {
  @override
  Widget build(BuildContext context) {
    if(widget.right!){
      return InkWell(
        child: Container(
          width: width / 1.7,
          height: height * 0.3,
          child: Stack(
            children: [
              // Column(
              //   children: [
              //     widget.fromGroup!
              //         ? Column(
              //       children: [
              //         Text(
              //           '${getcontroller!.oneToOneChat[i].sender!.firstName}' '${getcontroller!.oneToOneChat[i].sender!.lastName}',
              //           style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold, fontSize: 12),
              //         ),
              //         SizedBox(
              //           height: height / 100,
              //         ),
              //       ],
              //     )
              //         : SizedBox(),
              //     Container(
              //       width: width / 1.7,
              //       height: height * 0.3,
              //       decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(5)),
              //       child: Center(
              //         child: Icon(
              //           Icons.play_circle_fill,
              //           size: 40,
              //           color: Colors.white,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              // Align(
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Text(
              //       '${sdf2.format(DateTime.parse("${getcontroller!.oneToOneChat[i].message!.iosDateTime}").toUtc().toLocal())}',
              //       style: TextStyle(
              //         color: Colors.white60,
              //         fontSize: 9.0,
              //       ),
              //     ),
              //   ),
              //   alignment: Alignment.bottomRight,
              // ),
            ],
          ),
        ),
        onTap: () {
          // Get.to(CustomVideoPlayer(
          //   url: getcontroller!.oneToOneChat[i].message!.message,
          // ));

          // Get.to(
          //     VideoApp(
          //   assetsPath:
          //       '${getcontroller!.oneToOneChat[i].message!.message}',
          // ));
        },
      );
    }else{
      return InkWell(
        child: Container(
          width: width / 1.7,
          height: height * 0.3,
          decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(5)),
          child: Stack(
            children: [
              Center(
                child: Icon(
                  Icons.play_circle_fill,
                  size: 40,
                  color: Colors.white,
                ),
              ),
              Align(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Text(
                      //   '${sdf2.format(DateTime.parse("${getcontroller!.oneToOneChat[i].message!.iosDateTime}").toUtc().toLocal())}',
                      //   style: TextStyle(
                      //     color: Colors.white60,
                      //     fontSize: 9.0,
                      //   ),
                      // ),
                      // SizedBox(
                      //   width: 3,
                      // ),
                      // getcontroller!.oneToOneChat[i].seen == null
                      //     ? FaIcon(
                      //   FontAwesomeIcons.checkDouble,
                      //   size: 15,
                      //   color: Colors.black12,
                      // )
                      //     : FaIcon(
                      //   FontAwesomeIcons.checkDouble,
                      //   size: 15,
                      //   color: Colors.blue,
                      // ),
                    ],
                  ),
                ),
                alignment: Alignment.bottomRight,
              ),
            ],
          ),
        ),
        onTap: () {
          // Get.to(CustomVideoPlayer(
          //   url: getcontroller!.oneToOneChat[i].message!.message,
          // ));
          // Get.to(
          //     VideoApp(
          //   assetsPath:
          //       '${getcontroller!.oneToOneChat[i].message!.message}',
          // ));
        },
      );
    }
  }
}
