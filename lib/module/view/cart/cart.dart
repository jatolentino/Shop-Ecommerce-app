import 'package:shop/constants/app_color.dart';
import 'package:shop/constants/assets_path.dart';
import 'package:shop/constants/size.dart';
import 'package:shop/module/controller/cart_controller.dart';
import 'package:shop/widgets/action_icon.dart';
import 'package:shop/widgets/custom_app_bar.dart';
import 'package:shop/widgets/search_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'components/cart_list.dart';
import 'components/total_checkout.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartController cart = Get.find();
    return Obx(
      () => Column(
        children: [
          CartAppBar(),
          if (cart.cartList.isEmpty)
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    cartIcon,
                    height: 50,
                  ),
                  getVerticalSpace(10),
                  Text(
                    "Your Cart Empty",
                    style: TextStyle(
                      letterSpacing: 0.71,
                      height: 1.5,
                      color: kAppIcon,
                      fontSize: getTextSize(18),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          else
            Expanded(
              child: Column(
                children: [
                  CartList(),
                  TotalAndCheckout(),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class CartAppBar extends StatelessWidget {
  const CartAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartController cart = Get.find();
    return AppBarCard(
      childWidget: Row(
        children: [
          Text(
            "My Cart (${cart.cartList.length})",
            style: TextStyle(
              fontSize: getTextSize(18),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Spacer(),
          ActionIcon(
            icon: searchIcon,
            press: () => showSearch(context: context, delegate: CustomSearch()),
          ),
        ],
      ),
    );
  }
}
