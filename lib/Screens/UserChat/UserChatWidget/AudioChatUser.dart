import 'package:flutter/material.dart';
import 'package:rooya/ApiConfig/SizeConfiq.dart';

class AudioChatUser extends StatefulWidget {
  final bool? right;
  const AudioChatUser({Key? key, this.right}) : super(key: key);

  @override
  _AudioChatUserState createState() => _AudioChatUserState();
}

class _AudioChatUserState extends State<AudioChatUser> {
  @override
  Widget build(BuildContext context) {
    if(widget.right!){
      return Container(
        height: height * 0.1,
        width: width / 1.7,
        child: Column(
          children: [
            // widget.fromGroup!
            //     ? Column(
            //   children: [
            //     Text(
            //       '${getcontroller!.oneToOneChat[i].sender!.firstName}' '${getcontroller!.oneToOneChat[i].sender!.lastName}',
            //       style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold, fontSize: 12),
            //     ),
            //     SizedBox(
            //       height: height / 100,
            //     ),
            //   ],
            // )
            //     : SizedBox(),
            // Container(
            //   height: height * 0.080,
            //   width: width / 1.7,
            //   child: CustomAudioPlayer(
            //     url: getcontroller!.oneToOneChat[i].message!.message,
            //   ),
            // ),
            // Align(
            //   child: Text(
            //     '${sdf2.format(DateTime.parse("${getcontroller!.oneToOneChat[i].message!.iosDateTime}").toUtc().toLocal())}',
            //     style: TextStyle(
            //       color: Colors.black26,
            //       fontSize: 9.0,
            //     ),
            //   ),
            //   alignment: Alignment.centerRight,
            // ),
          ],
        ),
      );
    }else{
      return Container(
        height: height * 0.1,
        width: width / 1.7,
        child: Stack(
          children: [
            // Container(
            //   height: height * 0.080,
            //   width: width / 1.7,
            //   child: CustomAudioPlayer(
            //     url: getcontroller!.oneToOneChat[i].message!.message,
            //   ),
            // ),
            // Align(
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.end,
            //       children: [
            //         Text(
            //           '${sdf2.format(DateTime.parse("${getcontroller!.oneToOneChat[i].message!.iosDateTime}").toUtc().toLocal())}',
            //           style: TextStyle(
            //             color: Colors.black26,
            //             fontSize: 9.0,
            //           ),
            //         ),
            //         SizedBox(
            //           width: 3,
            //         ),
            //         getcontroller!.oneToOneChat[i].seen == null
            //             ? FaIcon(
            //           FontAwesomeIcons.checkDouble,
            //           size: 15,
            //           color: Colors.black12,
            //         )
            //             : FaIcon(
            //           FontAwesomeIcons.checkDouble,
            //           size: 15,
            //           color: Colors.blue,
            //         ),
            //       ],
            //     ),
            //   ),
            //   alignment: Alignment.bottomRight,
            // ),
            // SizedBox(
            //   width: 3,
            // ),
          ],
        ),
      );
    }
  }
}
