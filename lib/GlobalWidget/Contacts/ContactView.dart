import 'package:flutter/material.dart';
import 'package:rooya/Utils/primary_color.dart';
import '../SnackBarApp.dart';

class ContactView extends StatefulWidget {
  final String? result;

  const ContactView({Key? key, this.result}) : super(key: key);

  @override
  _ContactViewState createState() => _ContactViewState();
}

class _ContactViewState extends State<ContactView> {
  List listOfContacts = [];

  @override
  void initState() {
    listOfContacts = widget.result!.split(',');
    listOfContacts.remove('');
    print('${listOfContacts.length}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (listOfContacts.length == 1) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7), color: primaryColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${listOfContacts[0]}'.split('|')[0]),
            SizedBox(
              height: 5,
            ),
            InkWell(
              onTap: () {
                launchURL('tel:' + '${listOfContacts[0]}'.split('|')[1]);
              },
              child: Text(
                '${listOfContacts[0]}'.split('|')[1],
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7), color: primaryColor),
        child: Column(
          children: listOfContacts.map((e) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$e'.split('|')[0]),
                SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () {
                    launchURL('tel:' + '${listOfContacts[0]}'.split('|')[1]);
                  },
                  child: Text(
                    '$e'.split('|')[1],
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            );
          }).toList(),
        ),
      );
    }
  }
}
