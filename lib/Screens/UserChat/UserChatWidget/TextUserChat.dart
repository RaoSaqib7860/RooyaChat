import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rooya/ApiConfig/SizeConfiq.dart';
import 'package:rooya/Models/UserChatModel.dart';
import 'package:rooya/Screens/Information/UserChatInformation/user_chat_information.dart';
import 'package:rooya/Utils/UserDataService.dart';

import '../UserChat.dart';

class TextUserChat extends StatefulWidget {
  final Messages? model;
  final bool? fromGroup;
  const TextUserChat({Key? key, this.model, this.fromGroup}) : super(key: key);

  @override
  _TextUserChatState createState() => _TextUserChatState();
}

class _TextUserChatState extends State<TextUserChat> {
  @override
  Widget build(BuildContext context) {
    var date = DateTime.fromMillisecondsSinceEpoch(
        int.parse("${widget.model!.time}") * 1000);
    if (widget.model!.position != 'right') {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: CircularProfileAvatar(
              '',
              onTap: () {
                if (widget.model!.userData == null) {
                  Get.to(UserChatInformation(
                      userID: widget.model!.messageUser!.userId));
                } else {
                  Get.to(UserChatInformation(
                    userID: widget.model!.userData!.userId.toString(),
                  ));
                }
              },
              radius: 15,
              backgroundColor: Colors.blueGrey[100]!,
              child: CachedNetworkImage(
                imageUrl: widget.fromGroup!
                    ? widget.model!.userData == null
                        ? ''
                        : '${widget.model!.userData!.avatar}'
                    : '${widget.model!.messageUser!.avatar}',
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.person),
                fit: BoxFit.cover,
              ),
              imageFit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            padding: EdgeInsets.all(width / 30),
            decoration: BoxDecoration(
                color: Color(0xffF3F3F3),
                borderRadius: BorderRadius.circular(8)),
            child: Column(
              children: [
                // widget.fromGroup!
                //     ? Column(
                //         children: [
                //           Text(
                //             '${getcontroller!.oneToOneChat[i].sender!.firstName} ${getcontroller!.oneToOneChat[i].sender!.lastName}',
                //             style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold, fontSize: 12),
                //           ),
                //           SizedBox(
                //             height: height / 100,
                //           ),
                //         ],
                //       )
                //     : SizedBox(),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: width / 1.5),
                  child: Text(
                    '${widget.model!.text}',
                    //  decrypString(
                    //      encript: '${widget.model!.text}',
                    //      pass: widget.model!.time),
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 14),
                  ),
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
                        '${dateFormat.format(date)}',
                        style: TextStyle(
                          color: Colors.black26,
                          fontSize: 9.0,
                        ),
                      ),
                    ),
                  ],
                )
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ),
        ],
      );
    } else {
      return Container(
        padding: EdgeInsets.symmetric(
            vertical: height * 0.010, horizontal: width * 0.030),
        decoration: BoxDecoration(
            color: widget.model!.seen != '0'
                ? returnColorFromString(seenBackColor)
                : widget.model!.delivered != '0'
                    ? returnColorFromString(receiveBackColor)
                    : returnColorFromString(sentBackColor),
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            Text(
              '${widget.model!.text}',
              style: TextStyle(
                  color: widget.model!.seen != '0'
                      ? returnColorFromString(seenTextColor)
                      : widget.model!.delivered != '0'
                          ? returnColorFromString(receiveTextColor)
                          : returnColorFromString(sentTextColor),
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
                    '${dateFormat.format(date)}',
                    style: TextStyle(
                      color: widget.model!.seen != '0'
                          ? returnColorFromString(seenTimeColor)
                          : widget.model!.delivered != '0'
                              ? returnColorFromString(receiveTimeColor)
                              : returnColorFromString(sentTimeColor),
                      fontSize: 9.0,
                    ),
                  ),
                ),
                SizedBox(
                  width: 3,
                ),
                widget.model!.seen != '0'
                    ? FaIcon(
                        FontAwesomeIcons.checkDouble,
                        size: 15,
                        color: returnColorFromString(seenCheck),
                      )
                    : widget.model!.delivered != '0'
                        ? FaIcon(
                            FontAwesomeIcons.checkDouble,
                            size: 15,
                            color: returnColorFromString(receiveCheck),
                          )
                        : FaIcon(
                            FontAwesomeIcons.check,
                            size: 15,
                            color: returnColorFromString(sentCheck),
                          ),
              ],
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      );
    }
  }
}
