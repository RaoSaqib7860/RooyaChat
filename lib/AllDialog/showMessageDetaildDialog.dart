import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rooya/ApiConfig/SizeConfiq.dart';
import 'package:rooya/Models/UserChatModel.dart';
import 'package:rooya/Utils/UserDataService.dart';

showMessageDetailedDialog({BuildContext? context, Messages? model}) {
  var seen;
  if (model!.seen != '0') {
    seen =
        DateTime.fromMillisecondsSinceEpoch(int.parse("${model.seen}") * 1000);
  }
  var delivered;
  if (model.delivered != '0') {
    delivered = DateTime.fromMillisecondsSinceEpoch(
        int.parse("${model.delivered}") * 1000);
  }
  var sent =
      DateTime.fromMillisecondsSinceEpoch(int.parse("${model.time}") * 1000);

  showDialog(
    context: context!,
    builder: (_) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      //this right here
      child: Container(
        height: 150.0,
        width: 300.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 30,
                    ),
                    FaIcon(
                      FontAwesomeIcons.check,
                      size: 15,
                      color: Colors.black38,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Sent',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: width / 50, right: 30),
                  child: Text(
                    '${dateFormat.format(sent)}',
                    style: TextStyle(
                      color: Colors.black38,
                      fontSize: 13.0,
                    ),
                  ),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 30,
                    ),
                    FaIcon(
                      FontAwesomeIcons.checkDouble,
                      size: 15,
                      color: Colors.black38,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Delivered',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: width / 50, right: 30),
                  child: model.delivered == '0'
                      ? Icon(Icons.access_time_rounded)
                      : Text(
                          '${dateFormat.format(delivered)}',
                          style: TextStyle(
                            color: Colors.black38,
                            fontSize: 13.0,
                          ),
                        ),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 30,
                    ),
                    FaIcon(
                      FontAwesomeIcons.checkDouble,
                      size: 15,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Seen',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: width / 50, right: 30),
                  child: model.seen == '0'
                      ? Icon(Icons.access_time_rounded)
                      : Text(
                          '${dateFormat.format(seen)}',
                          style: TextStyle(
                            color: Colors.black38,
                            fontSize: 13.0,
                          ),
                        ),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            )
          ],
        ),
      ),
    ),
  );
}
