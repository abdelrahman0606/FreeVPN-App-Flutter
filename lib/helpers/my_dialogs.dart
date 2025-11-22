import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDialogs {
  static success({required String msg}) {
    print('Success');
  }

  static error({required String msg}) {
    throw Exception(msg);
    Get.snackbar('Error', msg,
        colorText: Colors.white,
        backgroundColor: Colors.redAccent.withOpacity(.9));
  }

  static info({required String msg}) {
    Get.snackbar('Info', msg, colorText: Colors.white);
  }

  static showProgress() {
    Get.dialog(Center(child: CircularProgressIndicator(strokeWidth: 2)));
  }
}
