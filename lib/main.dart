import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:socket_io/socket_io.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import 'Screens/home_screen.dart';
import 'Screens/login_screens/sign_in_tabs_handle.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = new MyHttpOverrides();
  var io = new Server();
  var nsp = io.of('/some');
  nsp.on('connection', (client) {
    print('connection /some');
    client.on('msg', (data) {
      print('data from /some => $data');
      client.emit('fromServer', "ok 2");
    });
  });
  io.on('connection', (client) {
    print('connection default namespace');
    client.on('msg', (data) {
      print('data from default => $data');
      client.emit('fromServer', "ok");
    });
  });
  io.listen(4499);
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  GetStorage storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        title: 'Mersaal',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: SignInTabsHandle(),
        home: storage.read('token') != null ? HomeScreen() : SignInTabsHandle(),
        debugShowCheckedModeBanner: false,
        transitionDuration:Duration(seconds: 0),
        defaultGlobalState: false,
      );
    });
  }
}
