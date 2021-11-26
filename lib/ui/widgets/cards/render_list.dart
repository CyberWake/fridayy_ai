import 'package:flutter/material.dart';
import 'package:fridayy_one/business_logic/models/new_models/spend_category_model.dart';
import 'package:fridayy_one/business_logic/models/new_models/spends_on_brand_model.dart';
import 'package:fridayy_one/business_logic/utils/enums.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/widgets/cards/card_separator.dart';
import 'package:fridayy_one/ui/widgets/cards/card_shimmer.dart';
import 'package:fridayy_one/ui/widgets/cards/spends/brand_card.dart';
import 'package:fridayy_one/ui/widgets/cards/spends/category_card.dart';
import 'package:fridayy_one/ui/widgets/cards/spends/transaction_card.dart';
import 'package:fridayy_one/ui/widgets/no_data_found.dart';

class RenderList<T> extends StatelessWidget {
  const RenderList({
    Key? key,
    required this.items,
    required this.isBusy,
    required this.type,
  }) : super(key: key);
  final List<T> items;
  final bool isBusy;
  final ListType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: sizeConfig.getPropWidth(16),
        vertical: sizeConfig.getPropHeight(16),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          sizeConfig.getPropWidth(16),
        ),
        border: Border.all(
          color: const Color(0xFFE7ECEE),
        ),
      ),
      alignment: items.isEmpty ? Alignment.center : Alignment.topCenter,
      child: ListView.separated(
        itemCount: isBusy
            ? 7
            : items.isEmpty
                ? 1
                : items.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (isBusy) {
            return const ListShimmerCard();
          } else if (items.isEmpty) {
            return const NoDataFound();
          }
          if (type == ListType.spendTrans) {
            return SpendsTransactionCard(spend: items[index] as SpendsOnBrand);
          } else if (type == ListType.spendCategory) {
            return SpendsCategoryCard(category: items[index] as Distribution);
          } else if (type == ListType.spendBrand) {
            return SpendsBrandCard(brand: items[index] as SpendsOnBrand);
          } else {
            return Container();
          }
        },
        separatorBuilder: (BuildContext context, int index) {
          return const CardSeparator();
        },
      ),
    );
  }
}
