import 'package:flutter/material.dart';
import 'package:fridayy_one/business_logic/models/spend_category_model.dart';
import 'package:fridayy_one/business_logic/models/spends_model.dart';
import 'package:fridayy_one/business_logic/models/user_overview_model.dart';
import 'package:fridayy_one/business_logic/utils/enums.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/widgets/cards/card_separator.dart';
import 'package:fridayy_one/ui/widgets/cards/card_shimmer.dart';
import 'package:fridayy_one/ui/widgets/cards/offers/offer_brand_card.dart';
import 'package:fridayy_one/ui/widgets/cards/spends/brand_card.dart';
import 'package:fridayy_one/ui/widgets/cards/spends/category_card.dart';
import 'package:fridayy_one/ui/widgets/cards/spends/transaction_card.dart';
import 'package:fridayy_one/ui/widgets/no_data_found.dart';

class RenderList<T> extends StatelessWidget {
  const RenderList({
    required this.items,
    required this.isBusy,
    required this.type,
    this.listItemAdditionalParams,
    this.showBorderAndSeparator = true,
  }) : assert(
          type != ListType.offerBrand || listItemAdditionalParams != null,
          "Pass addition params",
        );
  final List<T> items;
  final Map<String, dynamic>? listItemAdditionalParams;
  final bool isBusy;
  final ListType type;
  final bool showBorderAndSeparator;

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
          color:
              showBorderAndSeparator ? const Color(0xFFE7ECEE) : Colors.white,
        ),
      ),
      alignment: items.isEmpty ? Alignment.center : Alignment.topCenter,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: isBusy
            ? 7
            : items.isEmpty
                ? 1
                : items.length,
        itemBuilder: (context, index) {
          if (isBusy) {
            return ListShimmerCard(
              height: showBorderAndSeparator ? null : 120,
            );
          } else if (items.isEmpty) {
            return const NoDataFound();
          }
          if (type == ListType.spendTrans) {
            return SpendsTransactionCard(
              spend: items[index] as SpendsModel,
              id: listItemAdditionalParams != null
                  ? listItemAdditionalParams!['brandId'].toString()
                  : null,
            );
          } else if (type == ListType.spendCategory) {
            return SpendsCategoryCard(
              category: items[index] as Distribution,
              month: listItemAdditionalParams!['month'].toString(),
              filter: listItemAdditionalParams!['filter'].toString(),
            );
          } else if (type == ListType.spendBrand) {
            return SpendsBrandCard(
              brand: items[index] as SpendsModel,
              month: listItemAdditionalParams!['month'].toString(),
              filter: listItemAdditionalParams!['filter'].toString(),
            );
          } else if (type == ListType.offerBrand) {
            return OfferBrandCard(
              offerInfo: items[index] as OfferInfo,
              brandId: listItemAdditionalParams!['brandId'].toString(),
              brandName: listItemAdditionalParams!['brandName'].toString(),
            );
          } else {
            return Container();
          }
        },
        separatorBuilder: (BuildContext context, int index) {
          return CardSeparator(
            color:
                showBorderAndSeparator ? const Color(0xFFEEF2F8) : Colors.white,
          );
        },
      ),
    );
  }
}
