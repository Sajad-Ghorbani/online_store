import 'package:flutter/material.dart';

class BaseWidget extends StatelessWidget {
  const BaseWidget({
    Key? key,
    this.appBar,
    required this.child,
    this.padding,
    this.backgroundColor,
  }) : super(key: key);
  final AppBar? appBar;
  final Color? backgroundColor;
  final double? padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding ?? 20.0),
        child: child,
      ),
    );
  }
}
