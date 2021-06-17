import 'package:shop/config/routes/app_route.dart';
import 'package:shop/constants/app_color.dart';
import 'package:shop/constants/size.dart';
import 'package:shop/module/controller/app_controller.dart';
import 'package:shop/module/controller/data_controller.dart';
import 'package:shop/utils/helper/loader.dart';
import 'package:shop/widgets/header_text.dart';
import 'package:shop/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';

class FlashSale extends StatelessWidget {
  const FlashSale({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DataController data = Get.find();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        HeaderText(
            text: "Flash Sale", trailWidget: FlashCounter(), press: false),
        getVerticalSpace(15),
        SizedBox(
          height: getScreenHeight(258),
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: data.productData.value.products?.length,//4, EDITED
            //itemCount: data.productData.value.products?.length == null ? 0 : data.productData.value.products!.length,
            padding: EdgeInsets.symmetric(horizontal: 15),
            itemBuilder: (ctx, index) {
              if (data.isLoading.value)
                return ShimmerLoader(
                  height: getScreenHeight(260),
                  width: getScreeWidth(165),
                );
              else
                return Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: ProductItem(
                    widthSize: 140,
                    item: data.productData.value.products?[index],
                    press: () {
                      Get.toNamed(AppRoute.detailsPage,
                          arguments:
                              data.productData.value.products![index].id);
                    },
                  ),
                );
            },
          ),
        ),
      ],
    );
  }
}

class FlashCounter extends StatelessWidget {
  const FlashCounter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppController appCtrl = Get.find();
    return CountdownTimer(
      endTime: appCtrl.flashEndTime,
      widgetBuilder: (_, time) {
        if (time == null) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
                color: kRed, borderRadius: BorderRadius.circular(5)),
            child: Text(
              'Flash Sale Over',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: getTextSize(10),
              ),
            ),
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Closing In:",
              style: TextStyle(
                fontSize: getTextSize(10),
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
                color: kIconText,
              ),
            ),
            getHorizontalSpace(10),
            TimerCard(leftTime: time.days),
            TimeDivider(),
            TimerCard(leftTime: time.hours),
            TimeDivider(),
            TimerCard(leftTime: time.min),
            TimeDivider(),
            TimerCard(leftTime: time.sec),
          ],
        );
      },
    );
  }
}

class TimerCard extends StatelessWidget {
  const TimerCard({
    Key? key,
    this.leftTime,
  }) : super(key: key);
  final int? leftTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getScreenHeight(20),
      width: getScreeWidth(20),
      padding: EdgeInsets.all(0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: kPrimary,
        borderRadius: BorderRadius.circular(2),
      ),
      child: Text(
        leftTime.toString().padLeft(2, '0'),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
          fontSize: getTextSize(10),
        ),
      ),
    );
  }
}

class TimeDivider extends StatelessWidget {
  const TimeDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: Text(
        " : ",
        style: TextStyle(color: kIconText),
      ),
    );
  }
}
