import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rooya/Screens/login_screens/sign_in_tabs_handle.dart';
import 'package:rooya/Utils/primary_color.dart';
import 'package:rooya/Utils/text_filed/app_font.dart';
import 'package:sizer/sizer.dart';


class PasswordChanged extends StatefulWidget {
  @override
  _PasswordChangedState createState() => _PasswordChangedState();
}

class _PasswordChangedState extends State<PasswordChanged> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(() => SignInTabsHandle());
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(
                CupertinoIcons.back,
                color: Colors.black,
              ),
              onPressed: () {
                Get.offAll(() => SignInTabsHandle());
              },
            ),
          ),
          body: Container(
            height: height,
            width: width,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.w, vertical: 5.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/user/logooo.png',fit: BoxFit.fill,
                    height: 8.0.h,
                  ),
                  SizedBox(
                    height: 5.0.h,
                  ),
                  Text(
                    'Password Changed',
                    style: TextStyle(
                      fontFamily: AppFonts.segoeui,
                      fontSize: 20,
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w600,
                      height: 1.25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Successfully!',
                    style: TextStyle(
                      fontFamily: AppFonts.segoeui,
                      fontSize: 20,
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w600,
                      height: 1.25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 5.0.h,
                  ),
                  Icon(
                    Icons.check_circle_outlined,
                    color: primaryColor,
                    size: 15.0.h,
                  ),
                  SizedBox(
                    height: 5.0.h,
                  ),
                  InkWell(
                    onTap: () {
                      Get.offAll(() => SignInTabsHandle());
                    },
                    child: Container(
                      width: 250.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color(0xff0bab0d),
                      ),
                      child: Center(
                        child: Text(
                          'CONTINUE',
                          style: TextStyle(
                            fontFamily: AppFonts.segoeui,
                            fontSize: 13,
                            color: const Color(0xffffffff),
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
