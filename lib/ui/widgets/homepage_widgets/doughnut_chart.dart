import 'package:flutter/material.dart';
import 'package:fridayy_one/business_login/models/pie_chart_data.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DoughnutChart extends StatelessWidget {
  const DoughnutChart({
    Key? key,
    required this.data,
    required this.size,
    this.onTap,
  }) : super(key: key);
  final List<DoughnutChartData> data;
  final double size;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sizeConfig.getPropHeight(size),
      width: sizeConfig.getPropHeight(size),
      child: InkWell(
        onTap: onTap,
        child: SfCircularChart(
          margin: EdgeInsets.zero,
          series: <CircularSeries>[
            // Renders doughnut chart
            DoughnutSeries<DoughnutChartData, String>(
              dataSource: data,
              pointColorMapper: (DoughnutChartData data, _) => data.color,
              xValueMapper: (DoughnutChartData data, _) => data.x,
              yValueMapper: (DoughnutChartData data, _) => data.y,
            )
          ],
        ),
      ),
    );
  }
}
