import 'package:flutter/material.dart';
import 'package:fridayy_one/business_logic/models/user_overview_model.dart';
import 'package:fridayy_one/business_logic/utils/extensions.dart';
import 'package:fridayy_one/services/service_locator.dart';

class ExpenseChips extends StatelessWidget {
  const ExpenseChips({Key? key, required this.data}) : super(key: key);
  final List<DistributionSpending> data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sizeConfig.getPropWidth(148),
      width: sizeConfig.getPropWidth(335),
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return Chip(
            labelPadding: EdgeInsets.zero,
            label: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  height: 10,
                  width: 10,
                  margin: const EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                    color: data[index].categoryId.getColor(),
                    shape: BoxShape.circle,
                  ),
                ),
                Flexible(
                  child: Text(
                    "${data[index].percentage.toStringAsFixed(1)}% ${data[index].categoryId.getName()}",
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontSize: 12, color: Colors.black),
                  ),
                ),
              ],
            ),
            backgroundColor: ''.getColor(),
            elevation: 0.0,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: data[index].categoryId.getColor(),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            shadowColor: Colors.grey[60],
            padding: EdgeInsets.all(
              sizeConfig.getPropHeight(8),
            ),
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2.5 / 8,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}
