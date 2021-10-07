import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fridayy_one/business_login/utils/enums.dart';
import 'package:fridayy_one/business_login/utils/fridayy_svg.dart';
import 'package:fridayy_one/business_login/view_models/base_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';

class HomeScreenHolderViewModel extends BaseModel {
  final List<String> tabs = [
    FridayySvg.homeIcon,
    FridayySvg.offerIcon,
    FridayySvg.activityIcon,
    FridayySvg.profileIcon,
  ];
  final List<String> pageTitle = [
    "Home",
    "Offers",
    "Spending Analysis",
    "Profile"
  ];

  List brandData = [];
  int currentTabIndex = 0;

  init() async {
    setState(ViewState.busy);
    final String data = await DefaultAssetBundle.of(
      navigationService.navigatorKey.currentContext!,
    ).loadString("assets/brand_data.json");
    brandData = jsonDecode(data) as List;
    setState(ViewState.idle);
  }

  void tabChanged(int newTabIndex) {
    currentTabIndex = newTabIndex;
    notifyListeners();
  }

  void gotoNotifications() {
    navigationService.showSnackBar('No new notifications');
  }

  void gotoProfile() {
    currentTabIndex = 3;
    notifyListeners();
  }

  void gotoOffers() {
    currentTabIndex = 1;
    notifyListeners();
  }

  void gotoSpendingBehaviour() {
    currentTabIndex = 2;
    notifyListeners();
  }

  void gotoFinanceAnalytics() {
    navigationService.showSnackBar('Coming Soon');
  }
}
