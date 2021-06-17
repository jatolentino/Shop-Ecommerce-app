import 'package:carousel_slider/carousel_slider.dart';
import 'package:shop/config/routes/app_route.dart';
import 'package:shop/constants/app_color.dart';
import 'package:shop/constants/app_text.dart';
import 'package:shop/constants/size.dart';
import 'package:shop/module/controller/app_controller.dart';
import 'package:shop/module/model/banner_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BannerPanel extends StatefulWidget {
  @override
  _BannerPanelState createState() => _BannerPanelState();
}

class _BannerPanelState extends State<BannerPanel> {
  @override
  Widget build(BuildContext context) {
    AppController appController = Get.find();
    return Container(
      padding:
          const EdgeInsets.only(left: 10.0, right: 10.0, top: 10, bottom: 15),
      height: getScreenHeight(170),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          CarouselSlider(
            items: bannerList.map((item) => BannerItem(item: item)).toList(),
            carouselController: appController.carousalController,
            options: CarouselOptions(
              autoPlay: true,
              initialPage: 0,
              viewportFraction: 1,
              autoPlayInterval: 3.seconds,
              reverse: false,
              aspectRatio: 1,
              onPageChanged: (index, reason) =>
                  appController.carousalIndex(index),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: dotIndicator(appController),
          )
        ],
      ),
    );
  }

  Widget dotIndicator(AppController appController) {
    return Obx(
      () => Container(
        // color: Colors.black.withOpacity(0.3),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: bannerList
              .asMap()
              .entries
              .map(
                (entry) => Container(
                  width: entry.key == appController.carousalIndex.value
                      ? 8.0
                      : 6.0,
                  height: entry.key == appController.carousalIndex.value
                      ? 8.0
                      : 6.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: entry.key == appController.carousalIndex.value
                        ? kPrimary
                        : Colors.white,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class BannerItem extends StatelessWidget {
  const BannerItem({
    Key? key,
    this.item,
  }) : super(key: key);
  final BannerModel? item;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.centerLeft,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(
              "${item!.imgUrl}",
              fit: BoxFit.cover,
              height: getScreenHeight(40),
            ),
          ),
        ),
        Positioned(
          top: 20,
          left: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${item!.offerText}",
                style: TextStyle(
                  color: kRed,
                  fontSize: getTextSize(16),
                  fontWeight: FontWeight.w400,
                ),
              ),
              getVerticalSpace(6),
              Text(
                "${item!.title}",
                style: TextStyle(
                  color: kDark,
                  fontSize: getTextSize(20),
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                ),
              ),
              getVerticalSpace(10),
              SizedBox(
                height: getScreenHeight(30),
                width: getScreeWidth(100),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: kPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      )),
                  onPressed: () => Get.toNamed(AppRoute.productPage),
                  child: Text(
                    "Shop Now",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: getTextSize(12),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
