import 'package:shop/constants/app_color.dart';
import 'package:shop/constants/app_constants.dart';
import 'package:shop/constants/assets_path.dart';
import 'package:shop/constants/size.dart';
import 'package:shop/widgets/search_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showSearch(context: context, delegate: CustomSearch()),
      child: Container(
        // margin: const EdgeInsets.only(right: 20),
        padding: EdgeInsets.only(left: 20),
        alignment: Alignment.center,
        height: getScreenHeight(45),
        decoration: searchBoxDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Search a Product ...',
              style: TextStyle(
                  fontSize: getTextSize(14), color: kDark.withOpacity(0.5)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
              child: CircleAvatar(
                backgroundColor: Color(0xffffffff),
                radius: 15,
                child: IconButton(
                  icon: SvgPicture.asset(searchIcon),
                  onPressed: null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
