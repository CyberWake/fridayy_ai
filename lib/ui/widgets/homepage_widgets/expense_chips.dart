import 'package:flutter/material.dart';
import 'package:fridayy_one/business_login/models/pie_chart_data.dart';
import 'package:fridayy_one/services/service_locator.dart';

class ExpenseChips extends StatelessWidget {
  const ExpenseChips({Key? key, required this.data}) : super(key: key);
  final List<DoughnutChartData> data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sizeConfig.getPropWidth(36),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Chip(
            labelPadding: EdgeInsets.zero,
            label: Text(
              "${data[index].y.toInt().toString()}% ${data[index].x}",
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontSize: 12, color: Colors.white),
            ),
            backgroundColor: data[index].color,
            elevation: 0.0,
            shadowColor: Colors.grey[60],
            padding: EdgeInsets.symmetric(
              vertical: 0,
              horizontal: sizeConfig.getPropWidth(12),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => SizedBox(
          width: sizeConfig.getPropWidth(8),
        ),
      ),
    );
  }
}
