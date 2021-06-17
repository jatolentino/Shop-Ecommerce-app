import 'package:shop/config/routes/app_route.dart';
import 'package:shop/constants/app_color.dart';
import 'package:shop/constants/size.dart';
import 'package:shop/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DialogHelper {
  DialogHelper._();
  static final DialogHelper _instance = DialogHelper._();
  static DialogHelper get instance => _instance;

  void showErrorDialog(
      {String? title = 'Error', String? description = 'Something went wrong'}) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title!,
                style: Get.textTheme.headline6,
              ),
              Text(description!, style: Get.textTheme.bodyText1),
              getVerticalSpace(10),
              ElevatedButton(
                onPressed: () {
                  if (Get.isDialogOpen!) Get.back();
                },
                child: Text('Dismiss'),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  //show loading
  void showLoading({@required message}) {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LoadingIndicator(),
              getVerticalSpace(15),
              Text(
                message,
                style: TextStyle(
                  fontSize: getTextSize(16),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //hide loading
  void hideLoading() {
    if (Get.isDialogOpen!) Get.back();
  }

  //show exit dialog
  void showConfirmDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: kPrimary,
              height: getScreenHeight(60),
              width: double.infinity,
              alignment: Alignment.center,
              child: Text(
                "Do you want to exit?",
                style: Get.textTheme.subtitle1!.copyWith(
                  fontSize: getTextSize(17),
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PopUpButton(
                    text: "NO",
                    press: () => Get.back(),
                  ),
                  getHorizontalSpace(15),
                  PopUpButton(
                    text: "YES",
                    press: () => SystemNavigator.pop(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void orderPlacedDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.amber[200],
              height: getScreenHeight(60),
              width: double.infinity,
              alignment: Alignment.center,
              child: Text(
                "Order has been placed",
                style: Get.textTheme.subtitle1!.copyWith(
                    fontSize: getTextSize(17), fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () => Get.back(), child: Text("Dismiss")),
                  getHorizontalSpace(20),
                  TextButton(
                      onPressed: () {
                        Get.offAndToNamed(AppRoute.orderPage);
                      },
                      child: Text("Check")),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PopUpButton extends StatelessWidget {
  const PopUpButton({
    Key? key,
    this.text,
    this.press,
  }) : super(key: key);
  final String? text;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: kLightNavy,
        elevation: 0.0,
      ),
      onPressed: press,
      child: Text(
        text!.capitalize!,
        style: TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
