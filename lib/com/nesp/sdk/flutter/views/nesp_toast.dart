import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NespToast {
  static showShortToast(String message) {
    _showCommonToast(message, Toast.LENGTH_SHORT);
  }

  static showLongToast(String message) {
    _showCommonToast(message, Toast.LENGTH_LONG);
  }

  static _showCommonToast(
    String message,
    Toast toastLength,
  ) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: toastLength,
        timeInSecForIos: toastLength == Toast.LENGTH_SHORT ? 1 : 2,
        fontSize: 16,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey,
        textColor: Colors.white);
  }
}
