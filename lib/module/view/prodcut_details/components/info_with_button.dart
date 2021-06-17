import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:shop/constants/api_path.dart';
import 'package:shop/constants/app_color.dart';
import 'package:shop/constants/app_text.dart';
import 'package:shop/constants/assets_path.dart';
import 'package:shop/constants/size.dart';
import 'package:shop/module/controller/cart_controller.dart';
import 'package:shop/module/controller/data_controller.dart';
import 'package:shop/utils/helper/show_snack.dart';
import 'package:shop/widgets/action_icon.dart';
import 'package:shop/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class Info extends StatelessWidget {
  const Info({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DataController dataCtrl = Get.find();
    CartController cart = Get.find();
    print(dataCtrl.productDetails.value.price);
    final image = CloudinaryImage.fromPublicId(
        cloudName, dataCtrl.productDetails.value.imagePublicId!);
    // print(image);
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: getScreenHeight(232),
            width: double.infinity,
            // color: Color(0xffF1F1F1),
            color: Color(0xffFFF),
            child: Image.network(
              image.url,
              fit: BoxFit.contain,
            ),
          ),
          getVerticalSpace(20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.lineThrough,
                          fontSize: getTextSize(16),
                          color: Color(0xff969696),
                        ),
                        text: dataCtrl.productDetails.value.type == 'mobile'
                            ? "\$${dataCtrl.productDetails.value.price! * (25 / 100) + dataCtrl.productDetails.value.price!}\t\t"
                            : "",
                        children: [
                          TextSpan(
                            style: TextStyle(
                              fontSize: getTextSize(20),
                              fontWeight: FontWeight.w900,
                              decoration: TextDecoration.none,
                              color: kPrimary,
                            ),
                            text: "\$${dataCtrl.productDetails.value.price}",
                          ),
                        ],
                      ),
                    ),
                    getVerticalSpace(10),
                    Row(
                      children: [
                        RatingBar.builder(
                          initialRating: 3,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          unratedColor: kAppIcon,
                          itemCount: 5,
                          itemSize: 12,
                          itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: kStar,
                          ),
                          onRatingUpdate: (rating) => print(rating),
                        ),
                        getHorizontalSpace(5),
                        Text(
                          "(325)",
                          style: TextStyle(
                            fontSize: getTextSize(10),
                            color: kLightText,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                ActionIcon(
                  icon: dataCtrl.wishExists.value ? heartFillIcon : heartIcon,
                  bgColor: Color(0xffF8F8F8),
                  press: dataCtrl.itemExists.value
                      ? () {
                          SnackMessage.instance.showSnack(
                              message:
                                  "Can't add to wishlist, it's already added to cart.");
                        }
                      : () {
                          if (dataCtrl.wishExists.value) {
                            cart.removeFromWish(
                                dataCtrl.productDetails.value.id!);
                          } else {
                            cart.addToWish(dataCtrl.productDetails.value);
                          }
                        },
                ),
                // getHorizontalSpace(10),
                // ActionIcon(
                //   icon: shareIcon,
                //   bgColor: Color(0xffF8F8F8),
                //   press: () {},
                // )
              ],
            ),
          ),
          getVerticalSpace(15),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "${dataCtrl.productDetails.value.name}",
              textAlign: TextAlign.start,
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: getTextSize(16),
                fontWeight: FontWeight.w700,
                letterSpacing: 0.7,
                height: 1.5,
              ),
            ),
          ),
          getVerticalSpace(30),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                border: Border.all(
                  color: Colors.black12,
                  width: 0.5,
                )),
            child: Column(
              children: [
                Column(
                  children: [
                    ...List.generate(
                      detailsCriteria.length,
                      (index) => Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                detailsCriteria[index].toUpperCase(),
                                style: TextStyle(
                                  fontSize: getTextSize(14),
                                  color: kDark,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                index == 0
                                    ? "${dataCtrl.productDetails.value.type}"
                                        .capitalize!
                                    : "In Stock (${dataCtrl.productDetails.value.totalInStock})",
                                style: TextStyle(
                                  fontSize: getTextSize(14),
                                  color: kIconText,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          if (index + 1 < 2)
                            Divider(
                              height: getScreenHeight(35),
                            ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          getVerticalSpace(40),
          if (dataCtrl.itemExists.value)
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              width: getScreeWidth(335),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    primary: kPrimary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
                onPressed: () {},
                child: Text(
                  "Already added",
                  style: TextStyle(
                    color: kDark,
                    fontWeight: FontWeight.w500,
                    fontSize: getTextSize(16),
                  ),
                ),
              ),
            )
          else
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(
                widthValue: getScreeWidth(335),
                text: 'Add To Cart',
                color: kPrimary,
                press: () {
                  cart.addToCart(dataCtrl.productDetails.value);
                },
              ),
            ),
        ],
      ),
    );
  }
}
