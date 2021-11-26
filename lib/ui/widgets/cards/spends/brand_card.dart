import 'package:flutter/material.dart';
import 'package:fridayy_one/business_logic/models/new_models/spends_on_brand_model.dart';
import 'package:fridayy_one/business_logic/utils/extensions.dart';
import 'package:fridayy_one/services/service_locator.dart';

class SpendsBrandCard extends StatelessWidget {
  const SpendsBrandCard({Key? key, required this.brand}) : super(key: key);
  final SpendsOnBrand brand;

  @override
  Widget build(BuildContext context) {
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
        child: Image.network(
          'https://friday-images.s3.ap-south-1.amazonaws.com/${brand.brandId}.jpeg',
          fit: BoxFit.contain,
        ),
      ),
      subtitle: Text(
        brand.brandName,
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
        children: [
          Text(
            "${brand.count} Spends",
            style: Theme.of(context).textTheme.caption!.copyWith(
                  fontSize: 14,
                  color: const Color(0xFF717E95),
                ),
          ),
          Text(
            "${brand.amount}",
            style: Theme.of(context).textTheme.caption!.copyWith(
                  fontSize: 16,
                  color: const Color(0xFF000000),
                ),
          ),
        ],
      ),
    );
  }
}
