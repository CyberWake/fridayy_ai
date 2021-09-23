import 'package:flutter/material.dart';
import 'package:fridayy_one/business_login/models/pie_chart_data.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/widgets/doughnut_chart.dart';
import 'package:fridayy_one/ui/widgets/expense_chips.dart';

class SpendingBehaviourCard extends StatelessWidget {
  const SpendingBehaviourCard({
    Key? key,
    this.onTap,
    required this.chartData,
  }) : super(key: key);
  final void Function()? onTap;
  final List<DoughnutChartData> chartData;

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
                      const Text('September'),
                      const Text('Rs. 540.00')
                    ],
                  ),
                  DoughnutChart(
                    size: 79,
                    data: chartData,
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
              data: chartData,
            )
          ],
        ),
      ),
    );
  }
}
