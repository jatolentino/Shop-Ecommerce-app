import 'package:shop/config/routes/app_route.dart';
import 'package:shop/constants/app_color.dart';
import 'package:shop/constants/app_text.dart';
import 'package:shop/constants/size.dart';
import 'package:shop/module/model/banner_model.dart';
import 'package:shop/widgets/header_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeatureList extends StatelessWidget {
  const FeatureList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        HeaderText(text: "Featured Deals", press: true),
        getVerticalSpace(15),
        SizedBox(
          height: getScreenHeight(120),
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: featureList.length,
            padding: EdgeInsets.symmetric(horizontal: 15),
            itemBuilder: (ctx, index) {
              return FeatureItem(item: featureList[index]);
            },
          ),
        ),
      ],
    );
  }
}

class FeatureItem extends StatelessWidget {
  const FeatureItem({
    Key? key,
    this.item,
  }) : super(key: key);
  final BannerModel? item;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getScreenHeight(120),
      width: getScreeWidth(210),
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.only(left: 20),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        image: DecorationImage(
          image: AssetImage(
            item!.imgUrl!,
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "${item!.offerText}",
            style: TextStyle(
              color: kRed,
              fontSize: getTextSize(10),
              fontWeight: FontWeight.w600,
            ),
          ),
          getVerticalSpace(6),
          Text(
            "${item!.title}",
            style: TextStyle(
              color: kDark,
              fontSize: getTextSize(15),
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
            ),
          ),
          getVerticalSpace(12),
          InkWell(
            onTap: () => Get.toNamed(AppRoute.productPage),
            child: Text(
              "View Products",
              style: TextStyle(
                color: kPrimary,
                fontSize: getTextSize(12),
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline,
                // height: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
