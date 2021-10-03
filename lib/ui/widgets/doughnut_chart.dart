import 'package:flutter/material.dart';
import 'package:fridayy_one/business_login/models/user_overview_model.dart';
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

  String? getName(String id) {
    switch (id) {
      case 'FAD':
        return 'Food & Drinks';
      case 'MDCL':
        return 'Medical';
      case 'UTL':
        return 'Utilities';
      case 'TRVL':
        return 'Travel';
      case 'LUX':
        return 'Shopping';
      case 'FIN':
        return 'Finance';
      case 'OTH':
        return 'Others';
      case 'EAD':
        return 'Education & Development';
    }
  }

  Color? getColor(String id) {
    switch (id) {
      case 'FAD':
        return const Color(0xFFF86F34);
      case 'MDCL':
        return const Color(0xFF2128BD);
      case 'UTL':
        return const Color(0xFF75CDD3);
      case 'TRVL':
        return const Color(0xFFFFB731);
      case 'LUX':
        return const Color(0xFF16331C);
      case 'FIN':
        return const Color(0xFF0A8677);
      case 'OTH':
        return const Color(0xFFC61C1C);
      case 'EAD':
        return const Color(0xFF14EDAA);
    }
  }

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
            DoughnutSeries<Distribution, String>(
              dataSource: data,
              pointColorMapper: (Distribution data, _) =>
                  getColor(data.categoryId),
              xValueMapper: (Distribution data, _) => getName(data.categoryId),
              yValueMapper: (Distribution data, _) => data.percentage,
            ),
          ],
        ),
      ),
    );
  }
}
