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

///
/// Team: NESP Technology
/// Author: <a href="mailto:1756404649@qq.com">JinZhaolu Email:1756404649@qq.com</a>
/// Time: Created 2021/7/31 10:46
/// Project: PasswordManagerFlutter
/// Description:
///

class Log {
  Log._();

  static const LEVEL_VERBOSE = 0;
  static const LEVEL_DEBUG = 1;
  static const LEVEL_INFO = 2;
  static const LEVEL_WARN = 3;
  static const LEVEL_ERROR = 4;

  static v(String tag, String msg) {
    printLog(LEVEL_VERBOSE, tag, msg);
  }

  static d(String tag, String msg) {
    printLog(LEVEL_DEBUG, tag, msg);
  }

  static i(String tag, String msg) {
    printLog(LEVEL_INFO, tag, msg);
  }

  static w(String tag, String msg) {
    printLog(LEVEL_WARN, tag, msg);
  }

  static e(String tag, String msg) {
    printLog(LEVEL_ERROR, tag, msg);
  }

  /// Print log to console
  static printLog(int level, String tag, String msg) {
    String levelTitle = _levelTitle(level);
    var dateTime = DateTime.now();
    String log = "${dateTime.year}-${dateTime.month}-${dateTime.day} "
        "${dateTime.hour}:${dateTime.minute}:"
        "${dateTime.second}.${dateTime.millisecond} $levelTitle/$tag: $msg";
    if (level == LEVEL_ERROR) {
      print('\x1B[31m$log\x1B[0m');
    } else if (level == LEVEL_WARN) {
      print('\x1B[33m$log\x1B[0m');
    } else {
      print(log);
    }
  }

  /// Return title is not empty.
  static String _levelTitle(int level) {
    String title = 'V';
    switch (level) {
      case LEVEL_VERBOSE:
        title = 'V';
        break;
      case LEVEL_DEBUG:
        title = 'D';
        break;
      case LEVEL_INFO:
        title = 'I';
        break;
      case LEVEL_WARN:
        title = 'W';
        break;
      case LEVEL_ERROR:
        title = 'E';
        break;
      default:
        throw ArgumentError('$level is not matched');
    }
    return title;
  }
}
