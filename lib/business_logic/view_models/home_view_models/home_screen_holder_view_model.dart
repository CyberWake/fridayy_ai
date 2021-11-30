import 'package:flutter/cupertino.dart';
import 'package:fridayy_one/business_logic/models/offer_category_brands_model.dart';
import 'package:fridayy_one/business_logic/models/spend_category_model.dart';
import 'package:fridayy_one/business_logic/models/spends_brand_model.dart';
import 'package:fridayy_one/business_logic/models/spends_transaction_model.dart';
import 'package:fridayy_one/business_logic/models/user_overview_model.dart';
import 'package:fridayy_one/business_logic/utils/fridayy_svg.dart';
import 'package:fridayy_one/business_logic/view_models/base_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';

class HomeScreenHolderViewModel extends BaseModel {
  late PageController controller;
  UserOverView? userOverView;
  UserOverView? shortPolledOverView;
  int overViewActiveCard = 0;
  List<OfferCategoryBrands> offersOfCategory = [
    OfferCategoryBrands(brands: []),
    OfferCategoryBrands(brands: []),
    OfferCategoryBrands(brands: []),
    OfferCategoryBrands(brands: []),
    OfferCategoryBrands(brands: []),
    OfferCategoryBrands(brands: []),
    OfferCategoryBrands(brands: []),
    OfferCategoryBrands(brands: []),
  ];
  int offerCategoryIndex = 0;
  SpendsTransactionModel? spendsTransactionData;
  SpendCategoryModel? spendCategoryData;
  SpendsBrandModel? spendBrandData;
  List<DistributionSpending> categoryData = [];
  final List<bool> fetchedPage = [false, false, false];
  String? dateFilter;
  int spendingPageIndex = 0;
  User? user;

  final List<String> tabs = [
    FridayySvg.homeIcon,
    FridayySvg.offerIcon,
    FridayySvg.activityIcon,
    FridayySvg.profileIcon,
  ];

  int currentTabIndex = 0;
  init(int pageIndex) {
    controller = PageController(initialPage: pageIndex);
    currentTabIndex = pageIndex;
  }

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
