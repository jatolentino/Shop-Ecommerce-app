import 'package:shop/constants/assets_path.dart';
import 'package:shop/constants/size.dart';
import 'package:shop/module/controller/app_controller.dart';
import 'package:shop/module/controller/data_controller.dart';
import 'package:shop/utils/helper/loader.dart';
import 'package:shop/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'components/order_item.dart';
import 'components/order_title.dart';

class MyOrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppController appCtrl = Get.find();
    DataController data = Get.find();
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            OrderAppBar(),
            Expanded(
              child: GetBuilder<DataController>(
                init: DataController(),
                builder: (order) {
                  if (!appCtrl.userExists.value)
                    return Center(
                      child: Text(
                        "You're not logged in".capitalize!,
                        style: TextStyle(
                          fontSize: getTextSize(18),
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                    );
                  else if (order.orderLoading.value)
                    return SizedBox(
                      height: ResponsiveSize.screenHeight,
                      width: ResponsiveSize.screenWidth,
                      child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (ctx, index) {
                          return ListTile(
                            contentPadding: EdgeInsets.all(10),
                            title: ShimmerLoader(height: 20),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: ShimmerLoader(height: 30, width: 50),
                            ),
                          );
                        },
                      ),
                    );
                  else if (data.myOrders.isEmpty) {
                    return Center(
                      child: Text(
                        "No Order Placed Yet",
                        style: TextStyle(
                          fontSize: getTextSize(16),
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                    );
                  } else
                    return ListView.separated(
                      itemCount: order.myOrders.length,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      separatorBuilder: (ctx, index) => Divider(),
                      itemBuilder: (ctx, index) {
                        final element = order.myOrders[index];
                        final userName = element.userFirstName!;

                        return ExpansionTile(
                          tilePadding: EdgeInsets.zero,
                          leading: OrderIndex(orderDate: userName),
                          childrenPadding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          title: Text(''),
                          children: [
                            TotalAndEmail(element: element),
                            ...List.generate(
                              element.orderItems!.length,
                              (index) {
                                final item = element.orderItems![index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: OrderItem(item: item),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderAppBar extends StatelessWidget {
  const OrderAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBarCard(
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
            "My Order",
            style: TextStyle(
              fontSize: getTextSize(18),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
