import 'package:flutter/material.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/widgets/offers_ticket.dart';

class Offer extends StatelessWidget {
  const Offer({
    Key? key,
    required this.offerCount,
    required this.isExpiredOffer,
    required this.height,
    this.onTap,
  }) : super(key: key);
  final int offerCount;
  final bool isExpiredOffer;
  final double height;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: sizeConfig.getPropHeight(height),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            OfferTicket(
              isExpiredTicket: isExpiredOffer,
              size: height,
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
            ),
            SizedBox(
              width: sizeConfig.getPropWidth(15),
            ),
          ],
        ),
      ),
    );
  }
}
