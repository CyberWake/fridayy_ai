import 'package:flutter/material.dart';
import 'package:fridayy_one/services/size_config/size_config_service.dart';

class SizeConfigImpl implements SizeConfig {
  static double screenWidth = 0.0;
  static double screenHeight = 0.0;
  double dp = 0.0;

  @override
  void init(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    dp = screenWidth / 160;
  }

  double getPropHeight(double staticHeight) {
    return screenHeight * (staticHeight / 823);
  }

  double getPropWidth(double staticWidth) {
    return screenWidth * (staticWidth / 411);
  }
}
