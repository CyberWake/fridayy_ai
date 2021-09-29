import 'dart:ui';

import 'package:fridayy_one/business_login/models/coupon_data.dart';
import 'package:fridayy_one/business_login/models/pie_chart_data.dart';
import 'package:fridayy_one/business_login/utils/routing_constants.dart';
import 'package:fridayy_one/business_login/view_models/base_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';

class HomeScreenViewModel extends BaseModel {
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

  void gotoActiveOffers() {
    navigationService.pushScreen(Routes.toBeMade, arguments: 'Active Offers');
  }

  void gotoExpiredOffers() {
    navigationService.pushScreen(Routes.toBeMade, arguments: 'Expired Offers');
  }
}
