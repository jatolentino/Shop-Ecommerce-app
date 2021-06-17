import 'package:shop/config/routes/app_route.dart';
import 'package:shop/constants/app_color.dart';
import 'package:shop/constants/assets_path.dart';
import 'package:shop/constants/size.dart';
import 'package:shop/module/controller/app_controller.dart';
import 'package:shop/module/controller/auth_controller.dart';
import 'package:shop/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController auth = Get.find();
    AppController appCtrl = Get.find();
    return Obx(
      () => Column(
        children: [
          ProfileAppBar(),
          if (!appCtrl.userExists.value)
            Expanded(
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoute.loginPage);
                  },
                  child: Text("Try to logged in"),
                ),
              ),
            )
          else
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(0xffF2F2F2),
                        radius: getScreeWidth(80),
                        backgroundImage: NetworkImage(
                          profileImage,
                          scale: 1.0,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 10,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: kPrimary,
                            child: Icon(
                              Icons.camera_alt,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  getVerticalSpace(50),
                  Text(
                    auth.userData.value.user!.name!.capitalize!,
                    style: TextStyle(
                      color: kDark,
                      fontSize: getTextSize(24),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  getVerticalSpace(15),
                  TextPanel(
                    label: 'Email',
                    text: auth.userData.value.user!.email,
                  ),
                  getVerticalSpace(15),
                  TextPanel(
                    label: 'Phone',
                    text: "${auth.userData.value.user!.phone}",
                  ),
                  getVerticalSpace(15),
                  TextPanel(
                    label: 'Role',
                    text: "${auth.userData.value.user!.role}".capitalize,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class TextPanel extends StatelessWidget {
  const TextPanel({
    Key? key,
    this.label,
    this.text,
  }) : super(key: key);

  final String? label;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: '$label: ',
          style: TextStyle(
            fontSize: getTextSize(16),
            fontWeight: FontWeight.w600,
            color: kDark,
          ),
          children: [
            TextSpan(
              text: '$text',
              style: TextStyle(
                color: Color(0xff7B7B7B),
                fontSize: getTextSize(16),
                fontWeight: FontWeight.normal,
                letterSpacing: 0.17,
                height: 1.5,
              ),
            )
          ]),
    );
  }
}

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBarCard(
      childWidget: Row(
        children: [
          Text(
            "My Profile",
            style: TextStyle(
              fontSize: getTextSize(18),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Spacer(),
          DrawerIcon(),
        ],
      ),
    );
  }
}
