import 'package:flutter/material.dart';
import 'package:rooya/ApiConfig/SizeConfiq.dart';
import 'package:rooya/Utils/primary_color.dart';

class DocumentUserChat extends StatefulWidget {
  final bool? right;
  const DocumentUserChat({Key? key, this.right}) : super(key: key);

  @override
  _DocumentUserChatState createState() => _DocumentUserChatState();
}

class _DocumentUserChatState extends State<DocumentUserChat> {
  @override
  Widget build(BuildContext context) {
    if(widget.right!){
      return InkWell(
        child: Container(
          padding: EdgeInsets.all(5),
          width: width / 3,
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
              // Icon(
              //   Icons.file_copy_outlined,
              //   size: 40,
              //   color: primaryColor,
              // ),
              // SizedBox(
              //   height: 5,
              // ),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 10),
              //   child: Text(
              //     p
              //         .basename(
              //       '${getcontroller!.oneToOneChat[i].message!.message}',
              //     )
              //         .toString(),
              //     style: TextStyle(fontSize: 10),
              //     maxLines: 10,
              //     overflow: TextOverflow.ellipsis,
              //   ),
              // ),
              // SizedBox(
              //   height: 5,
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
          decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.black12,
              ),
              borderRadius: BorderRadius.circular(10)),
        ),
        onTap: () async {
          // String filePath = await saveAudioFile(url: '${getcontroller!.oneToOneChat[i].message!.message}', extension: extension, fileNName: p.basename('${getcontroller!.oneToOneChat[i].message!.message}'));
          // await OpenFile.open(filePath);
        },
      );
    }else{
      return  InkWell(
        child: Container(
          padding: EdgeInsets.all(5),
          width: width / 3,
          child: Column(
            children: [
              // Icon(
              //   Icons.file_copy_outlined,
              //   size: 40,
              //   color: primaryColor,
              // ),
              // SizedBox(
              //   height: 5,
              // ),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 10),
              //   child: Text(
              //     p.basename('${getcontroller!.oneToOneChat[i].message!.message}').toString(),
              //     style: TextStyle(fontSize: 10),
              //     maxLines: 10,
              //     overflow: TextOverflow.ellipsis,
              //   ),
              // ),
              // SizedBox(
              //   height: 5,
              // ),
              // Align(
              //   child: Row(
              //     children: [
              //       Text(
              //         '${sdf2.format(DateTime.parse("${getcontroller!.oneToOneChat[i].message!.iosDateTime}").toUtc().toLocal())}',
              //         style: TextStyle(
              //           color: Colors.black26,
              //           fontSize: 9.0,
              //         ),
              //       ),
              //       SizedBox(
              //         width: 3,
              //       ),
              //       getcontroller!.oneToOneChat[i].seen == null
              //           ? FaIcon(
              //         FontAwesomeIcons.checkDouble,
              //         size: 15,
              //         color: Colors.black12,
              //       )
              //           : FaIcon(
              //         FontAwesomeIcons.checkDouble,
              //         size: 15,
              //         color: Colors.blue,
              //       ),
              //     ],
              //     mainAxisAlignment: MainAxisAlignment.end,
              //   ),
              //   alignment: Alignment.centerRight,
              // ),
              // SizedBox(
              //   width: 3,
              // ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
          decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.black12,
              ),
              borderRadius: BorderRadius.circular(10)),
        ),
        onTap: () async {
          // String filePath = await saveAudioFile(url: '${getcontroller!.oneToOneChat[i].message!.message}', extension: extension, fileNName: p.basename('${getcontroller!.oneToOneChat[i].message!.message}'));
          // await OpenFile.open(filePath);
        },
      );
    }

  }
}
