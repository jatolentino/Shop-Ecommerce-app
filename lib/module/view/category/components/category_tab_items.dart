import 'package:shop/config/routes/app_route.dart';
import 'package:shop/constants/app_color.dart';
import 'package:shop/constants/app_text.dart';
import 'package:shop/constants/size.dart';
import 'package:shop/module/controller/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryTabItems extends StatelessWidget {
  const CategoryTabItems({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppController appCtrl = Get.find();
    return Container(
      width: ResponsiveSize.screenWidth * 0.75,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: PageView.builder(
        itemCount: categoryList.length,
        controller: appCtrl.categoryPageCtrl,
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (ctx, index) {
          return GridView.builder(
            itemCount: categoryItemsList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.75,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
            ),
            itemBuilder: (ctx, index) {
              return InkWell(
                onTap: () => Get.toNamed(AppRoute.productPage),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: getScreenHeight(78),
                      width: getScreeWidth(78),
                      // color: Colors.deepOrange,
                      alignment: Alignment.center,
                      child: Image.asset(
                        categoryItemsList[index].image!,
                        fit: BoxFit.cover,
                      ),
                    ),
                    getVerticalSpace(5),
                    Text(
                      categoryItemsList[index].title!,
                      style: TextStyle(
                        fontSize: getTextSize(12),
                        fontWeight: FontWeight.w600,
                        color: kDark,
                      ),
                    ),
                    getVerticalSpace(5),
                    Text(
                      "\$${categoryItemsList[index].price}",
                      style: TextStyle(
                        fontSize: getTextSize(12),
                        fontWeight: FontWeight.w700,
                        color: kPrimary,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
