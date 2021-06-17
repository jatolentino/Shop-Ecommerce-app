import 'package:shop/constants/app_color.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountText extends StatelessWidget {
  const AccountText({this.text, this.authText, this.press});
  final String? text;
  final String? authText;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "$text?\t\t",
        style: Get.textTheme.subtitle2!.copyWith(
          color: kLightText,
          fontWeight: FontWeight.w400,
        ),
        children: [
          TextSpan(
            text: authText,
            recognizer: TapGestureRecognizer()..onTap = press,
            style: Get.textTheme.subtitle2!.copyWith(
              color: kDark,
              fontWeight: FontWeight.w700,
            ),
          )
        ],
      ),
    );
  }
}
