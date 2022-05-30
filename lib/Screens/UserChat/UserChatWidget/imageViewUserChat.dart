import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rooya/ApiConfig/SizeConfiq.dart';
import 'package:rooya/GlobalWidget/Photo_View_Class.dart';

class ImageViewUserChat extends StatefulWidget {
  final bool? right;
  const ImageViewUserChat({Key? key, this.right}) : super(key: key);

  @override
  _ImageViewUserChatState createState() => _ImageViewUserChatState();
}

class _ImageViewUserChatState extends State<ImageViewUserChat> {
  @override
  Widget build(BuildContext context) {
    if(widget.right!){
      return InkWell(
        child: Container(
          height: height * 0.3,
          child: Stack(
            children: [
              // Column(
              //   children: [
              //     widget.fromGroup!
              //         ? Column(
              //             children: [
              //               Text(
              //                 // '${getcontroller!.oneToOneChat[i].sender!.firstName}' '${getcontroller!.oneToOneChat[i].sender!.lastName}',
              //                 '',
              //                 style: TextStyle(
              //                     color: Colors.deepPurple,
              //                     fontWeight: FontWeight.bold,
              //                     fontSize: 12),
              //               ),
              //               SizedBox(
              //                 height: height / 100,
              //               ),
              //             ],
              //           )
              //         : SizedBox(),
              //     Container(
              //       height: height * 0.3,
              //       child: ClipRRect(
              //         child: CachedNetworkImage(
              //           fit: BoxFit.cover,
              //           imageUrl: "",
              //           placeholder: (context, url) =>
              //               Center(child: CircularProgressIndicator()),
              //           errorWidget: (context, url, error) => Icon(Icons.error),
              //         ),
              //         borderRadius: BorderRadius.circular(8),
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
          // Get.to(Photo_View_Class(
          //   url: "${getcontroller!.oneToOneChat[i].message!.message}",
          // ));
        },
      );
    }else{
      return InkWell(
        child: Container(
          height: height * 0.3,
          child: Stack(
            children: [
              Container(
                height: height * 0.3,
                child: ClipRRect(
                  child: CachedNetworkImage(
                    imageUrl: "",
                    placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  borderRadius: BorderRadius.circular(8),
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
                      //     color: Colors.white,
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
          // Get.to(Photo_View_Class(
          //   url: "${getcontroller!.oneToOneChat[i].message!.message}",
          // ));
        },
      );
    }

  }
}
