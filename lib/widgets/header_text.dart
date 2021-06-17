import 'package:shop/config/routes/app_route.dart';
import 'package:shop/constants/app_color.dart';
import 'package:shop/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeaderText extends StatelessWidget {
  const HeaderText({
    Key? key,
    this.text,
    this.trailWidget = const Icon(Icons.arrow_forward_ios, size: 10),
    @required this.press,
  }) : super(key: key);
  final String? text;
  final Widget? trailWidget;
  final bool? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: InkWell(
        onTap: press == true ? () => Get.toNamed(AppRoute.productPage) : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text!,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                letterSpacing: 0.3,
                fontSize: getTextSize(13),
                color: kDark,
              ),
            ),
            SizedBox(child: trailWidget),
          ],
        ),
      ),
    );
  }
}
