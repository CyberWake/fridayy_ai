import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fridayy_one/business_login/models/pie_chart_data.dart';
import 'package:fridayy_one/business_login/models/user_overview_model.dart';
import 'package:fridayy_one/business_login/utils/api_constants.dart';
import 'package:fridayy_one/business_login/utils/enums.dart';
import 'package:fridayy_one/business_login/utils/routing_constants.dart';
import 'package:fridayy_one/business_login/view_models/base_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';

class HomeScreenViewModel extends BaseModel {
  UserOverView userOverView = UserOverView(
    user: User(userName: ''),
    offer: Offer(
      notifiedOffers: [],
      offersExpiring: 0,
      totalOffers: 0,
      activeOffers: 0,
    ),
    spending: Spending(month: '', currency: '', amount: 0, distribution: []),
    financial: Financial(percentile: 0),
  );

  final List<Distribution> datanew = [
    Distribution(categoryId: "FAD", percentage: 3.1),
    Distribution(categoryId: "MDCL", percentage: 4.9),
    Distribution(categoryId: "UTL", percentage: 42.9),
    Distribution(categoryId: "TRVL", percentage: 18.4),
    Distribution(categoryId: "LUX", percentage: 0.0),
    Distribution(categoryId: "FIN", percentage: 30.7),
    Distribution(categoryId: "OTH", percentage: 0.9),
    Distribution(categoryId: "EAD", percentage: 0.0),
  ];

  final List<DoughnutChartData> data = [
    DoughnutChartData(
      'Utilities',
      42.9,
      const Color(0xFF75CDD3),
    ),
    DoughnutChartData(
      'Payments',
      30.7,
      const Color(0xFF0A8677),
    ),
    DoughnutChartData(
      'Travel',
      18.4,
      const Color(0xFFFFB731),
    ),
    DoughnutChartData(
      'Medical',
      4.9,
      const Color(0xFF2128BD),
    ),
    DoughnutChartData(
      'Food & Drinks',
      3.1,
      const Color(0xFFF86F34),
    ),
    DoughnutChartData(
      'Unknown',
      0.9,
      const Color(0xFFC61C1C),
    ),
  ];

  final double totalOffers = 2000;
  final double activeOffers = 1745;
  final double expiredOffers = 255;

  init() async {
    setState(ViewState.busy);
    final result = await apiService.getRequest(ApiConstants.userOverview);
    if (result != null) {
      userOverView = UserOverView.fromJson(result as Map<String, dynamic>);
      notifyListeners();
    }
  }

  void gotoActiveOffers() {
    navigationService.pushScreen(Routes.toBeMade, arguments: 'Active Offers');
  }

  void gotoExpiredOffers() {
    navigationService.pushScreen(Routes.toBeMade, arguments: 'Expired Offers');
  }
}
