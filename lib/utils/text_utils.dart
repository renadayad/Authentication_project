import 'package:flutter/material.dart';


class TextUtils extends StatelessWidget {
  final String text;
  final Color color;
  final double fontsize;
  final FontWeight fontWeight;
  final TextDecoration? underLine;
  TextUtils({
    required this.text,
    required this.color,
    required this.fontWeight,
    required this.fontsize,
    this.underLine,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        decoration: underLine,
        color: color,
        fontSize: fontsize,
        fontWeight: fontWeight,
      ),
    );
  }
}