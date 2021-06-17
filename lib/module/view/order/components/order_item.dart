import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:shop/constants/app_color.dart';
import 'package:shop/constants/assets_path.dart';
import 'package:shop/constants/size.dart';
import 'package:shop/module/model/my_order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../constants/api_path.dart';

class TotalAndEmail extends StatelessWidget {
  const TotalAndEmail({
    Key? key,
    required this.element,
  }) : super(key: key);

  final MyOrderModel? element;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: RichText(
            text: TextSpan(
                text: 'Total: ',
                style: TextStyle(
                  fontSize: getTextSize(20),
                  fontWeight: FontWeight.w600,
                  color: kDark,
                ),
                children: [
                  TextSpan(
                    text: '\$${element!.totalPrice}',
                    style: TextStyle(
                      fontSize: getTextSize(20),
                      fontWeight: FontWeight.w600,
                      color: kPrimary,
                    ),
                  )
                ]),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            alignment: Alignment.centerRight,
            height: getScreenHeight(35),
            child: FittedBox(
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: SvgPicture.asset(
                  emailIcon,
                  color: kDark.withOpacity(0.5),
                ),
                label: Text(
                  '${element!.userEmail}',
                  style: TextStyle(
                    color: kDark.withOpacity(0.5),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class OrderItem extends StatelessWidget {
  const OrderItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  final OrderItems item;

  @override
  Widget build(BuildContext context) {
    final image = CloudinaryImage.fromPublicId(
        // cloudName, item.imagePublicId! ?? "q9auytyo7kurmc0awcl6");
        cloudName, item.imagePublicId!);
    return ListTile(
      leading: Image.network(image.url),
      title: Text(
        item.name!,
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: RichText(
        text: TextSpan(
            text: '\$${item.price}',
            style: TextStyle(color: kPrimary),
            children: [
              TextSpan(
                text: ' x ${item.quantity} pc',
                style: TextStyle(
                  color: kLightText,
                ),
              )
            ]),
      ),
      contentPadding: EdgeInsets.zero,
    );
  }
}
