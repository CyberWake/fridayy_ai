import 'package:flutter/material.dart';
import 'package:fridayy_one/business_logic/models/new_user_overview_model.dart';
import 'package:fridayy_one/business_logic/utils/extensions.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarChart extends StatelessWidget {
  BarChart({Key? key, required this.chartData, required this.gotoOffer})
      : super(key: key);
  final List<SortedCategories> chartData;
  final Function(int) gotoOffer;

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
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
        child: SfCartesianChart(
          margin: EdgeInsets.zero,
          plotAreaBorderWidth: 0.0,
          primaryXAxis: CategoryAxis(
            isVisible: false,
          ),
          primaryYAxis: NumericAxis(
            minimum: 0,
            maximum: chartData.last.count.toDouble() + 5,
            isVisible: false,
          ),
          legend: Legend(
            isVisible: false,
            overflowMode: LegendItemOverflowMode.wrap,
            alignment: ChartAlignment.center,
          ),
          series: <BarSeries<SortedCategories, String>>[
            BarSeries<SortedCategories, String>(
              width: 1,
              dataSource: chartData,
              borderRadius:
                  const BorderRadius.horizontal(right: Radius.circular(10)),
              onPointTap: (ChartPointDetails data) {
                if (data.pointIndex != null) {
                  gotoOffer(chartData[data.pointIndex!].categoryId.getIndex());
                } // gotoOffer();
              },
              pointColorMapper: (SortedCategories data, _) => backgroundColor[
                  chartData.indexWhere((element) => element == data)],
              xValueMapper: (SortedCategories data, _) =>
                  data.categoryId.getName(),
              yValueMapper: (SortedCategories data, _) => data.count,
              dataLabelSettings: const DataLabelSettings(
                isVisible: true,
                labelAlignment: ChartDataLabelAlignment.top,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
