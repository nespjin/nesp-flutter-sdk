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
/// @time: Created 19-4-3 下午10:27
/// @project fish_movie
///*/

///

typedef OnSingleSelectDialogSelect = Function(int index);
typedef SingleSelectDialogDefaultValue = Future<int> Function();

int _singleSelectDialogGroupValue = 1;

String _singleSelectDialogTitle = '';
String _singleSelectDialogOk = '';
String _singleSelectDialogCancel = '';

List<SingleSelectDialogDataItem> _singleSelectDialogData = const [];
Function? _onSingleSelectDialogSelect;
Function? _onSingleSelectDialogOkPress;
Function? _onSingleSelectDialogCancelPress;
SingleSelectDialogDefaultValue? _singleSelectDialogDefaultValue;

showNsSingleSelectDialog(
  BuildContext context, {
  final String singleSelectDialogTitle = '',
  final String singleSelectDialogOk = '',
  final String singleSelectDialogCancel = '',
  final SingleSelectDialogDefaultValue? singleSelectDialogDefaultValue,
  final OnSingleSelectDialogSelect? onSingleSelectDialogSelect,
  final Function? onSingleSelectDialogOkPress,
  final Function? onSingleSelectDialogCancelPress,
  final List<SingleSelectDialogDataItem> singleSelectDialogData = const [],
}) {
  _singleSelectDialogTitle = singleSelectDialogTitle;
  _singleSelectDialogOk = singleSelectDialogOk;
  _singleSelectDialogCancel = singleSelectDialogCancel;
  _singleSelectDialogDefaultValue = singleSelectDialogDefaultValue;
  _onSingleSelectDialogSelect = onSingleSelectDialogSelect;
  _onSingleSelectDialogOkPress = onSingleSelectDialogOkPress;
  _onSingleSelectDialogCancelPress = onSingleSelectDialogCancelPress;
  _singleSelectDialogData = singleSelectDialogData;

  showDialog(
    context: context,
    builder: (context) {
      return _SingleSelectDialog();
    },
  );
}

class _SingleSelectDialog extends StatefulWidget {
  const _SingleSelectDialog({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SingleSelectDialogState();
  }
}

class _SingleSelectDialogState extends State<_SingleSelectDialog> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _singleSelectDialogDefaultValue?.call().then((defaultValue) {
      setState(() {
//        if (_singleSelectDialogGroupValue != null) return;
        _singleSelectDialogGroupValue = defaultValue;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
      actions: <Widget>[
        TextButton(
          child: Text(_singleSelectDialogCancel),
          onPressed: () {
            Navigator.pop(context);
            _onSingleSelectDialogCancelPress?.call();
          },
        ),
        TextButton(
          child: Text(_singleSelectDialogOk),
          onPressed: () {
            Navigator.pop(context);
            _onSingleSelectDialogOkPress?.call();
          },
        ),
      ],
      title: Text(_singleSelectDialogTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: _singleSelectDialogData.map((menuItem) {
          return Container(
            child: RadioListTile(
                title: menuItem.child == null
                    ? Text(
                        menuItem.name,
                        style: TextStyle(fontSize: 20),
                      )
                    : menuItem.child,
                value: menuItem.id,
                groupValue: _singleSelectDialogGroupValue,
                onChanged: (bool) {
                  setState(() {
                    _singleSelectDialogGroupValue = menuItem.id;
                    _onSingleSelectDialogSelect?.call(menuItem.id);
                  });
                }),
          );
        }).toList(),
      ),
    );
  }
}

class ColorChooseItem extends StatelessWidget {
  final Color color;
  final String title;

  const ColorChooseItem({Key? key, this.color = Colors.grey, this.title = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Text(title),
        Padding(
          padding: EdgeInsets.only(left: 50),
          child: CircleAvatar(
            backgroundColor: color,
          ),
        )
      ],
    );
  }
}

class SingleSelectDialogDataItem {
  final String name;
  final int id;
  final Widget? child;

  SingleSelectDialogDataItem({this.id = 0, this.name = '', this.child});
}
