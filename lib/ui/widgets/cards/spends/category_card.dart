import 'package:flutter/material.dart';
import 'package:fridayy_one/business_logic/models/new_models/spend_category_model.dart';
import 'package:fridayy_one/business_logic/utils/extensions.dart';
import 'package:fridayy_one/services/service_locator.dart';

class SpendsCategoryCard extends StatelessWidget {
  const SpendsCategoryCard({Key? key, required this.category})
      : super(key: key);
  final Distribution category;

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
        child: category.categoryId.getSvgIcon(),
      ),
      title: Text(
        category.categoryId.getName(),
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
              fontSize: 16,
              color: const Color(0xFF717E95),
            ),
      ),
      subtitle: Text(
        '₹ ${category.amount}',
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
              fontSize: 14,
              color: const Color(0xFF000000),
            ),
      ),
      trailing: Text(
        '${category.count} Spends',
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
              fontSize: 16,
              color: Colors.black,
            ),
      ),
    );
  }
}
