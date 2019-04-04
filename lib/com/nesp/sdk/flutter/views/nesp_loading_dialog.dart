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
part of views;

///
///
/// @team NESP Technology
/// @author <a href="mailto:1756404649@qq.com">靳兆鲁 Email:1756404649@qq.com</a>
/// @time: Created 19-4-3 上午2:00
/// @project fish_movie
///*/
///

showAlertLoadingDialog(
  BuildContext context, {
  String text,
  bool isCalledTip,
  bool isCallSuccess,
  String errorText,
  String successText,
  bool isIosStyle = false,
  bool clickDismiss = false,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertLoadingDialogBuilder(
        context,
        text: text,
        isIosStyle: isIosStyle,
        clickDismiss: clickDismiss,
      );
    },
  );
}

Widget AlertLoadingDialogBuilder(
  BuildContext context, {
  String text,
  String errorText,
  String successText,
  bool isIosStyle = false,
  bool clickDismiss = false,
  bool isCalledTip = false,
  bool isCheckSuccess = false,
}) {
  var dialogTheme = DialogTheme.of(context);

  return GestureDetector(
    onTap: () {
      clickDismiss ? Navigator.pop(context) : '';
    },
    child: Material(
      //创建透明层
      type: MaterialType.transparency, //透明类型
      child: new Center(
        //保证控件居中效果
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new SizedBox(
              width: 120.0,
              height: 120.0,
              child: new Container(
                decoration: ShapeDecoration(
                  color: isIosStyle ? Colors.white54 : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                ),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    isCalledTip
                        ? (Icon(
                            isCheckSuccess
                                ? NespIcons.check_right
                                : NespIcons.check_failed,
                            size: 45,
                          ))
                        : (isIosStyle
                            ? CupertinoActivityIndicator(
                                radius: 15,
                              )
                            : CircularProgressIndicator()),
                    new Padding(
                        padding: const EdgeInsets.only(
                          top: 20.0,
                        ),
                        child: isCalledTip
                            ? (isCheckSuccess
                                ? ((successText == null || successText.isEmpty)
                                    ? null
                                    : Text(
                                        successText,
                                        style: dialogTheme.contentTextStyle,
                                      ))
                                : ((errorText == null || errorText.isEmpty)
                                    ? null
                                    : Text(
                                        errorText,
                                        style: dialogTheme.contentTextStyle,
                                      )))
                            : Text(
                                text,
                                style: dialogTheme.contentTextStyle,
                              )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
