import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:rooya/ApiConfig/SizeConfiq.dart';

class ReplyUserChat extends StatefulWidget {
  final bool? right;
  const ReplyUserChat({Key? key, this.right}) : super(key: key);

  @override
  _ReplyUserChatState createState() => _ReplyUserChatState();
}

class _ReplyUserChatState extends State<ReplyUserChat> {
  @override
  Widget build(BuildContext context) {
    if(widget.right!){
      return Row(
        children: [
          // CircularProfileAvatar(
          //   '',
          //   radius: 15,
          //   child: CachedNetworkImage(
          //     imageUrl: '',
          //     placeholder: (context, url) => CircularProgressIndicator(),
          //     errorWidget: (context, url, error) => Icon(Icons.error),
          //     fit: BoxFit.cover,
          //   ),
          //   imageFit: BoxFit.cover,
          // ),
          // SizedBox(
          //   width: 5,
          // ),
          // Container(
          //   padding: EdgeInsets.symmetric(vertical: height * 0.010, horizontal: width * 0.015),
          //   decoration: BoxDecoration(color: getcontroller!.oneToOneChat[i].seen == null ? returnColorFromString(receiveBackColor) : returnColorFromString(seenBackColor), borderRadius: BorderRadius.circular(8)),
          //   child: Column(
          //     children: [
          //       Row(
          //         children: [
          //           Container(
          //             height: 40,
          //             width: 2,
          //             color: Colors.blue,
          //           ),
          //           Container(
          //             decoration: BoxDecoration(color: Colors.black12.withOpacity(0.1), borderRadius: BorderRadius.circular(5)),
          //             child: Row(
          //               children: [
          //                 Column(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     Text(
          //                       storage.read('userID') == getcontroller!.oneToOneChat[i].oldmessage!.oSender.toString() ? 'You' : '${getcontroller!.oneToOneChat[i].oldmessage!.oSenderName}',
          //                       style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.w700, fontSize: 14),
          //                     ),
          //                     Text(
          //                       '${getcontroller!.oneToOneChat[i].oldmessage!.oMessage}',
          //                       maxLines: 1,
          //                       overflow: TextOverflow.ellipsis,
          //                       style: TextStyle(color: Colors.black38, fontWeight: FontWeight.w400, fontSize: 12),
          //                     ),
          //                   ],
          //                 ),
          //               ],
          //             ),
          //             padding: EdgeInsets.symmetric(horizontal: height / 100, vertical: height / 100),
          //           ),
          //         ],
          //       ),
          //       SizedBox(
          //         height: height / 100,
          //       ),
          //       Text(
          //         '${getcontroller!.oneToOneChat[i].message!.message}',
          //         style: TextStyle(color: getcontroller!.oneToOneChat[i].seen == null ? returnColorFromString(receiveTextColor) : returnColorFromString(seenTextColor), fontWeight: FontWeight.w300, fontSize: 14),
          //       ),
          //       SizedBox(
          //         height: height / 100,
          //       ),
          //       Align(
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: <Widget>[
          //             SizedBox(),
          //             Padding(
          //               padding: EdgeInsets.only(left: width / 50),
          //               child: Text(
          //                 '${sdf2.format(DateTime.parse("${getcontroller!.oneToOneChat[i].message!.iosDateTime}").toUtc().toLocal())}',
          //                 style: TextStyle(
          //                   color: getcontroller!.oneToOneChat[i].seen == null ? returnColorFromString(receiveTimeColor) : returnColorFromString(seenTimeColor),
          //                   fontSize: 9.0,
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       )
          //     ],
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //   ),
          // )
        ],
      );
    }else{
     return Container(
        // padding: EdgeInsets.symmetric(vertical: height * 0.010, horizontal: width * 0.015),
        // decoration: BoxDecoration(color: getcontroller!.oneToOneChat[i].seen == null ? returnColorFromString(receiveBackColor) : returnColorFromString(seenBackColor), borderRadius: BorderRadius.circular(8)),
        // child: Column(
        //   children: [
        //     Row(
        //       children: [
        //         Container(
        //           height: 40,
        //           width: 2,
        //           color: Colors.blue,
        //         ),
        //         Container(
        //           decoration: BoxDecoration(color: Colors.black12.withOpacity(0.1), borderRadius: BorderRadius.circular(5)),
        //           child: Row(
        //             children: [
        //               Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   Builder(builder: (context) {
        //                     int oldNameIndex = getcontroller!.oneToOneChat.indexWhere((element) => getcontroller!.oneToOneChat[i].message!.replyMsgId.toString() == element.message!.mId.toString());
        //                     return Text(
        //                       storage.read('userID') == getcontroller!.oneToOneChat[oldNameIndex].sender!.userId.toString() ? 'You' : '${getcontroller!.oneToOneChat[oldNameIndex].sender!.firstName}' + ' ' + '${getcontroller!.oneToOneChat[oldNameIndex].sender!.lastName}',
        //                       style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.w700, fontSize: 14),
        //                     );
        //                   }),
        //                   Builder(builder: (context) {
        //                     int oldNameIndex = getcontroller!.oneToOneChat.indexWhere((element) => getcontroller!.oneToOneChat[i].message!.replyMsgId.toString() == element.message!.mId.toString());
        //                     return Text(
        //                       '${getcontroller!.oneToOneChat[oldNameIndex].message!.message}',
        //                       maxLines: 1,
        //                       overflow: TextOverflow.ellipsis,
        //                       style: TextStyle(color: Colors.black38, fontWeight: FontWeight.w400, fontSize: 12),
        //                     );
        //                   }),
        //                 ],
        //               ),
        //             ],
        //           ),
        //           padding: EdgeInsets.symmetric(horizontal: height / 100, vertical: height / 100),
        //         ),
        //       ],
        //     ),
        //     SizedBox(
        //       height: height / 100,
        //     ),
        //     Text(
        //       '${getcontroller!.oneToOneChat[i].message!.message}',
        //       style: TextStyle(color: getcontroller!.oneToOneChat[i].seen == null ? returnColorFromString(receiveTextColor) : returnColorFromString(seenTextColor), fontWeight: FontWeight.w300, fontSize: 14),
        //     ),
        //     SizedBox(
        //       height: height / 100,
        //     ),
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.end,
        //       children: <Widget>[
        //         Padding(
        //           padding: EdgeInsets.only(left: width / 50),
        //           child: Text(
        //             '${sdf2.format(DateTime.parse("${getcontroller!.oneToOneChat[i].message!.iosDateTime}").toUtc().toLocal())}',
        //             style: TextStyle(
        //               color: getcontroller!.oneToOneChat[i].seen == null ? returnColorFromString(receiveTimeColor) : returnColorFromString(seenTimeColor),
        //               fontSize: 9.0,
        //             ),
        //           ),
        //         ),
        //         SizedBox(
        //           width: 3,
        //         ),
        //         getcontroller!.oneToOneChat[i].seen != null
        //             ? FaIcon(
        //           FontAwesomeIcons.checkDouble,
        //           size: 15,
        //           color: returnColorFromString(seenCheck),
        //         )
        //             : getcontroller!.oneToOneChat[i].delivery != null
        //             ? FaIcon(
        //           FontAwesomeIcons.checkDouble,
        //           size: 15,
        //           color: returnColorFromString(receiveCheck),
        //         )
        //             : FaIcon(
        //           FontAwesomeIcons.check,
        //           size: 15,
        //           color: returnColorFromString(sentCheck),
        //         ),
        //       ],
        //     )
        //   ],
        //   crossAxisAlignment: CrossAxisAlignment.start,
        // ),
      );
    }
  }
}
