import 'package:shop/constants/app_constants.dart';
import 'package:shop/module/controller/app_controller.dart';
import 'package:shop/module/controller/cart_controller.dart';
import 'package:shop/module/controller/data_controller.dart';
import 'package:shop/utils/helper/dialog.dart';
import 'package:shop/widgets/bottom_nav.dart';
import 'package:shop/widgets/menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<DataController>();
    Get.find<CartController>();

    return WillPopScope(
      onWillPop: () async {
        DialogHelper.instance.showConfirmDialog();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          endDrawer: MenuDrawer(),
          endDrawerEnableOpenDragGesture: false,
          body: LayoutBuilder(
            builder: (ctx, constrains) {
              return SizedBox(
                height: constrains.maxHeight,
                child: GetBuilder<AppController>(
                  init: AppController(),
                  builder: (app) => PageView.builder(
                    itemCount: screenPages.length,
                    controller: app.appPageCtrl,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (ctx, index) {
                      return screenPages[app.navBarIndex.value];
                    },
                  ),
                ),
              );
            },
          ),
          bottomNavigationBar: BottomNavBar(),
        ),
      ),
    );
  }
}
