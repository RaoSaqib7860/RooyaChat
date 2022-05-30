import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:dio/dio.dart' as dio;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rooya/ApiConfig/ApiUtils.dart';
import 'package:rooya/ApiConfig/SizeConfiq.dart';
import 'package:rooya/GlobalWidget/Contacts/GetAllContactsPage.dart';
import 'package:rooya/GlobalWidget/FileUploader.dart';
import 'package:rooya/GlobalWidget/MapsClass.dart';
import 'package:rooya/GlobalWidget/Photo_View_Class.dart';
import 'package:rooya/Utils/primary_color.dart';
import 'SearchUser.dart';

class NewUserChatPage extends StatefulWidget {
  final String? userID;
  final String? name;
  final String? profilePic;

  const NewUserChatPage({Key? key, this.userID, this.name, this.profilePic})
      : super(key: key);

  @override
  _NewUserChatPageState createState() => _NewUserChatPageState();
}

class _NewUserChatPageState extends State<NewUserChatPage> {
  TextEditingController controller = TextEditingController();
  String audio_path = '';

  @override
  void initState() {
    openSearch = true;
    super.initState();
  }

  @override
  void dispose() {
    openSearch = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: height,
          width: width,
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  CircularProfileAvatar(
                    '${widget.profilePic}',
                    borderColor: Colors.black26,
                    borderWidth: 0.5,
                    onTap: () {
                      Get.to(Photo_View_Class(
                        url: '${widget.profilePic}',
                      ));
                    },
                    radius: height / 40,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.name}',
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(child: SizedBox()),
              Container(
                height: height / 22,
                width: width,
                decoration: BoxDecoration(color: Colors.white),
                child: Row(
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Wrap(
                                children: [
                                  ListTile(
                                    leading: Icon(
                                      Icons.image,
                                      color: primaryColor,
                                    ),
                                    title: Text(
                                      'Photo & Video',
                                      style: TextStyle(
                                          fontSize: 16, letterSpacing: 0.5),
                                    ),
                                    onTap: () async {
                                      FilePickerResult? result =
                                          await FilePicker.platform.pickFiles(
                                        type: FileType.media,
                                      );
                                      if (result!.files.isNotEmpty) {
                                        print(
                                            'file path is = ${result.files[0].path}');
                                        sentMessageViaFile(
                                            filePath:
                                                '${result.files[0].path}');
                                        Navigator.of(context).pop();
                                      }
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(
                                      Icons.file_copy_outlined,
                                      color: primaryColor,
                                    ),
                                    title: Text(
                                      'Documents',
                                      style: TextStyle(
                                          fontSize: 16, letterSpacing: 0.5),
                                    ),
                                    onTap: () async {
                                      FilePickerResult? result =
                                          await FilePicker.platform.pickFiles(
                                        type: FileType.custom,
                                        allowedExtensions: ['pdf', 'doc'],
                                      );
                                      if (result!.files.isNotEmpty) {
                                        print(
                                            'file path is = ${result.files[0].path}');
                                        sentMessageViaFile(
                                            filePath:
                                                '${result.files[0].path}');
                                        Navigator.of(context).pop();
                                      }
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(
                                      Icons.location_on_outlined,
                                      color: primaryColor,
                                    ),
                                    title: Text(
                                      'Location',
                                      style: TextStyle(
                                          fontSize: 16, letterSpacing: 0.5),
                                    ),
                                    onTap: () {
                                      Get.to(MapClass())!.then((value) {
                                        if (value is String) {
                                          print('locatoin ia = $value');
                                          sentMesssageViaText(message: value);
                                        }
                                        Navigator.of(context).pop();
                                      });
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(
                                      Icons.person_outline,
                                      color: primaryColor,
                                    ),
                                    title: Text(
                                      'Contacts',
                                      style: TextStyle(
                                          fontSize: 16, letterSpacing: 0.5),
                                    ),
                                    onTap: () {
                                      Get.to(GetAllContactsPage())!
                                          .then((value) {
                                        if (value is String) {
                                          print('Contacts ia = $value');
                                          sentMesssageViaText(message: value);
                                        }
                                        Navigator.of(context).pop();
                                      });
                                    },
                                  ),
                                ],
                              );
                            });
                      },
                      child: Icon(
                        Icons.add,
                        size: 35,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        child: TextFormField(
                          controller: controller,
                          style: TextStyle(color: Colors.black, fontSize: 14),
                          decoration: InputDecoration(
                              disabledBorder: new OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: new BorderSide(
                                    color: Colors.black12,
                                  )),
                              focusedBorder: new OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: new BorderSide(
                                    color: Colors.black12,
                                  )),
                              enabledBorder: new OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: new BorderSide(
                                    color: Colors.black12,
                                  )),
                              border: new OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: new BorderSide(
                                    color: Colors.black12,
                                  )),
                              contentPadding: EdgeInsets.all(12),
                              hintText: '',
                              isDense: true,
                              hintStyle: TextStyle(
                                  fontSize: 11,
                                  letterSpacing: 0.5,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400)),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () async {
                        final ImagePicker _picker = ImagePicker();
                        var pickedFile = await _picker.getImage(
                          source: ImageSource.camera,
                        );
                        print('file path is = ${pickedFile!.path}');
                        if (pickedFile != null) {
                          sentMessageViaFile(filePath: '${pickedFile.path}');
                          Navigator.of(context).pop();
                        }
                      },
                      child: Icon(
                        Icons.camera_alt_outlined,
                        color: primaryColor,
                        size: 35,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        if (controller.text.trim().isNotEmpty) {
                          sentMesssageViaText(
                            message: controller.text,
                          );
                          controller.clear();
                        }
                      },
                      child: Container(
                        height: height / 18,
                        width: width / 10,
                        child: Center(
                          child: Icon(
                            Icons.send_outlined,
                            color: Colors.white,
                          ),
                        ),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: primaryColor),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  sentMessageViaFile({String? filePath}) async {
    // var file = File(filePath!);
    // String fileName = file.path.split('/').last;
    // Map<String, dynamic> data = {
    //   'memberId': storage.read('userID'),
    //   'file': await dio.MultipartFile.fromFile(
    //     '${file.path}',
    //     filename: '$fileName',
    //   )
    // };
    // sendFileMessage(data);
    String path = await uploadFile('$filePath');
    sentMesssageViaText(message: '$path');
  }

  sentMesssageViaText({String? message}) async {
    Map map = {'message': '$message', 'memberId[]': '${widget.userID}'};
    await ApiUtils.sendMessagepost(map: map);
  }
}
