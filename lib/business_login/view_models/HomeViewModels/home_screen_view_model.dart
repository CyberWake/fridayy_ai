import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:fridayy_one/business_login/models/coupon_data.dart';
import 'package:fridayy_one/business_login/models/pie_chart_data.dart';
import 'package:fridayy_one/business_login/utils/fridayy_svg.dart';
import 'package:fridayy_one/business_login/utils/routing_constants.dart';
import 'package:fridayy_one/business_login/view_models/base_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';

class HomeScreenViewModel extends BaseModel {
  final PageController pageController = PageController(initialPage: 0);
  final List<String> tabs = [
    FridayySvg.homeIcon,
    FridayySvg.offerIcon,
    FridayySvg.activityIcon,
    FridayySvg.chartIcon,
    FridayySvg.profileIcon,
  ];

  List<CouponData> couponData = [
    CouponData(
      couponBody: '',
      couponExpiry: DateTime(2021, 09, 23, 21, 00, 00),
      couponCode: 'A1B2C3',
      couponImage: '',
      company: 'Zomato',
    ),
    CouponData(
      couponBody: '',
      couponExpiry: DateTime(2021, 09, 23, 12, 00, 00),
      couponCode: 'A1B2C3',
      couponImage: '',
      company: 'Swiggy',
    ),
    CouponData(
      couponBody: '',
      couponExpiry: DateTime(2021, 09, 23, 8, 00, 00),
      couponCode: 'A1B2C3',
      couponImage: '',
      company: 'OLA',
    ),
    CouponData(
      couponBody: '',
      couponExpiry: DateTime(2021, 09, 23, 00, 00, 00),
      couponCode: 'A1B2C3',
      couponImage: '',
      company: 'UBER',
    ),
    CouponData(
      couponBody: '',
      couponExpiry: DateTime(2021, 09, 22, 23, 00, 00),
      couponCode: 'A1B2C3',
      couponImage: '',
      company: 'Paytm',
    ),
  ];

  final List<DoughnutChartData> data = [
    DoughnutChartData(
      'Food&Drinks',
      78,
      const Color(0xFFF86F34),
    ),
    DoughnutChartData(
      'Travel',
      16,
      const Color(0xFF005CEE),
    ),
    DoughnutChartData(
      'Utilities',
      6,
      const Color(0xFFFFB731),
    ),
  ];

  final double totalOffers = 2000;
  final double activeOffers = 1745;
  final double expiredOffers = 255;
  int currentTabIndex = 0;

  void init() {
    pageController.addListener(() {
      currentTabIndex = pageController.page!.round();
      notifyListeners();
    });
  }

  void tabChanged(int newTabIndex) {
    currentTabIndex = newTabIndex;
    pageController.animateToPage(currentTabIndex,
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    notifyListeners();
  }

  void gotoNotifications() {
    navigationService.pushScreen(Routes.toBeMade, arguments: 'Notifications');
  }

  void gotoProfile() {
    navigationService.pushScreen(Routes.toBeMade, arguments: 'Profile');
  }

  void gotoOffers() {
    navigationService.pushScreen(Routes.toBeMade, arguments: 'Offers');
  }

  void gotoActiveOffers() {
    navigationService.pushScreen(Routes.toBeMade, arguments: 'Active Offers');
  }

  void gotoExpiredOffers() {
    navigationService.pushScreen(Routes.toBeMade, arguments: 'Expired Offers');
  }

  void gotoSpendingBehaviour() {
    navigationService.pushScreen(
      Routes.toBeMade,
      arguments: 'Spending Behaviour',
    );
  }

  void gotoFinanceAnalytics() {
    navigationService.pushScreen(
      Routes.toBeMade,
      arguments: 'Finance Analytics',
    );
  }
}
