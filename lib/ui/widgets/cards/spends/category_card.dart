import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:fridayy_one/business_logic/models/spend_category_model.dart';
import 'package:fridayy_one/business_logic/utils/extensions.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/views/HomePages/spend/category_transactions.dart';

class SpendsCategoryCard extends StatelessWidget {
  const SpendsCategoryCard({
    Key? key,
    required this.category,
    required this.month,
    required this.filter,
  }) : super(key: key);
  final Distribution category;
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
            '₹ ${category.amount.toStringAsFixed(1)}',
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
      },
      openBuilder: (context, onTap) {
        return CategoryTransactions(
          amountSpend: category.amount,
          month: month,
          categoryName: category.categoryId.getName(),
          categoryId: category.categoryId,
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
