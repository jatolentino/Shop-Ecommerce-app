import 'package:shop/constants/app_color.dart';
import 'package:shop/constants/size.dart';
import 'package:shop/module/view/cart/cart.dart';
import 'package:shop/module/view/category/category.dart';
import 'package:shop/module/view/home/home_page.dart';
import 'package:shop/module/view/profile/profile.dart';
import 'package:shop/module/view/products/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

const kPadding = 20;

List<Widget> screenPages = [
  HomePage(),
  ProductPage(),
  // CategoryPage(),
  CartPage(),
  ProfilePage(),
];
InputDecoration buildCredentialDecoration({@required hintText, icon}) {
  var outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(width: 1, color: Color(0xffF5F5F5)));
  return InputDecoration(
    hintText: hintText,
    prefixIcon: icon != null
        ? IconButton(
            icon: SvgPicture.asset(
              icon,
              color: kPrimary,
            ),
            onPressed: null,
          )
        : null,
    fillColor: Color(0xffF5F5F5),
    filled: true,
    floatingLabelBehavior: FloatingLabelBehavior.always,
    enabledBorder: outlineInputBorder,
    border: outlineInputBorder,
    focusedBorder: outlineInputBorder.copyWith(
        borderSide: BorderSide(
      color: kPrimary,
      width: 0.5,
    )),
  );
}

BoxDecoration searchBoxDecoration() {
  return BoxDecoration(
    color: Color(0xffF5F5F5),
    borderRadius: BorderRadius.circular(6),
    border: Border.all(
      width: 0,
      color: Colors.white,
    ),
  );
}

TextStyle descriptionText() {
  return TextStyle(
    fontSize: getTextSize(12),
    fontWeight: FontWeight.w400,
    color: kIconText,
    letterSpacing: 0.3,
    height: 1.5,
  );
}
