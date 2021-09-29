import 'dart:ui';

class DoughnutChartData {
  DoughnutChartData(
    this.x,
    this.y,
    this.color, {
    this.icon,
    this.spendAmount,
    this.spendTimes,
  });
  final String x;
  final double y;
  final Color color;
  final String? icon;
  final String? spendAmount;
  final int? spendTimes;
}
