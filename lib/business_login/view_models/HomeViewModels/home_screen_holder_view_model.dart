import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fridayy_one/business_login/utils/enums.dart';
import 'package:fridayy_one/business_login/utils/fridayy_svg.dart';
import 'package:fridayy_one/business_login/view_models/base_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';

class HomeScreenHolderViewModel extends BaseModel {
  final PageController pageController = PageController(initialPage: 0);
  final List<String> tabs = [
    FridayySvg.homeIcon,
    FridayySvg.offerIcon,
    FridayySvg.activityIcon,
    // FridayySvg.chartIcon,
    FridayySvg.profileIcon,
  ];
  final List<String> pageTitle = [
    "Home",
    "Offers",
    "Spending Analysis",
    // "InDev",
    "Profile"
  ];

  List brandData = [];
  int currentTabIndex = 0;

  init() async {
    pageController.addListener(() {
      currentTabIndex = pageController.page!.round();
      notifyListeners();
    });
    setState(ViewState.busy);
    final String data = await DefaultAssetBundle.of(
      navigationService.navigatorKey.currentContext!,
    ).loadString("assets/brand_data.json");
    brandData = jsonDecode(data) as List;
    setState(ViewState.idle);
  }

  void tabChanged(int newTabIndex) {
    currentTabIndex = newTabIndex;
    pageController.animateToPage(
      currentTabIndex,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
    notifyListeners();
  }

  void gotoNotifications() {
    navigationService.showSnackBar('No new notifications');
  }

  void gotoProfile() {
    pageController.animateToPage(
      4,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
  }

  void gotoOffers() {
    pageController.animateToPage(
      1,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
  }

  void gotoSpendingBehaviour() {
    pageController.animateToPage(
      2,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
  }

  void gotoFinanceAnalytics() {
    navigationService.showSnackBar('Coming Soon');
  }
}
