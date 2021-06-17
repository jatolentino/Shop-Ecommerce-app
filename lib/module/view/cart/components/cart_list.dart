import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:shop/constants/api_path.dart';
import 'package:shop/constants/app_color.dart';
import 'package:shop/constants/size.dart';
import 'package:shop/module/controller/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'counter.dart';

class CartList extends StatelessWidget {
  const CartList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartController cart = Get.find();
    return Expanded(
      child: ListView.separated(
        itemCount: cart.cartList.length,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        separatorBuilder: (ctx, index) => Divider(),
        itemBuilder: (ctx, index) {
          final image = CloudinaryImage.fromPublicId(
              cloudName, cart.cartList[index].imagePublicId!);
          return SizedBox(
            height: getScreenHeight(120),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: getScreenHeight(120),
                  width: getScreeWidth(90),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          cart.cartList[index].name!,
                          style: TextStyle(
                            fontSize: getTextSize(14),
                            fontWeight: FontWeight.w600,
                            color: kDark,
                          ),
                        ),
                        getVerticalSpace(10),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: getTextSize(14),
                              fontWeight: FontWeight.bold,
                              color: kPrimary,
                            ),
                            text: "\$${cart.cartList[index].price}",
                            children: [
                              TextSpan(
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: getTextSize(14),
                                    color: Color(0xff969696),
                                  ),
                                  text:
                                      " x ${cart.cartList[index].quantity} pc"),
                            ],
                          ),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            CounterButton(
                              icon: Icons.remove,
                              press: () {
                                if (cart.cartList[index].quantity != 1)
                                  cart.decrement(index);
                              },
                            ),
                            CounterButton(
                              text: '${cart.cartList[index].quantity.obs}',
                            ),
                            CounterButton(
                              icon: Icons.add,
                              press: () {
                                cart.increment(index);
                              },
                            ),
                          ],
                        ),
                        getVerticalSpace(10),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    cart.removeFromCart(index);
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
