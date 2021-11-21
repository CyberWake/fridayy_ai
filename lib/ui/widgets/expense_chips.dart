import 'package:flutter/material.dart';
import 'package:fridayy_one/business_logic/models/new_user_overview_model.dart';
import 'package:fridayy_one/services/service_locator.dart';

class ExpenseChips extends StatelessWidget {
  const ExpenseChips({Key? key, required this.data}) : super(key: key);
  final List<Distribution> data;

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

  Color getColor(String id) {
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
      default:
        return const Color(0xFFFFFFFF);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sizeConfig.getPropWidth(148),
      width: sizeConfig.getPropWidth(300),
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        itemCount: data.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return Container(
            alignment: Alignment.centerLeft,
            child: Chip(
              labelPadding: EdgeInsets.zero,
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 10,
                    width: 10,
                    margin: const EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                        color: getColor(data[index].categoryId),
                        shape: BoxShape.circle),
                  ),
                  Flexible(
                    child: Text(
                      "${data[index].percentage.toString()}% ${getName(data[index].categoryId)}",
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 12, color: Colors.black),
                    ),
                  ),
                ],
              ),
              backgroundColor: getColor(""),
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: getColor(data[index].categoryId), width: 1),
                borderRadius: BorderRadius.circular(20),
              ),
              shadowColor: Colors.grey[60],
              padding: EdgeInsets.symmetric(
                vertical: 0,
                horizontal: sizeConfig.getPropWidth(8),
              ),
            ),
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 10 / 2.5,
          crossAxisSpacing: 36,
          mainAxisSpacing: 20,
        ),
      ),
    );
  }
}
