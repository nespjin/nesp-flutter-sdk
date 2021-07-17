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

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SmartDrawer extends StatefulWidget {
  final double elevation;
  final Widget? child;
  final String? semanticLabel;
  final double widthPercent;

  ///add start
  final DrawerCallback? callback;

  ///add end
  const SmartDrawer({
    Key? key,
    this.elevation = 16.0,
    this.child,
    this.semanticLabel,
    this.widthPercent = 0.0,

    ///add start
    this.callback,

    ///add end
  })  : assert(widthPercent < 1.0 && widthPercent > 0.0),
        super(key: key);

  @override
  _SmartDrawerState createState() => _SmartDrawerState();
}

class _SmartDrawerState extends State<SmartDrawer> {
  @override
  void initState() {
    ///add start
    if (widget.callback != null) {
      widget.callback?.call(true);
    }

    ///add end
    super.initState();
  }

  @override
  void dispose() {
    ///add start
    if (widget.callback != null) {
      widget.callback?.call(false);
    }

    ///add end
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    String label = widget.semanticLabel ?? '';
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        label = widget.semanticLabel ?? '';
        break;
      case TargetPlatform.android:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
      case TargetPlatform.fuchsia:
        label = widget.semanticLabel ??
            (MaterialLocalizations.of(context).drawerLabel ?? '');
    }
    final double _width =
        MediaQuery.of(context).size.width * widget.widthPercent;
    return Semantics(
      scopesRoute: true,
      namesRoute: true,
      explicitChildNodes: true,
      label: label,
      child: ConstrainedBox(
        constraints: BoxConstraints.expand(width: _width),
        child: Material(
          elevation: widget.elevation,
          child: widget.child,
        ),
      ),
    );
  }
}
