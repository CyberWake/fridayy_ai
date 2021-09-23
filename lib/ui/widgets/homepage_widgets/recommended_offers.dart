import 'package:flutter/material.dart';
import 'package:fridayy_one/business_login/models/coupon_data.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/widgets/homepage_widgets/coupon_card.dart';

class RecommendedOffers extends StatelessWidget {
  const RecommendedOffers({Key? key, required this.couponData})
      : super(key: key);
  final List<CouponData> couponData;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: sizeConfig.getPropHeight(104),
      ),
      width: sizeConfig.getPropWidth(379),
      height: sizeConfig.getPropHeight(95),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: couponData.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return CouponCard(
            coupon: couponData[index],
            size: 76,
          );
        },
      ),
    );
  }
}
