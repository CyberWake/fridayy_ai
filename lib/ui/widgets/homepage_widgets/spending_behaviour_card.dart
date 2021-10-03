import 'package:flutter/material.dart';
import 'package:fridayy_one/business_login/models/user_overview_model.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/widgets/doughnut_chart.dart';
import 'package:fridayy_one/ui/widgets/expense_chips.dart';

class SpendingBehaviourCard extends StatelessWidget {
  SpendingBehaviourCard({
    Key? key,
    this.onTap,
    required this.spendingData,
  }) : super(key: key);
  final Spending spendingData;
  final void Function()? onTap;

  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  String getMonth() {
    if (spendingData.month.isEmpty) {
      return '';
    }
    return months[int.parse(
          spendingData.month.substring(
            2,
          ),
        ) -
        1];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeConfig.getPropHeight(190),
      width: sizeConfig.getPropWidth(379),
      margin: EdgeInsets.only(
        top: sizeConfig.getPropHeight(22.5),
      ),
      padding: EdgeInsets.all(sizeConfig.getPropWidth(20)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          sizeConfig.getPropWidth(16),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            SizedBox(
              height: sizeConfig.getPropHeight(79),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(getMonth()),
                      Text('${spendingData.currency}. ${spendingData.amount}')
                    ],
                  ),
                  DoughnutChart(
                    size: 79,
                    data: spendingData.distribution,
                    onTap: onTap,
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 2,
            ),
            const Spacer(),
            ExpenseChips(
              data: spendingData.distribution,
            )
          ],
        ),
      ),
    );
  }
}
