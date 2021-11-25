import 'package:flutter/cupertino.dart';
import 'package:fridayy_one/business_logic/utils/fridayy_svg.dart';
import 'package:fridayy_one/business_logic/view_models/base_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';

class HomeScreenHolderViewModel extends BaseModel {
  final PageController controller = PageController();
  int offerCategoryIndex = 0;
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

  int currentTabIndex = 0;

  void tabChanged(int newTabIndex) {
    currentTabIndex = newTabIndex;
    controller.jumpToPage(currentTabIndex);
    notifyListeners();
  }

  void newPage(int pageIndex) {
    currentTabIndex = pageIndex;
    notifyListeners();
  }

  void gotoNotifications() {
    navigationService.showSnackBar('No new notifications');
  }

  void gotoEditProfile() {
    navigationService.showSnackBar('Coming Soon');
  }

  void gotoProfile() {
    currentTabIndex = 3;
    controller.jumpToPage(currentTabIndex);
    notifyListeners();
  }

  void gotoOffers(int categoryIndex) {
    currentTabIndex = 1;
    offerCategoryIndex = categoryIndex;
    controller.jumpToPage(currentTabIndex);
    notifyListeners();
  }

  void gotoSpendingBehaviour() {
    currentTabIndex = 2;
    controller.jumpToPage(currentTabIndex);
    notifyListeners();
  }

  void gotoFinanceAnalytics() {
    navigationService.showSnackBar('Coming Soon');
  }
}
