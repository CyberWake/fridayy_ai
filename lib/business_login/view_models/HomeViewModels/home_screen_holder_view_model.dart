import 'package:flutter/cupertino.dart';
import 'package:fridayy_one/business_login/utils/fridayy_svg.dart';
import 'package:fridayy_one/business_login/utils/routing_constants.dart';
import 'package:fridayy_one/business_login/view_models/base_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';

class HomeScreenHolderViewModel extends BaseModel {
  final PageController pageController = PageController(initialPage: 0);
  final List<String> tabs = [
    FridayySvg.homeIcon,
    FridayySvg.offerIcon,
    FridayySvg.activityIcon,
    FridayySvg.chartIcon,
    FridayySvg.profileIcon,
  ];
  final List<String> pageTitle = [
    "Home",
    "Offers",
    "Spending Analysis",
    "InDev",
    "Profile"
  ];

  int currentTabIndex = 0;

  void init() {
    pageController.addListener(() {
      currentTabIndex = pageController.page!.round();
      notifyListeners();
    });
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
    navigationService.pushScreen(Routes.toBeMade, arguments: 'Notifications');
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
    pageController.animateToPage(
      3,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
  }
}
