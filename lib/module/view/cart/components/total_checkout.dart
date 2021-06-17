import 'package:shop/config/routes/app_route.dart';
import 'package:shop/constants/app_color.dart';
import 'package:shop/constants/size.dart';
import 'package:shop/module/controller/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TotalAndCheckout extends StatelessWidget {
  const TotalAndCheckout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartController cart = Get.find();
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 0.5,
          color: kPrimary,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: getTextSize(16),
                color: Color(0xff969696),
              ),
              text: "Sub-Total: \t",
              children: [
                TextSpan(
                    style: TextStyle(
                      fontSize: getTextSize(18),
                      fontWeight: FontWeight.w700,
                      color: kPrimary,
                    ),
                    text: "\$${cart.cartTotal}"),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: kPrimary,
            ),
            onPressed: () {
              Get.toNamed(AppRoute.addressPage);
            },
            child: Text(
              "Checkout",
              style: TextStyle(
                fontSize: getTextSize(14),
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
