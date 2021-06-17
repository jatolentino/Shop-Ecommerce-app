import 'package:shop/constants/app_color.dart';
import 'package:shop/constants/assets_path.dart';
import 'package:shop/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppBarCard extends StatelessWidget {
 final double theHeight;
 const AppBarCard({
    Key? key,
    @required this.childWidget,
      
    //this.theHeight,
    this.color = kPrimary, this.theHeight = 70,
  }) : super(key: key);
  final Widget? childWidget;
  final Color? color;


  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? kPrimary,
      height: getScreenHeight(theHeight),
      width: double.infinity,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: childWidget,
    );
  }
}

class DrawerIcon extends StatelessWidget {
  const DrawerIcon({
    this.color = kPrimary,
    Key? key,
  }) : super(key: key);
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (ctx) {
        return InkWell(
          onTap: () => Scaffold.of(ctx).openEndDrawer(),
          child: SvgPicture.asset(menuIcon, color: color),
        );
      },
    );
  }
}
