import 'package:shop/constants/app_color.dart';
import 'package:shop/constants/size.dart';
import 'package:flutter/material.dart';

class OrderIndex extends StatelessWidget {
  const OrderIndex({
    Key? key,
    required this.orderDate,
  }) : super(key: key);

  final String orderDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: kDark.withOpacity(0.1),
          borderRadius: BorderRadius.circular(5)),
      height: getScreenHeight(35),
      width: getScreeWidth(85),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Text(
        orderDate,
        style: TextStyle(
          fontSize: getTextSize(14),
          fontWeight: FontWeight.w600,
          color: kDark,
        ),
      ),
    );
  }
}
