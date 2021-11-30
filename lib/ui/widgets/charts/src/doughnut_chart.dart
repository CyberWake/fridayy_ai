import 'package:flutter/material.dart';
import 'package:fridayy_one/business_logic/models/user_overview_model.dart';
import 'package:fridayy_one/business_logic/utils/extensions.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DoughnutChart extends StatelessWidget {
  const DoughnutChart({
    Key? key,
    required this.data,
    required this.size,
    this.isSemiDonut = true,
  }) : super(key: key);
  final List<DistributionSpending> data;
  final double size;
  final bool isSemiDonut;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sizeConfig.getPropHeight(size),
      width: sizeConfig.getPropHeight(size),
      child: SfCircularChart(
        margin: EdgeInsets.zero,
        series: <CircularSeries>[
          DoughnutSeries<DistributionSpending, String>(
            innerRadius: isSemiDonut ? '70%' : '50%',
            startAngle: isSemiDonut ? 270 : 0,
            endAngle: isSemiDonut ? 90 : 0,
            dataSource: data,
            pointColorMapper: (DistributionSpending data, _) =>
                data.categoryId.getColor(),
            xValueMapper: (DistributionSpending data, _) =>
                data.categoryId.getName(),
            yValueMapper: (DistributionSpending data, _) => data.percentage,
            dataLabelMapper: (DistributionSpending data, _) => isSemiDonut
                ? data.count.toString()
                : data.percentage.toStringAsFixed(1),
            dataLabelSettings: DataLabelSettings(
              isVisible: false,
              labelIntersectAction: LabelIntersectAction.hide,
              labelAlignment: ChartDataLabelAlignment.top,
              labelPosition: isSemiDonut
                  ? ChartDataLabelPosition.inside
                  : ChartDataLabelPosition.outside,
            ),
          ),
        ],
      ),
    );
  }
}
