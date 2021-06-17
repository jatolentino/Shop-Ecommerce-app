import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:shop/constants/api_path.dart';
import 'package:shop/constants/app_color.dart';
import 'package:shop/constants/assets_path.dart';
import 'package:shop/constants/size.dart';
import 'package:shop/module/controller/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class WishList extends StatelessWidget {
  const WishList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartController cart = Get.find();
    return Expanded(
      child: ListView.separated(
        itemCount: cart.wishList.length,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        separatorBuilder: (ctx, index) => Divider(),
        itemBuilder: (ctx, index) {
          final item = cart.wishList[index];
          final image =
              CloudinaryImage.fromPublicId(cloudName, item.imagePublicId!);
          return SizedBox(
            height: getScreenHeight(100),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: getScreenHeight(75),
                  width: getScreeWidth(75),
                  child: Image.network(
                    image.url,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 3,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          item.name!,
                          style: TextStyle(
                            fontSize: getTextSize(16),
                            fontWeight: FontWeight.w600,
                            color: kDark,
                          ),
                        ),
                        getVerticalSpace(10),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: getTextSize(16),
                              fontWeight: FontWeight.w700,
                              color: kIconText,
                            ),
                            text: "\$${item.price}",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    cart.addToCartFromWish(index);
                  },
                  child: SvgPicture.asset(
                    cartIcon,
                    color: kPrimary,
                  ),
                ),
                getHorizontalSpace(20),
                GestureDetector(
                  onTap: () {
                    cart.removeFromWish(item.id!);
                  },
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Color(0xffF2F2F2),
                    child: Center(
                      child: Icon(
                        Icons.clear,
                        color: kPrimary,
                        size: 15,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
