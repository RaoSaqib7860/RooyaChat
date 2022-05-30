import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore_for_file: file_names, unused_field, avoid_unnecessary_containers, prefer_const_constructors, unused_local_variable, prefer_const_literals_to_create_immutables, unnecessary_new, sized_box_for_whitespace, prefer_const_constructors_in_immutables
StreamController<double> streamController = StreamController<double>();
class SelectIndexController extends GetxController {
  List listofBool = [true, false, false, false, false].obs;

  updateColor(int index) {
    for (var i = 0; i < listofBool.length; i++) {
      listofBool[i] = false;
    }
    listofBool[index] = true;
  }

  observeronSearch() {
    debounce(search, (value) {
      print('search value is =$value');
      searchValue.value=value.toString();
      streamController.add(0.1);
    }, time: Duration(milliseconds: 200));
  }
  var searchValue=''.obs;
  var search = ''.obs;
}
