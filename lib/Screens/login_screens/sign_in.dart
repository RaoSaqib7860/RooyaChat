import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rooya/ApiConfig/ApiUtils.dart';
import 'package:rooya/ApiConfig/BaseURL.dart';
import 'package:rooya/GlobalWidget/SnackBarApp.dart';
import 'package:rooya/Utils/primary_color.dart';
import 'package:rooya/Utils/text_filed/app_font.dart';
import 'package:rooya/Utils/text_filed/text.dart';
import 'package:sizer/sizer.dart';
import '../home_screen.dart';
import 'SignInController.dart';
import 'forgot_password.dart';

class SignIn extends StatefulWidget {
  Function? onSignUp;

  SignIn({Key? key, this.onSignUp}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  SignInController controller = Get.put(SignInController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Obx(
      () => Scaffold(
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.w),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.050,
                      ),
                      CustomTextFields(
                        controller: controller.mUserInfoController,
                        labelText: 'Email/Mobile Number',
                      ),
                      SizedBox(
                        height: 3.0.h,
                      ),
                      CustomTextFields(
                        controller: controller.mPasswordController,
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          onPressed: () {
                            if (controller.isPasswordShow.value) {
                              controller.isPasswordShow.value = false;
                            } else {
                              controller.isPasswordShow.value = true;
                            }
                          },
                          icon: Icon(
                            Icons.remove_red_eye,
                            color: controller.isPasswordShow.value
                                ? Colors.grey[500]
                                : primaryColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3.0.h,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            Get.to(() => ForgotPassword());
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontFamily: AppFonts.segoeui,
                              fontSize: 13,
                              color: const Color(0xfff93d3d),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3.0.h,
                      ),
                      InkWell(
                        onTap: () async {
                          if (controller.mUserInfoController.text.isNotEmpty) {
                            if (controller
                                .mPasswordController.text.isNotEmpty) {
                              print(
                                  'password=${controller.mPasswordController.text.trim().toString()}');
                              controller.isLoading.value = true;
                              bool value = await ApiUtils.getlogin(map: {
                                "username": controller.mUserInfoController.text
                                    .trim()
                                    .toString(),
                                "password": controller.mPasswordController.text
                                    .trim()
                                    .toString(),
                                "server_key": serverKey,
                                "device_type": "phone"
                              });
                              if (value) {
                                GetStorage storage = GetStorage();
                                await ApiUtils.getUserData(map: {
                                  "user_id": storage.read('userID'),
                                  "server_key": serverKey,
                                  "fetch": "user_data"
                                });
                                if (!storage.hasData('selectedTab')) {
                                  storage.write('selectedTab', '0');
                                  storage.write('seenTextColor', '255,0,0,0');
                                  storage.write(
                                      'receiveTextColor', '255,0,0,0');
                                  storage.write('sentTextColor', '255,0,0,0');

                                  storage.write('seenCheck', '255,33,150,243');
                                  storage.write('receiveCheck', '100,0,0,0');
                                  storage.write('sentCheck', '100,0,0,0');

                                  storage.write('seenTimeColor', '100,0,0,0');
                                  storage.write(
                                      'receiveTimeColor', '100,0,0,0');
                                  storage.write('sentTimeColor', '100,0,0,0');

                                  storage.write(
                                      'seenBackColor', '255,219,247,199');
                                  storage.write(
                                      'receiveBackColor', '255,219,247,199');
                                  storage.write(
                                      'sentBackColor', '255,219,247,199');
                                }
                                controller.isLoading.value = false;
                                Get.to(HomeScreen());
                              }
                            } else {
                              controller.isLoading.value = false;
                              snackBarFailer('Please enter password first');
                            }
                          } else {
                            controller.isLoading.value = false;
                            snackBarFailer(
                                'Please enter your email or phone first');
                          }
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
                              'LOG IN',
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
                      SizedBox(
                        height: 5.0.h,
                      ),
                      SizedBox(
                        width: 218.0,
                        child: Text.rich(
                          TextSpan(
                            style: TextStyle(
                              fontFamily: AppFonts.segoeui,
                              fontSize: 12,
                              color: const Color(0xff000000),
                            ),
                            children: [
                              TextSpan(
                                text: 'Do not have an Account?   ',
                              ),
                              TextSpan(
                                recognizer: new TapGestureRecognizer()
                                  ..onTap = () {
                                    widget.onSignUp!;
                                  },
                                text: 'Sign up',
                                style: TextStyle(
                                  color: const Color(0xff0bab0d),
                                  fontWeight: FontWeight.w700,
                                  fontFamily: AppFonts.segoeui,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 3.0.h,
                      ),
                      // Row(
                      //   mainAxisSize: MainAxisSize.min,
                      //   children: [
                      //     Text(
                      //       'or join with',
                      //       style: TextStyle(
                      //         fontFamily: AppFonts.segoeui,
                      //         fontSize: 16,
                      //         fontWeight: FontWeight.bold,
                      //         color: const Color(0xff000000),
                      //       ),
                      //       textAlign: TextAlign.left,
                      //     ),
                      //     SizedBox(
                      //       width: 5.0.w,
                      //     ),
                      //     SvgPicture.asset('assets/fb.svg'),
                      //     SizedBox(
                      //       width: 5.0.w,
                      //     ),
                      //     SvgPicture.asset('assets/google.svg'),
                      //   ],
                      // )
                    ],
                  ),
                ),
              ),
            ),
            Obx(() => controller.isLoading.value == true
                ? InkWell(
                    onTap: () {
                      controller.isLoading.value = false;
                    },
                    child: Container(
                      height: height,
                      width: width,
                      child: Center(
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          size: 50.0,
                        ),
                      ),
                      decoration:
                          BoxDecoration(color: Colors.black.withOpacity(0.5)),
                    ),
                  )
                : SizedBox())
          ],
        ),
      ),
    );
  }
}
