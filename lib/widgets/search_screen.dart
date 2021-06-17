import 'package:shop/config/routes/app_route.dart';
import 'package:shop/constants/app_color.dart';
import 'package:shop/constants/assets_path.dart';
import 'package:shop/constants/size.dart';
import 'package:shop/module/controller/data_controller.dart';
import 'package:shop/widgets/custom_app_bar.dart';
import 'package:shop/widgets/loading_indicator.dart';
import 'package:shop/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SearchResultPage extends StatelessWidget {
  const SearchResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DataController data = Get.find();
    return SafeArea(
      child: Scaffold(
        body: Obx(
          () => Column(
            children: [
              AppBarCard(
                childWidget: Row(
                  children: [
                    InkWell(
                        onTap: () => Get.back(),
                        child: SvgPicture.asset(
                          backIcon,
                          color: Colors.white,
                        )),
                    getHorizontalSpace(10),
                    Text(
                      "Details",
                      style: TextStyle(
                        fontSize: getTextSize(18),
                        fontWeight: FontWeight.bold,
                        color: kPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: data.searchLoading.value
                    ? Center(
                        child: LoadingIndicator(),
                      )
                    : data.searchData.value.products!.isEmpty
                        ? Center(
                            child: Text("No Results Found"),
                          )
                        : GridView.builder(
                            itemCount: data.searchData.value.products!.length,
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.66,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemBuilder: (ctx, index) {
                              final item =
                                  data.searchData.value.products![index];
                              return ProductItem(
                                item: item,
                                press: () {
                                  Get.toNamed(AppRoute.detailsPage,
                                      arguments: item.id);
                                },
                              );
                            },
                          ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
