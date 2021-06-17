import 'package:shop/constants/app_color.dart';
import 'package:shop/constants/size.dart';
import 'package:shop/module/controller/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ActionIcon extends StatelessWidget {
  const ActionIcon({
    Key? key,
    this.icon,
    this.press,
    this.visible = false,
    this.bgColor = Colors.white,
  }) : super(key: key);
  final String? icon;
  final VoidCallback? press;
  final bool? visible;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    CartController cart = Get.find();
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          radius: 18,
          backgroundColor: bgColor!,
          child: IconButton(
            icon: SvgPicture.asset(
              icon!,
              height: 18,
              color: kPrimary,
            ),
            onPressed: press,
          ),
        ),
        Positioned(
          right: -5,
          top: -5,
          child: Visibility(
            visible: visible!,
            child: Obx(
              () => CircleAvatar(
                radius: 10,
                backgroundColor: kRed,
                child: Text(
                  "${cart.cartList.length}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: getTextSize(12),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
