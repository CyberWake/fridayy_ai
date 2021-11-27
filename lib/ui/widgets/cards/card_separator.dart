import 'package:flutter/material.dart';
import 'package:fridayy_one/services/service_locator.dart';

class CardSeparator extends StatelessWidget {
  const CardSeparator({Key? key, required this.color}) : super(key: key);
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: sizeConfig.getPropWidth(20),
      ),
      child: Divider(
        thickness: 1.5,
        color: color,
      ),
    );
  }
}
