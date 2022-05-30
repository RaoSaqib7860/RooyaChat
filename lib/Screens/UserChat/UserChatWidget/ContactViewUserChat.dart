import 'package:flutter/material.dart';
import 'package:rooya/GlobalWidget/Contacts/ContactView.dart';

class ContactViewChat extends StatefulWidget {
  final bool? right;
  const ContactViewChat({Key? key, this.right=true}) : super(key: key);

  @override
  _ContactViewChatState createState() => _ContactViewChatState();
}

class _ContactViewChatState extends State<ContactViewChat> {
  @override
  Widget build(BuildContext context) {
    if(widget.right!){
      return Builder(builder: (context) {
        // List list =
        //     '${getcontroller!.oneToOneChat[i].message!.message}'.split(':');
        List list=[];
        return ContactView(
          result: list[1],
        );
      });
    }else{
      return Builder(builder:
          (context) {
       // List list = '${getcontroller!.oneToOneChat[i].message!.message}'.split(':');
            List list=[];
        return ContactView(
          result: list[1],
        );
      });
    }
  }
}
