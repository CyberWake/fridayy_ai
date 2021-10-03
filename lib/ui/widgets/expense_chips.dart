import 'package:flutter/material.dart';
import 'package:fridayy_one/business_login/models/user_overview_model.dart';
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
      height: sizeConfig.getPropWidth(36),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Chip(
            labelPadding: EdgeInsets.zero,
            label: Text(
              "${data[index].percentage.round().toString()}% ${getName(data[index].categoryId)}",
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontSize: 12, color: Colors.white),
            ),
            backgroundColor: getColor(data[index].categoryId),
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
