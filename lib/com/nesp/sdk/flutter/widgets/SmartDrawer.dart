import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class SmartDrawer extends StatelessWidget {
  final double elevation;
  final Widget child;
  final String semanticLabel;

  ///new start
  final double widthPercent;

  ///new end
  const SmartDrawer({
    Key key,
    this.elevation = 16.0,
    this.child,
    this.semanticLabel,

    ///new start
    this.widthPercent = 0.7,

    ///new end
  })  :

  ///new start
        assert(widthPercent != null && widthPercent < 1.0 && widthPercent > 0.0)

  ///new end
  ,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    String label = semanticLabel;
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        label = semanticLabel;
        break;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        label = semanticLabel ?? MaterialLocalizations.of(context)?.drawerLabel;
    }

    ///new start
    final double _width = MediaQuery.of(context).size.width * widthPercent;

    ///new end
    return Semantics(
      scopesRoute: true,
      namesRoute: true,
      explicitChildNodes: true,
      label: label,
      child: ConstrainedBox(
        ///edit start
        constraints: BoxConstraints.expand(width: _width),

        ///edit end
        child: Material(
          elevation: elevation,
          child: child,
        ),
      ),
    );
  }
}
