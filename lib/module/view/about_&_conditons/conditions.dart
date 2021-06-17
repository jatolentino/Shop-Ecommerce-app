import 'package:shop/constants/app_color.dart';
import 'package:shop/constants/app_text.dart';
import 'package:shop/constants/assets_path.dart';
import 'package:shop/constants/size.dart';
import 'package:shop/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConditionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      conditionImg,
                      height: getScreenHeight(215),
                      width: getScreeWidth(335),
                      fit: BoxFit.cover,
                    ),
                  ),
                  getVerticalSpace(20),
                  Text(
                    "Terms & Conditions",
                    style: TextStyle(
                        fontSize: getTextSize(17), fontWeight: FontWeight.w700),
                  ),
                  getVerticalSpace(15),
                  Text(
                    loremDummyText,
                    // textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: getTextSize(15),
                      fontWeight: FontWeight.w400,
                      color: kLightText,
                      letterSpacing: 0.17,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            getVerticalSpace(20),
            CustomButton(
              widthValue: getScreeWidth(335),
              color: kPrimary,
              text: "Back To Previous",
              press: () => Get.back(),
            ),
            getVerticalSpace(20),
          ],
        ),
      ),
    );
  }
}
