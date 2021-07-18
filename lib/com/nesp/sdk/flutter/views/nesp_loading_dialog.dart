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

showSuccessTip(BuildContext context,
    {String? text, bool isIosStyle = false,
      int liveMilliseconds = 2000}) {
  showAlertLoadingDialog(context, isIosStyle: isIosStyle,
      isCalledTip: true,
      isCallSuccess: true,
      successText: text,
      clickDismiss: true,
      liveMilliseconds: 1200);
}

showFailedTip(BuildContext context,
    {String? text, bool isIosStyle = false,
      int liveMilliseconds = 2000}) {
  showAlertLoadingDialog(context, isIosStyle: isIosStyle,
      isCalledTip: true,
      isCallSuccess: false,
      errorText: text,
      clickDismiss: true,
      liveMilliseconds: 1200);
}

showAlertLoadingDialog(BuildContext context,
    {String? text,
      bool? isCalledTip,
      bool? isCallSuccess,
      String? errorText,
      String? successText,
      bool isIosStyle = false,
      bool clickDismiss = false,
      int liveMilliseconds = 0}) {
  final loadingDialogBuilder = (context) {
    return alertLoadingDialogBuilder(
      context,
      text: text ?? "",
      isCalledTip: isCalledTip ?? false,
      isCheckSuccess: isCallSuccess ?? false,
      successText: successText ?? '',
      errorText: errorText ?? '',
      isIosStyle: isIosStyle,
      clickDismiss: clickDismiss,
    );
  };

  if (isIosStyle) {
    showCupertinoDialog(
        barrierDismissible: clickDismiss, context: context, builder:
    loadingDialogBuilder);
  } else {
    showDialog(
      context: context,
      builder: loadingDialogBuilder,
    );
  }

  if (liveMilliseconds > 0) {
    Future.delayed(Duration(milliseconds: liveMilliseconds))
        .then((value) => Navigator.pop(context));
  }
}

Widget alertLoadingDialogBuilder(BuildContext context, {
  String? text,
  String? errorText,
  String? successText,
  bool isIosStyle = false,
  bool clickDismiss = false,
  bool isCalledTip = false,
  bool isCheckSuccess = false,
}) {
  var dialogTheme = DialogTheme.of(context);

  _buildLoadingDialogContent() {
    Text? textContent;
    if (isCalledTip) {
      if (isCheckSuccess && successText != null && successText.isNotEmpty) {
        textContent = Text(
          successText,
          style: dialogTheme.contentTextStyle,
        );
      } else if (errorText != null && errorText.isNotEmpty) {
        textContent = Text(
          errorText,
          style: dialogTheme.contentTextStyle,
        );
      }
    } else if (text != null && text.isNotEmpty) {
      textContent = Text(
        text,
        style: dialogTheme.contentTextStyle,
      );
    }

    return Center(
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
                    size: textContent == null ? 60 : 45,
                    color: isCheckSuccess
                        ? Colors.black
                        : CupertinoColors.destructiveRed,
                  ))
                      : (isIosStyle
                      ? CupertinoActivityIndicator(
                    radius: 24,
                  )
                      : CircularProgressIndicator()),
                  new Padding(
                      padding: EdgeInsets.only(
                        top: textContent == null ? 0.0 : 18.0,
                      ),
                      child: textContent),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  return GestureDetector(
    onTap: () {
      clickDismiss ? Navigator.pop(context) : '';
    },
    child: isIosStyle
        ? _buildLoadingDialogContent()
        : Material(
      //创建透明层
      type: MaterialType.transparency, //透明类型
      child: _buildLoadingDialogContent(),
    ),
  );
}
