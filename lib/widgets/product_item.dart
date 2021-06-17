import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:shop/constants/api_path.dart';
import 'package:shop/constants/app_color.dart';
import 'package:shop/constants/size.dart';
import 'package:shop/module/model/product_model.dart';
import 'package:shop/utils/helper/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key, this.item, this.widthSize = 165, this.press})
      : super(key: key);

  final double? widthSize;
  final Products? item;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    final image = CloudinaryImage.fromPublicId(cloudName, item!.imagePublicId!);
    // print(image);
    return InkWell(
      onTap: press,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: getScreenHeight(165),
            width: getScreeWidth(widthSize!),
            child: Stack(
              fit: StackFit.expand,
              children: [
                CachedNetworkImage(
                  imageUrl: image.url,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => ShimmerLoader(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                if (item!.type == 'computers')
                  Positioned(
                    top: 10,
                    right: 10,
                    child: CircleAvatar(
                      backgroundColor: kRed,
                      radius: 15,
                      child: Text(
                        "New",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: getTextSize(10),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                if (item!.type == 'mobile')
                  Positioned(
                    top: 10,
                    right: 10,
                    child: CircleAvatar(
                      backgroundColor: kGreen,
                      radius: 15,
                      child: Text(
                        "Sale",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: getTextSize(10),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          // getVerticalSpace(10),
          SizedBox(
            height: getScreenHeight(83),
            width: getScreeWidth(widthSize!),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item!.name!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: getTextSize(13),
                    color: kDark,
                  ),
                ),
                getVerticalSpace(5),
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
                getVerticalSpace(8),
                Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.lineThrough,
                          fontSize: getTextSize(12),
                          color: Color(0xff969696),
                        ),
                        text: item!.type == 'mobile'
                            ? "\$${item!.price! * (25 / 100) + item!.price!}\t\t"
                            : "",
                        children: [
                          TextSpan(
                              style: TextStyle(
                                fontSize: getTextSize(15),
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.none,
                                color: kPrimary,
                              ),
                              text: "\$${item!.price}"),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
