import 'package:shop/constants/app_color.dart';
import 'package:shop/constants/app_text.dart';
import 'package:shop/constants/size.dart';
import 'package:shop/module/controller/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CategoryTabs extends StatelessWidget {
  const CategoryTabs({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppController appCtrl = Get.find();
    return Container(
      width: ResponsiveSize.screenWidth * 0.25,
      color: Color(0xffE5E5E5).withOpacity(0.5),
      child: ListView.builder(
        itemCount: categoryList.length,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        itemBuilder: (ctx, i) {
          return Obx(
            () => InkWell(
              onTap: () {
                appCtrl.changeCategoryPage(i);
              },
              child: Container(
                height: getScreenHeight(70),
                width: getScreeWidth(60),
                margin: EdgeInsets.only(bottom: 10),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: appCtrl.categoryIndex.value == i
                      ? kPrimary
                      : Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 4,
                      color: appCtrl.categoryIndex.value == i
                          ? Colors.black.withOpacity(0.25)
                          : Colors.transparent,
                    )
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      appCtrl.categoryIndex.value == i
                          ? categoryList[i].activeIcon!
                          : categoryList[i].icon!,
                      height: getScreeWidth(24),
                      width: getScreeWidth(24),
                      color: appCtrl.categoryIndex.value == i
                          ? Colors.white
                          : kLightNavy,
                    ),
                    getVerticalSpace(5),
                    FittedBox(
                      child: Text(
                        categoryList[i].title!,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: getTextSize(10),
                          fontWeight: FontWeight.bold,
                          color: appCtrl.categoryIndex.value == i
                              ? Colors.white
                              : kIconText,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
