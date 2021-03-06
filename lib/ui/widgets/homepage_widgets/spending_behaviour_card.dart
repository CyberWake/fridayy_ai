import 'package:flutter/material.dart';
import 'package:fridayy_one/business_logic/models/user_overview_model.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/widgets/charts/charts.dart';
import 'package:fridayy_one/ui/widgets/expense_chips.dart';

class SpendingBehaviourCard extends StatelessWidget {
  const SpendingBehaviourCard({
    Key? key,
    this.onTap,
    required this.spendingData,
  }) : super(key: key);
  final Spending spendingData;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeConfig
          .getPropHeight(spendingData.distribution == null ? 107 : 587),
      width: sizeConfig.getPropWidth(379),
      margin: EdgeInsets.only(
        top: sizeConfig.getPropHeight(22.5),
      ),
      padding: EdgeInsets.symmetric(horizontal: sizeConfig.getPropWidth(20)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          sizeConfig.getPropWidth(16),
        ),
        border: Border.all(color: const Color(0xFFE7ECEE)),
      ),
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            if (spendingData.distribution != null)
              PieChartWithVaryingRadius(
                size: 300,
                data: spendingData.distribution?.reversed.toList() ?? [],
                onTap: onTap,
              ),
            if (spendingData.distribution != null)
              Positioned(
                top: sizeConfig.getPropHeight(300),
                width: sizeConfig.getPropWidth(335),
                child: Column(
                  children: [
                    const Divider(
                      thickness: 1,
                    ),
                    ExpenseChips(
                      data: spendingData.distribution?.reversed.toList() ?? [],
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                  ],
                ),
              ),
            Positioned(
              bottom: sizeConfig.getPropHeight(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: sizeConfig.getPropHeight(16),
                  ),
                  Text(
                    '${spendingData.currency} ${spendingData.total}',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontSize: 28, color: Colors.black),
                  ),
                  SizedBox(
                    height: sizeConfig.getPropHeight(8),
                  ),
                  Text(
                    "Total Spending this month",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: const Color(0xFF040415)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
