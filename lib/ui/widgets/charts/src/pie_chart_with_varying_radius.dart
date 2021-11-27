import 'package:flutter/material.dart';
import 'package:fridayy_one/business_logic/models/new_user_overview_model.dart';
import 'package:fridayy_one/business_logic/utils/extensions.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PieChartWithVaryingRadius extends StatelessWidget {
  const PieChartWithVaryingRadius({
    Key? key,
    required this.data,
    required this.size,
    this.onTap,
  }) : super(key: key);
  final List<DistributionSpending> data;
  final double size;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: sizeConfig.getPropHeight(size),
        width: sizeConfig.getPropWidth(size),
        child: SfCircularChart(
          margin: EdgeInsets.zero,
          legend: Legend(
            isVisible: false,
            position: LegendPosition.bottom,
            overflowMode: LegendItemOverflowMode.wrap,
          ),
          series: <CircularSeries>[
            PieSeries<DistributionSpending, String>(
              dataSource: data,
              startAngle: 100,
              endAngle: 100,
              pointRadiusMapper: (DistributionSpending data, _) =>
                  (data.radius).toString(),
              dataLabelSettings: const DataLabelSettings(
                labelIntersectAction: LabelIntersectAction.none,
                isVisible: true,
                labelPosition: ChartDataLabelPosition.outside,
              ),
              pointColorMapper: (DistributionSpending data, _) =>
                  data.categoryId.getColor(),
              xValueMapper: (DistributionSpending data, _) => "",
              yValueMapper: (DistributionSpending data, _) => data.percentage,
            ),
          ],
        ),
      ),
    );
  }
}
