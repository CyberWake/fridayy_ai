import 'package:flutter/material.dart';
import 'package:fridayy_one/business_logic/models/new_user_overview_model.dart';
import 'package:fridayy_one/business_logic/utils/extensions.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/widgets/charts/charts.dart';

class OfferOverView extends StatelessWidget {
  OfferOverView({
    Key? key,
    required this.categories,
    required this.totalOffers,
    required this.gotoOfferCategory,
  }) : super(key: key);
  final List<SortedCategories> categories;
  final String totalOffers;
  final Function(int) gotoOfferCategory;

  final List<Color> backgroundColor = [
    const Color(0xFFCEF9F2),
    const Color(0xFFFAB8C4),
    const Color(0xFFFFDC60),
    const Color(0xFFCEF9F2),
    const Color(0xFFFAB8C4),
    const Color(0xFFFFDC60),
    const Color(0xFFCEF9F2),
  ];

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
                  (e) => Expanded(
                    child: Container(
                      width: 25,
                      color: backgroundColor[
                          categories.indexWhere((element) => element == e)],
                      alignment: Alignment.centerLeft,
                      child: e.categoryId.getSvgIcon(),
                    ),
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
                    .copyWith(fontSize: 40, color: const Color(0xFF040415)),
              ),
            ],
          ),
        )
      ],
    );
  }
}
