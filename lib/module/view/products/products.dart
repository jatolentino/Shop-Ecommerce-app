import 'package:shop/constants/assets_path.dart';
import 'package:shop/constants/size.dart';
import 'package:shop/module/controller/app_controller.dart';
import 'package:shop/widgets/action_icon.dart';
import 'package:shop/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'components/product_tab.dart';
import 'components/product_tab_items.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppController appCtrl = Get.find();
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            AppBarCard(
              childWidget: Row(
                children: [
                  InkWell(
                      onTap: () => Get.back(),
                      child: SvgPicture.asset(backIcon)),
                  getHorizontalSpace(10),
                  Text(
                    "Products",
                    style: TextStyle(
                      fontSize: getTextSize(18),
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  ActionIcon(icon: searchIcon, press: () {}),
                  getHorizontalSpace(15),
                  ActionIcon(
                      icon: cartIcon,
                      visible: true,
                      press: () {
                        Get.back();
                        appCtrl.changePage(2);
                      }),
                ],
              ),
            ),
            SizedBox(
              height: getScreenHeight(80),
              child: ProductTabs(),
            ),
            Expanded(
              child: ProductTabItems(),
            )
          ],
        ),
      ),
    );
  }
}
