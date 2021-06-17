import 'package:shop/constants/app_color.dart';
import 'package:shop/constants/app_text.dart';
import 'package:shop/constants/size.dart';
import 'package:shop/module/controller/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductTabs extends StatelessWidget {
  const ProductTabs({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppController appCtrl = Get.find();
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      itemCount: categoryList.length,
      shrinkWrap: true,
      primary: true,
      itemBuilder: (ctx, index) {
        return Obx(
          () => GestureDetector(
            onTap: () {
              appCtrl.changeProductPage(index);
            },
            child: Container(
              height: getScreenHeight(35),
              margin: EdgeInsets.only(right: 10),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 2),
                      blurRadius: 15,
                      color: appCtrl.productIndex.value == index
                          ? Color.fromRGBO(0, 0, 0, 0.1)
                          : Colors.transparent,
                    )
                  ]),
              child: Text(
                productTabs[index],
                style: TextStyle(
                  color: appCtrl.productIndex.value == index
                      ? kPrimary
                      : kLightText,
                  fontSize: getTextSize(14),
                  fontWeight: appCtrl.productIndex.value == index
                      ? FontWeight.w700
                      : FontWeight.w400,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
