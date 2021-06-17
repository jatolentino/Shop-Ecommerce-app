import 'package:shop/constants/app_color.dart';
import 'package:shop/constants/app_text.dart';
import 'package:shop/constants/size.dart';
import 'package:shop/module/controller/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppController navCtrl = Get.find();
    return Obx(
      () => Container(
        height: getScreenHeight(80),
        padding: EdgeInsets.symmetric(horizontal: 25),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 2),
              blurRadius: 4,
              color: Color(0xff000000).withOpacity(0.25),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: navBarItems.asMap().entries.map((e) {
            print(e.value['icon2']);
            return InkWell(
              onTap: () {
                navCtrl.changePage(e.key);
              },
              child: AnimatedContainer(
                duration: 500.milliseconds,
                curve: Curves.ease,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      navCtrl.navBarIndex.value == e.key
                          ? e.value['active']!
                          : e.value['inactive']!,
                      height: 20,
                      color: navCtrl.navBarIndex.value == e.key
                          ? kPrimary
                          : kAppIcon,
                    ),
                    getVerticalSpace(8),
                    Text(
                      e.value['label']!,
                      style: TextStyle(
                        fontSize: getTextSize(14),
                        color: navCtrl.navBarIndex.value == e.key
                            ? kPrimary
                            : kIconText,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.2,
                      ),
                    )
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
