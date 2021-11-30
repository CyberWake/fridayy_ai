import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fridayy_one/business_logic/models/spends_model.dart';
import 'package:fridayy_one/business_logic/utils/extensions.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/views/HomePages/spend/brand_transactions.dart';

class SpendsBrandCard extends StatelessWidget {
  const SpendsBrandCard({
    Key? key,
    required this.brand,
    required this.month,
    required this.filter,
  }) : super(key: key);
  final SpendsModel brand;
  final String month;
  final String filter;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedBuilder: (context, onTap) {
        return ListTile(
          leading: Container(
            width: sizeConfig.getPropHeight(44),
            height: sizeConfig.getPropHeight(44),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                sizeConfig.getPropWidth(8),
              ),
              color: const Color(0xFFF9F9F9),
            ),
            child: CachedNetworkImage(
              imageUrl:
                  'https://friday-images.s3.ap-south-1.amazonaws.com/${brand.brandId}.jpeg',
              imageBuilder: (context, imageProvider) => Container(
                width: sizeConfig.getPropHeight(44),
                height: sizeConfig.getPropHeight(44),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    sizeConfig.getPropWidth(8),
                  ),
                  color: const Color(0xFFF9F9F9),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          subtitle: Text(
            brand.brandName!,
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontSize: 16,
                  color: Colors.black,
                ),
          ),
          title: Text(
            brand.categoryId?.getName() ?? '',
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontSize: 14,
                  color: const Color(0xFF717E95),
                ),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${brand.count} Spends",
                style: Theme.of(context).textTheme.caption!.copyWith(
                      fontSize: 14,
                      color: const Color(0xFF717E95),
                    ),
              ),
              Text(
                "₹ ${brand.amount.toStringAsFixed(1)}",
                style: Theme.of(context).textTheme.caption!.copyWith(
                      fontSize: 16,
                      color: const Color(0xFF000000),
                    ),
              ),
            ],
          ),
        );
      },
      openBuilder: (context, onTap) {
        return BrandTransactions(
          amountSpend: brand.amount,
          month: month,
          brandName: brand.brandName!,
          brandId: brand.brandId!,
          filter: filter,
        );
      },
      transitionDuration: const Duration(milliseconds: 750),
      closedElevation: 0.0,
      openElevation: 0.0,
      tappable: true,
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      closedColor: Colors.transparent,
    );
  }
}
