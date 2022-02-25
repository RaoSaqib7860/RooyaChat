import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rooya/Home/home_screen.dart';
import 'package:rooya/login_screens/sign_in.dart';
import 'package:rooya/login_screens/sign_up.dart';
import 'package:sizer/sizer.dart';

class SignInTabsHandle extends StatefulWidget {
  @override
  _SignInTabsHandleState createState() => _SignInTabsHandleState();
}

class _SignInTabsHandleState extends State<SignInTabsHandle>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2);
    getPermission();
  }

  getPermission() async {
    await [
      Permission.location,
      Permission.storage,
      Permission.camera,
      Permission.contacts,
      Permission.manageExternalStorage,
      Permission.photos,
      Permission.mediaLibrary,
      Permission.accessMediaLocation,
    ].request();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: Column(
            children: [
              SizedBox(
                height: height * 0.030,
              ),
              Image.asset(
                'assets/user/logooo.png',
                fit: BoxFit.fill,
                height: 7.0.h,
              ),
              SizedBox(
                height: height * 0.010,
              ),
              TabBar(
                controller: _tabController,
                tabs: [
                  Tab(
                    text: 'Login',
                  ),
                  Tab(
                    text: 'Sign Up',
                  )
                ],
                indicator: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(color: Colors.green, width: 3),
                    )),
                indicatorColor: Colors.green,
                indicatorPadding: EdgeInsets.only(top: 2),
                labelColor: Colors.black,
                labelStyle:
                    TextStyle(fontSize: 14.0.sp, fontWeight: FontWeight.bold),
                unselectedLabelColor: Colors.grey,
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    SignIn(
                      onSignUp: () {
                        _tabController!.animateTo(1);
                      },
                    ),
                    SignUp(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
