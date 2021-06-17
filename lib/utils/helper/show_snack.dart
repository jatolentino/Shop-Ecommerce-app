import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackMessage {
  SnackMessage._();
  static final SnackMessage _instance = SnackMessage._();
  static SnackMessage get instance => _instance;

  showSnack({@required message}) {
    ScaffoldMessenger.of(Get.context!)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
