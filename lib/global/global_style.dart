import 'package:flutter/material.dart';

class GlobalStyledContainer extends StatelessWidget {
  final Widget child;
  final bool applySafeArea;
  final bool noPadding;
  final Color backgroundColor;
  final bool applyGlobalStyle;

  const GlobalStyledContainer({
    Key? key,
    required this.child,
    this.applySafeArea = false,
    this.noPadding = false,
    this.backgroundColor = const Color(0xFF30302E),
    this.applyGlobalStyle = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    EdgeInsets padding = EdgeInsets.zero;

    if (!noPadding) {
      if (width < 600) {
        padding = padding = EdgeInsets.only(
            left: 16, right: 16, top: 0, bottom: 24 + keyboardHeight);
      } else {
        padding =
            EdgeInsets.symmetric(horizontal: 24, vertical: 52 + keyboardHeight);
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: backgroundColor,
        padding: padding,
        child: applySafeArea ? SafeArea(child: child) : child,
      ),
    );
  }
}
