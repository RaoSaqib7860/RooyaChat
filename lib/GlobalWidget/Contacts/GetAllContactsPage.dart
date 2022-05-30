import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rooya/ApiConfig/SizeConfiq.dart';
import 'package:rooya/Utils/primary_color.dart';

class GetAllContactsPage extends StatefulWidget {
  const GetAllContactsPage({Key? key}) : super(key: key);

  @override
  _GetAllContactsPageState createState() => _GetAllContactsPageState();
}

class _GetAllContactsPageState extends State<GetAllContactsPage> {
  var listOfContacts = <Contact>[].obs;
  var listOfSelectedContacts = <Contact>[].obs;

  @override
  void initState() {
    getAllContacts();
    super.initState();
  }

  getAllContacts() async {
    listOfContacts.value = await ContactsService.getContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text('Share Contacts'),
        backgroundColor: buttonColor,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          String object = '';
          listOfSelectedContacts.forEach((element) {
            object = object +
                '${element.displayName}|${element.phones![0].value},'.trim();
          });
          print('Contacts#=-:$object');
          Get.back(result: 'Contacts#=-:$object');
        },
        backgroundColor: buttonColor,
        child: Icon(Icons.done),
      ),
      body: Column(
        children: [
          Obx(
            () => listOfSelectedContacts.isEmpty
                ? SizedBox()
                : Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: height * 0.070,
                        width: width,
                        padding: EdgeInsets.only(left: 10),
                        child: ListView.builder(
                          itemBuilder: (c, i) {
                            return Container(
                              height: height * 0.070,
                              width: width * 0.165,
                              child: Stack(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    child: listOfSelectedContacts[i].avatar ==
                                                null ||
                                            listOfSelectedContacts[i]
                                                .avatar!
                                                .isEmpty
                                        ? CircularProfileAvatar(
                                            '',
                                            child: Center(
                                                child:
                                                    '${listOfSelectedContacts[i].initials()}'
                                                            .trim()
                                                            .isEmpty
                                                        ? Icon(
                                                            Icons
                                                                .person_outline,
                                                            size: 30,
                                                          )
                                                        : Text(
                                                            '${listOfSelectedContacts[i].initials()}',
                                                            style: TextStyle(
                                                                fontSize: 20),
                                                          )),
                                            borderColor: Colors.black26,
                                            borderWidth: 0.5,
                                            radius: 25,
                                          )
                                        : CircularProfileAvatar(
                                            '',
                                            child: Image.memory(
                                                listOfSelectedContacts[i]
                                                    .avatar!),
                                            borderColor: Colors.black26,
                                            borderWidth: 0.5,
                                            radius: 25,
                                          ),
                                  ),
                                  Align(
                                    child: InkWell(
                                      child: Icon(
                                        Icons.cancel,
                                        size: 20,
                                        color: buttonColor,
                                      ),
                                      onTap: () {
                                        listOfSelectedContacts.removeAt(i);
                                        setState(() {});
                                      },
                                    ),
                                    alignment: Alignment.bottomRight,
                                  )
                                ],
                              ),
                            );
                          },
                          itemCount: listOfSelectedContacts.length,
                          scrollDirection: Axis.horizontal,
                        ),
                      )
                    ],
                  ),
          ),
          SizedBox(
            height: 10,
          ),
          Obx(
            () => Expanded(
                child: listOfContacts.isEmpty
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemBuilder: (c, i) {
                          return InkWell(
                            onTap: () {
                              if (!listOfSelectedContacts
                                  .contains(listOfContacts[i])) {
                                listOfSelectedContacts.add(listOfContacts[i]);
                              }
                              setState(() {});
                            },
                            child: Row(
                              children: [
                                listOfSelectedContacts
                                        .contains(listOfContacts[i])
                                    ? Row(
                                        children: [
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(1),
                                            child: Icon(
                                              Icons.done,
                                              size: 13,
                                              color: Colors.white,
                                            ),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: buttonColor),
                                          ),
                                        ],
                                      )
                                    : SizedBox(),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.symmetric(vertical: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.blueGrey[50]!
                                            .withOpacity(0.5)),
                                    child: listOfContacts[i].phones!.isEmpty
                                        ? ListTile(
                                            leading: CircularProfileAvatar(
                                              '',
                                              child: Icon(
                                                Icons.person_outline,
                                                size: 30,
                                              ),
                                              borderColor: Colors.black26,
                                              borderWidth: 0.5,
                                              radius: 25,
                                            ),
                                            title: Text(
                                              '${listOfContacts[i].displayName}',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          )
                                        : ListTile(
                                            leading: listOfContacts[i].avatar ==
                                                        null ||
                                                    listOfContacts[i]
                                                        .avatar!
                                                        .isEmpty
                                                ? CircularProfileAvatar(
                                                    '',
                                                    child: Center(
                                                        child:
                                                            '${listOfContacts[i].initials()}'
                                                                    .trim()
                                                                    .isEmpty
                                                                ? Icon(
                                                                    Icons
                                                                        .person_outline,
                                                                    size: 30,
                                                                  )
                                                                : Text(
                                                                    '${listOfContacts[i].initials()}',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            20),
                                                                  )),
                                                    borderColor: Colors.black26,
                                                    borderWidth: 0.5,
                                                    radius: 25,
                                                  )
                                                : CircularProfileAvatar(
                                                    '',
                                                    child: Image.memory(
                                                        listOfContacts[i]
                                                            .avatar!),
                                                    borderColor: Colors.black26,
                                                    borderWidth: 0.5,
                                                    radius: 25,
                                                  ),
                                            title: Text(
                                              '${listOfContacts[i].displayName}',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                            subtitle: Text(
                                              '${listOfContacts[i].phones![0].value}',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount: listOfContacts.length,
                      )),
          )
        ],
      ),
    );
  }
}
