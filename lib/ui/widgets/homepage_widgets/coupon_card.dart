import 'package:flutter/material.dart';
import 'package:fridayy_one/business_login/models/coupon_data.dart';
import 'package:fridayy_one/services/service_locator.dart';

class CouponCard extends StatelessWidget {
  const CouponCard({Key? key, required this.coupon, required this.size})
      : super(key: key);
  final CouponData coupon;
  final double size;

  Color getCouponBorderColor(DateTime expiry) {
    final int difference = expiry.difference(DateTime.now()).inHours;
    switch (difference) {
      case 0:
        return Colors.grey;
      case 1:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.yellow;
      default:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          height: sizeConfig.getPropHeight(size),
          width: sizeConfig.getPropWidth(size),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: getCouponBorderColor(coupon.couponExpiry),
              width: 2,
            ),
            image: const DecorationImage(
              image: NetworkImage('https://i.pravatar.cc/300'),
            ),
          ),
        ),
        Text(
          coupon.company,
          style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 11),
        )
      ],
    );
  }
}
