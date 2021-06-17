import 'package:shop/constants/size.dart';
import 'package:shop/utils/helper/loader.dart';
import 'package:flutter/material.dart';

class DetailsPlaceholder extends StatelessWidget {
  const DetailsPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ResponsiveSize.screenHeight,
      width: ResponsiveSize.screenWidth,
      child: Column(
        children: [
          ShimmerLoader(
            height: ResponsiveSize.screenHeight * 0.35,
            width: double.infinity,
          ),
          getVerticalSpace(15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerLoader(
                      height: ResponsiveSize.screenHeight * 0.03,
                      width: ResponsiveSize.screenWidth * 0.3,
                    ),
                    getHorizontalSpace(15),
                    ShimmerLoader(
                      height: ResponsiveSize.screenHeight * 0.03,
                      width: ResponsiveSize.screenWidth * 0.2,
                    ),
                  ],
                ),
                getVerticalSpace(10),
                ShimmerLoader(
                  height: ResponsiveSize.screenHeight * 0.02,
                  width: ResponsiveSize.screenWidth,
                ),
                getVerticalSpace(10),
                ShimmerLoader(
                  height: ResponsiveSize.screenHeight * 0.05,
                  width: ResponsiveSize.screenWidth,
                ),
                getVerticalSpace(15),
                ShimmerLoader(
                  height: ResponsiveSize.screenHeight * 0.25,
                  width: double.infinity,
                ),
                getVerticalSpace(15),
                ShimmerLoader(
                  height: ResponsiveSize.screenHeight * 0.06,
                  width: ResponsiveSize.screenWidth,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
