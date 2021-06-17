import 'package:shop/config/routes/app_route.dart';
import 'package:shop/constants/size.dart';
import 'package:shop/module/controller/data_controller.dart';
import 'package:shop/utils/helper/loader.dart';
import 'package:shop/widgets/header_text.dart';
import 'package:shop/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpecialProduct extends StatelessWidget {
  const SpecialProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DataController data = Get.find();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        HeaderText(text: "Special Products", press: true),
        getVerticalSpace(15),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          // children: List.generate(, (index) { edited
          children: List.generate(data.productData.value.products?.length == null ? 0 : data.productData.value.products!.length, (index) {
            if (data.isLoading.value)
              return ShimmerLoader(
                height: getScreenHeight(260),
                width: getScreeWidth(165),
              );
            else
              return Container(
                height: getScreenHeight(260),
                width: getScreeWidth(165),
                child: ProductItem(
                  item: data.productData.value.products![index],
                  press: () {
                    Get.toNamed(AppRoute.detailsPage,
                        arguments: data.productData.value.products![index].id);
                  },
                ),
              );
          }),
        ),
      ],
    );
  }
}
