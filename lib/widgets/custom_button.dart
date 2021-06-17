import 'package:shop/constants/app_color.dart';
import 'package:shop/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final VoidCallback? press;
  final bool? isIcon;
  final String? icon;
  final Color? color;
  final Color? iconColor;
  final double? widthValue;

  const CustomButton(
      {this.text,
      this.icon,
      this.isIcon = false,
      this.color = kPrimary,
      this.iconColor = kDark,
      @required this.widthValue,
      this.press});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getScreeWidth(widthValue!),
      height: getScreenHeight(45),
      child: ElevatedButton.icon(
        icon: isIcon!
            ? SvgPicture.asset(
                icon!,
                color: iconColor,
              )
            : SizedBox(),
        style: ElevatedButton.styleFrom(
          primary: color,
        ),
        onPressed: press,
        label: Text(
          text!,
          style: Get.textTheme.subtitle1!
              .copyWith(fontWeight: FontWeight.w700, color: Colors.white),
        ),
      ),
    );
  }
}
