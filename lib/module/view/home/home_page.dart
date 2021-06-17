import 'package:shop/constants/app_color.dart';
import 'package:shop/constants/assets_path.dart';
import 'package:shop/constants/size.dart';
import 'package:shop/module/controller/app_controller.dart';
import 'package:shop/module/view/home/components/flash_sale.dart';
import 'package:shop/module/view/home/components/special_product.dart';
import 'package:shop/widgets/custom_app_bar.dart';
import 'package:shop/widgets/search_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/action_icon.dart';
import 'components/banner_slider.dart';
import 'components/best_seller.dart';
import 'components/feature_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // AppController appCtrl = Get.find();

    return GetBuilder<AppController>(
        init: AppController(),
        builder: (appCtrl) {
          return Column(
            children: [
              AppBarCard(
                theHeight: 70,
                //color: Color.fromRGBO(255,25, 25, 0.1),
                color: Color.fromRGBO(255,255, 255, 0),
                childWidget: Row(
                  children: [
                    //Image.asset(ukFlagImg, height: 20, width: 20),
                    DrawerIcon(color: kPrimary),
                    getHorizontalSpace(15),
                    Spacer(),
                    //Flexible(child: SearchField()),
                    Image.asset(logoImg2, height: 100, width: 100),
                    Spacer(),
                    ActionIcon(
                      icon: cartIcon,
                      visible: true,
                      press: () {
                        appCtrl.changePage(2);
                      }
                    ),
                  ],
                ),
              ),

              Container(
                constraints: BoxConstraints.loose(Size.fromHeight(60.0)),
                child: 
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.topCenter,
                    children: [
                      Positioned(
                        top: -5.0,
                        left: 0,
                        right: 0,
                        child: AppBarCard(
                          theHeight: 50, 
                          color: Color(0xffffffff),
                          childWidget: Row(
                            children: [
                              Flexible(child: SearchField()),
                              getHorizontalSpace(0),
                            ],
                        ),),)
                    ]
                  ),
                ),

              
              // AppBarCard(
              //   theHeight: 50, 
              //   color: Color(0xffffffff),
              //   childWidget: Row(
              //     children: [
              //       //Image.asset(ukFlagImg, height: 20, width: 20),
              //       //DrawerIcon(),
              //       Flexible(child: SearchField()),
              //       getHorizontalSpace(0),
              //     ],
              //   ),
              // ),

              
              Expanded(
                child: Stack(
                  children: [
                    ListView(
                      padding: EdgeInsets.only(top: 0, bottom: 15),
                      controller: appCtrl.homeScrollCtrl,
                      children: [
                        BannerPanel(),
                        getVerticalSpace(10),
                        FeatureList(),
                        getVerticalSpace(30),
                        FlashSale(),
                        getVerticalSpace(30),
                        BestSeller(),
                        getVerticalSpace(30),
                        SpecialProduct(),
                      ],
                    ),
                    AnimatedPositioned(
                      duration: 700.milliseconds,
                      curve: Curves.easeIn,
                      top: appCtrl.showScrollUp.value
                          ? getScreenHeight(30)
                          : getScreenHeight(-100),
                      right: 10,
                      child: InkWell(
                        onTap: () {
                          appCtrl.scrollUp();
                        },
                        child: CircleAvatar(
                          backgroundColor: kLightNavy,
                          radius: 16,
                          child: Icon(
                            Icons.keyboard_arrow_up_sharp,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        });
  }
}
