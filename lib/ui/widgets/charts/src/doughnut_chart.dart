import 'package:flutter/material.dart';
import 'package:fridayy_one/business_logic/models/new_models/new_user_overview_model.dart';
import 'package:fridayy_one/business_logic/utils/extensions.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DoughnutChart extends StatelessWidget {
  const DoughnutChart({
    Key? key,
    required this.data,
    required this.size,
    this.onTap,
  }) : super(key: key);
  final List<Distribution> data;
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
            DoughnutSeries<Distribution, String>(
              innerRadius: '70%',
              startAngle: 270,
              endAngle: 90,
              dataSource: data,
              pointColorMapper: (Distribution data, _) =>
                  data.categoryId.getColor(),
              xValueMapper: (Distribution data, _) => data.categoryId.getName(),
              yValueMapper: (Distribution data, _) => data.percentage,
              dataLabelMapper: (Distribution data, _) => data.count.toString(),
              dataLabelSettings: const DataLabelSettings(
                isVisible: true,
                labelIntersectAction: LabelIntersectAction.none,
                labelAlignment: ChartDataLabelAlignment.top,
                labelPosition: ChartDataLabelPosition.outside,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
