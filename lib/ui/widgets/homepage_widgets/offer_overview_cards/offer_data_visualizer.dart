import 'package:flutter/material.dart';
import 'package:fridayy_one/business_logic/models/new_user_overview_model.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/widgets/charts/charts.dart';

class OfferOverView extends StatelessWidget {
  const OfferOverView({
    Key? key,
    required this.categories,
    required this.totalOffers,
  }) : super(key: key);
  final List<SortedCategories> categories;
  final String totalOffers;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BarChart(
          showLabel: false,
          data: categories,
        ),
        BarChart(
          showLabel: true,
          data: categories,
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
