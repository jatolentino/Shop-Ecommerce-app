import 'package:shop/constants/app_color.dart';
import 'package:shop/constants/size.dart';
import 'package:flutter/material.dart';

class CounterButton extends StatelessWidget {
  const CounterButton({
    Key? key,
    this.text,
    this.icon,
    this.press,
  }) : super(key: key);
  final String? text;
  final IconData? icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        height: getScreenHeight(25),
        width: getScreeWidth(25),
        margin: EdgeInsets.only(right: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: text != null ? Colors.white : kPrimary,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            width: 1.0,
            color: kAppIcon,
          ),
        ),
        child: text != null
            ? Text(
                text!,
              )
            : Icon(
                icon,
                size: 15,
                color: Colors.white,
              ),
      ),
    );
  }
}
