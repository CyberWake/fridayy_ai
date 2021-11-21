import 'package:flutter/material.dart';
import 'package:fridayy_one/business_logic/models/new_user_overview_model.dart';
import 'package:fridayy_one/business_logic/utils/extensions.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarChart extends StatelessWidget {
  const BarChart({Key? key, required this.data, required this.showLabel})
      : super(key: key);
  final List<SortedCategories> data;
  final bool showLabel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: SfCartesianChart(
          margin: EdgeInsets.zero,
          plotAreaBorderWidth: 0.0,
          primaryXAxis: CategoryAxis(
            isVisible: false,
          ),
          primaryYAxis: NumericAxis(
            minimum: 0,
            maximum: data.last.count.toDouble() + 5,
            isVisible: false,
          ),
          legend: Legend(
            isVisible: false,
            overflowMode: LegendItemOverflowMode.wrap,
            alignment: ChartAlignment.center,
          ),
          series: <BarSeries<SortedCategories, String>>[
            if (showLabel)
              BarSeries<SortedCategories, String>(
                dataSource: data,
                borderRadius:
                    const BorderRadius.horizontal(right: Radius.circular(10)),
                pointColorMapper: (SortedCategories data, _) =>
                    data.categoryId.getColor(),
                xValueMapper: (SortedCategories data, _) =>
                    data.categoryId.getName(),
                yValueMapper: (SortedCategories data, _) => data.count,
                dataLabelSettings: const DataLabelSettings(
                  labelAlignment: ChartDataLabelAlignment.bottom,
                  isVisible: true,
                ),
                dataLabelMapper: (SortedCategories data, _) =>
                    data.categoryId.getName(),
              ),
            if (!showLabel)
              BarSeries<SortedCategories, String>(
                dataSource: data,
                borderRadius:
                    const BorderRadius.horizontal(right: Radius.circular(10)),
                pointColorMapper: (SortedCategories data, _) =>
                    data.categoryId.getColor(),
                xValueMapper: (SortedCategories data, _) =>
                    data.categoryId.getName(),
                yValueMapper: (SortedCategories data, _) => data.count,
                dataLabelSettings: const DataLabelSettings(
                  isVisible: true,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
