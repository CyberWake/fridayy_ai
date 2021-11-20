import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fridayy_one/business_logic/utils/fridayy_svg.dart';
import 'package:fridayy_one/services/service_locator.dart';

class Offer extends StatelessWidget {
  const Offer({
    Key? key,
    required this.offerCount,
    required this.isExpiredOffer,
    required this.height,
  }) : super(key: key);
  final int offerCount;
  final bool isExpiredOffer;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sizeConfig.getPropWidth(height),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.string(
            isExpiredOffer
                ? FridayySvg.expiredTicketIcon
                : FridayySvg.activeTicketIcon,
          ),
          SizedBox(
            width: sizeConfig.getPropWidth(15),
          ),
          Text(
            offerCount.toString(),
            style:
                Theme.of(context).textTheme.headline4!.copyWith(fontSize: 16),
          ),
          SizedBox(
            width: sizeConfig.getPropWidth(15),
          ),
          Text(
            isExpiredOffer ? "Offers expiring\nthis week" : "Active Offers",
            style:
                Theme.of(context).textTheme.headline4!.copyWith(fontSize: 12),
            maxLines: 2,
            textAlign: TextAlign.left,
          ),
          SizedBox(
            width: sizeConfig.getPropWidth(15),
          ),
        ],
      ),
    );
  }
}
