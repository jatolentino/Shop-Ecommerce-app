import 'package:shop/constants/app_color.dart';
import 'package:shop/constants/size.dart';
import 'package:flutter/material.dart';

class AuthHeadingText extends StatelessWidget {
  const AuthHeadingText({this.text, @required this.fontSize, this.textAlign});
  final String? text;
  final double? fontSize;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      textAlign: textAlign,
      style: headingTextStyle(),
    );
  }

  TextStyle headingTextStyle() {
    return TextStyle(
      fontSize: getTextSize(fontSize!),
      fontWeight: FontWeight.w800,
      color: kDark,
    );
  }
}
