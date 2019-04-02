/*
 * Copyright (c) 2019  NESP Technology Corporation. All rights reserved.
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms and conditions of the GNU General Public License,
 * version 2, as published by the Free Software Foundation.
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License.See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * If you have any questions or if you find a bug,
 * please contact the author by email or ask for Issues.
 *
 * Author:JinZhaolu <1756404649@qq.com>
 */

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
