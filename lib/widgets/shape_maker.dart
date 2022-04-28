import 'package:flutter/material.dart';

class ShapeMaker extends StatelessWidget {
  const ShapeMaker({
    Key? key,
    required this.height,
    required this.width,
    required this.color,
    this.top,
    this.bottom,
    this.left,
    this.right,
    this.shape = BoxShape.rectangle,
  }) : super(key: key);
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
  final double height;
  final double width;
  final Color color;
  final BoxShape shape;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      right: right,
      left: left,
      bottom: bottom,
      height: height,
      width: width,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          shape: shape,
        ),
      ),
    );
  }
}
