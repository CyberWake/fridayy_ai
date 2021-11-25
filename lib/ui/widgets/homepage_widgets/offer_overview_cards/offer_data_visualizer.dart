import 'package:flutter/material.dart';
import 'package:fridayy_one/business_logic/models/new_models/new_user_overview_model.dart';
import 'package:fridayy_one/business_logic/utils/extensions.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/widgets/charts/charts.dart';

class OfferOverView extends StatelessWidget {
  const OfferOverView({
    Key? key,
    required this.categories,
    required this.totalOffers,
    required this.gotoOfferCategory,
  }) : super(key: key);
  final List<SortedCategories> categories;
  final String totalOffers;
  final Function(int) gotoOfferCategory;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BarChart(chartData: categories, gotoOffer: gotoOfferCategory),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
          child: Column(
            children: categories
                .map(
                  (e) => Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: sizeConfig.getPropHeight(9.9),
                      horizontal: 0,
                    ),
                    child: e.categoryId.getSvgIcon(),
                  ),
                )
                .toList()
                .reversed
                .toList(),
          ),
        ),
        Positioned(
          bottom: sizeConfig.getPropHeight(24),
          right: sizeConfig.getPropWidth(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Total available offers",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 16),
              ),
              Text(
                totalOffers,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontSize: 40, color: Colors.black),
              ),
            ],
          ),
        )
      ],
    );
  }
}
