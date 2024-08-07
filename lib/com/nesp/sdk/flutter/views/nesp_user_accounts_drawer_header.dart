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

class _AccountPictures extends StatelessWidget {
  const _AccountPictures({
    Key? key,
    this.currentAccountPicture,
    this.otherAccountsPictures = const [],
  }) : super(key: key);

  final Widget? currentAccountPicture;
  final List<Widget> otherAccountsPictures;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        PositionedDirectional(
          top: 0.0,
          end: 0.0,
          child: Row(
            children: (otherAccountsPictures)
                .take(3)
                .map<Widget>((Widget picture) {
              return Padding(
                  padding: const EdgeInsetsDirectional.only(start: 8.0),
                  child: Semantics(
                    container: true,
                    child: Container(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                      width: 48.0,
                      height: 48.0,
                      child: picture,
                    ),
                  ));
            }).toList(),
          ),
        ),
        Positioned(
          top: 0.0,
          child: Semantics(
            explicitChildNodes: true,
            child: SizedBox(
                width: 72.0, height: 72.0, child: currentAccountPicture),
          ),
        ),
      ],
    );
  }
}

class _AccountDetails extends StatefulWidget {
  const _AccountDetails({
    Key? key,
    @required this.accountName,
    @required this.accountEmail,
    this.onTap,
    this.isOpen = false,
  }) : super(key: key);

  final Widget? accountName;
  final Widget? accountEmail;
  final VoidCallback? onTap;
  final bool isOpen;

  @override
  _AccountDetailsState createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<_AccountDetails>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      value: widget.isOpen ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.fastOutSlowIn.flipped,
    )..addListener(() => setState(() {
          // [animation]'s value has changed here.
        }));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(_AccountDetails oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_animation.status == AnimationStatus.dismissed ||
        _animation.status == AnimationStatus.reverse) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasDirectionality(context));
    assert(debugCheckHasMaterialLocalizations(context));
    assert(debugCheckHasMaterialLocalizations(context));

    final ThemeData theme = Theme.of(context);
    final List<Widget> children = <Widget>[];

    if (widget.accountName != null) {
      final Widget accountNameLine = LayoutId(
        id: _AccountDetailsLayout.accountName,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: DefaultTextStyle(
            style: theme.primaryTextTheme.bodyMedium ?? TextStyle(),
            overflow: TextOverflow.ellipsis,
            child: widget.accountName!,
          ),
        ),
      );
      children.add(accountNameLine);
    }

    if (widget.accountEmail != null) {
      final Widget accountEmailLine = LayoutId(
        id: _AccountDetailsLayout.accountEmail,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: DefaultTextStyle(
            style: theme.primaryTextTheme.bodyMedium ?? TextStyle(),
            overflow: TextOverflow.ellipsis,
            child: widget.accountEmail!,
          ),
        ),
      );
      children.add(accountEmailLine);
    }
    if (widget.onTap != null) {
      final MaterialLocalizations localizations =
          MaterialLocalizations.of(context);
      final Widget dropDownIcon = LayoutId(
        id: _AccountDetailsLayout.dropdownIcon,
        child: Semantics(
          container: true,
          button: true,
          onTap: widget.onTap,
          child: SizedBox(
            height: _kAccountDetailsHeight,
            width: _kAccountDetailsHeight,
            child: Center(
              child: Transform.rotate(
                angle: _animation.value * math.pi,
                child: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white,
                  semanticLabel: widget.isOpen
                      ? localizations.hideAccountsLabel
                      : localizations.showAccountsLabel,
                ),
              ),
            ),
          ),
        ),
      );
      children.add(dropDownIcon);
    }

    Widget accountDetails = CustomMultiChildLayout(
      delegate: _AccountDetailsLayout(
        textDirection: Directionality.of(context),
      ),
      children: children,
    );

    if (widget.onTap != null) {
      accountDetails = InkWell(
        onTap: widget.onTap,
        child: accountDetails,
        excludeFromSemantics: true,
      );
    }

    return SizedBox(
      height: _kAccountDetailsHeight,
      child: accountDetails,
    );
  }
}

const double _kAccountDetailsHeight = 56.0;

class _AccountDetailsLayout extends MultiChildLayoutDelegate {
  _AccountDetailsLayout({required this.textDirection});

  static const String accountName = 'accountName';
  static const String accountEmail = 'accountEmail';
  static const String dropdownIcon = 'dropdownIcon';

  final TextDirection textDirection;

  @override
  void performLayout(Size size) {
    Size? iconSize;
    if (hasChild(dropdownIcon)) {
      // place the dropdown icon in bottom right (LTR) or bottom left (RTL)
      iconSize = layoutChild(dropdownIcon, BoxConstraints.loose(size));

      var offsetForIcon = _offsetForIcon(size, iconSize);
      positionChild(dropdownIcon, offsetForIcon);
    }

    final String? bottomLine = hasChild(accountEmail)
        ? accountEmail
        : (hasChild(accountName) ? accountName : null);

    if (bottomLine != null) {
      final Size constraintSize =
          iconSize == null ? size : (size - Size(iconSize.width, 0.0)) as Size;
      iconSize ??= const Size(_kAccountDetailsHeight, _kAccountDetailsHeight);

      // place bottom line center at same height as icon center
      final Size bottomLineSize =
          layoutChild(bottomLine, BoxConstraints.loose(constraintSize));
      final Offset bottomLineOffset =
          _offsetForBottomLine(size, iconSize, bottomLineSize);
      positionChild(bottomLine, bottomLineOffset);

      // place account name above account email
      if (bottomLine == accountEmail && hasChild(accountName)) {
        final Size nameSize =
            layoutChild(accountName, BoxConstraints.loose(constraintSize));
        positionChild(
            accountName, _offsetForName(size, nameSize, bottomLineOffset));
      }
    }
  }

  @override
  bool shouldRelayout(MultiChildLayoutDelegate oldDelegate) => true;

  Offset _offsetForIcon(Size size, Size iconSize) {
    switch (textDirection) {
      case TextDirection.ltr:
        return Offset(
            size.width - iconSize.width, size.height - iconSize.height);
      case TextDirection.rtl:
        return Offset(0.0, size.height - iconSize.height);
    }
  }

  Offset _offsetForBottomLine(Size size, Size iconSize, Size bottomLineSize) {
    final double y =
        size.height - 0.5 * iconSize.height - 0.5 * bottomLineSize.height;
    switch (textDirection) {
      case TextDirection.ltr:
        return Offset(0.0, y);
      case TextDirection.rtl:
        return Offset(size.width - bottomLineSize.width, y);
    }
  }

  Offset _offsetForName(Size size, Size nameSize, Offset bottomLineOffset) {
    final double y = bottomLineOffset.dy - nameSize.height;
    switch (textDirection) {
      case TextDirection.ltr:
        return Offset(0.0, y);
      case TextDirection.rtl:
        return Offset(size.width - nameSize.width, y);
    }
  }
}

/// A material design [Drawer] header that identifies the app's user.
///
/// Requires one of its ancestors to be a [Material] widget.
///
/// See also:
///
///  * [DrawerHeader], for a drawer header that doesn't show user accounts.
///  * <https://material.io/design/components/navigation-drawer.html#anatomy>
class NespUserAccountsDrawerHeader extends StatefulWidget {
  /// Creates a material design drawer header.
  ///
  /// Requires one of its ancestors to be a [Material] widget.
  const NespUserAccountsDrawerHeader(
      {Key? key,
      this.decoration,
      this.margin = const EdgeInsets.only(bottom: 8.0),
      this.drawerHeaderBackground,
      this.currentAccountPicture,
      this.otherAccountsPictures = const [],
      required this.accountName,
      required this.accountEmail,
      this.onDetailsPressed})
      : super(key: key);

  /// The header's background. If decoration is null then a [BoxDecoration]
  /// with its background color set to the current theme's primaryColor is used.
  final Decoration? decoration;

  /// The margin around the drawer header.
  final EdgeInsetsGeometry margin;

  final Widget? drawerHeaderBackground;

  /// A widget placed in the upper-left corner that represents the current
  /// user's account. Normally a [CircleAvatar].
  final Widget? currentAccountPicture;

  /// A list of widgets that represent the current user's other accounts.
  /// Up to three of these widgets will be arranged in a row in the header's
  /// upper-right corner. Normally a list of [CircleAvatar] widgets.
  final List<Widget> otherAccountsPictures;

  /// A widget that represents the user's current account name. It is
  /// displayed on the left, below the [currentAccountPicture].
  final Widget accountName;

  /// A widget that represents the email address of the user's current account.
  /// It is displayed on the left, below the [accountName].
  final Widget accountEmail;

  /// A callback that is called when the horizontal area which contains the
  /// [accountName] and [accountEmail] is tapped.
  final VoidCallback? onDetailsPressed;

  @override
  _NespUserAccountsDrawerHeaderState createState() =>
      _NespUserAccountsDrawerHeaderState();
}

class _NespUserAccountsDrawerHeaderState
    extends State<NespUserAccountsDrawerHeader> {
  bool _isOpen = false;

  void _handleDetailsPressed() {
    setState(() {
      _isOpen = !_isOpen;
    });
    widget.onDetailsPressed?.call();
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    assert(debugCheckHasMaterialLocalizations(context));
    return Semantics(
      container: true,
      label: MaterialLocalizations.of(context).signedInLabel,
      child: DrawerHeader(
        decoration: widget.decoration ??
            BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
        margin: widget.margin,
        padding: const EdgeInsetsDirectional.only(top: 16.0, start: 16.0),
        child: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                  child: Padding(
                padding: const EdgeInsetsDirectional.only(end: 16.0),
                child: _AccountPictures(
                  currentAccountPicture: widget.currentAccountPicture,
                  otherAccountsPictures: widget.otherAccountsPictures,
                ),
              )),
              _AccountDetails(
                accountName: widget.accountName,
                accountEmail: widget.accountEmail,
                isOpen: _isOpen,
                onTap: widget.onDetailsPressed == null
                    ? null
                    : _handleDetailsPressed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
