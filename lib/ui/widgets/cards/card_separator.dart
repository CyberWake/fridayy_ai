import 'package:flutter/material.dart';
import 'package:fridayy_one/services/service_locator.dart';

class CardSeparator extends StatelessWidget {
  const CardSeparator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: sizeConfig.getPropWidth(20),
      ),
      child: const Divider(),
    );
  }
}
