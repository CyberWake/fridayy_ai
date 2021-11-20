import 'package:flutter/material.dart';
import 'package:fridayy_one/business_logic/view_models/base_view_model.dart';

class OnBoardingScreenViewModel extends BaseModel {
  PageController controller = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void init() {}
}
