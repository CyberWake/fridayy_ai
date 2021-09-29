import 'dart:ui';

import 'package:fridayy_one/business_login/models/brand_data.dart';
import 'package:fridayy_one/business_login/models/pie_chart_data.dart';
import 'package:fridayy_one/business_login/utils/fridayy_svg.dart';
import 'package:fridayy_one/business_login/view_models/base_view_model.dart';

class SpendingScreenViewModel extends BaseModel {
  final String title = "Spending Analysis";
  final List<DoughnutChartData> categoryData = [
    DoughnutChartData(
      'Utilities',
      42.9,
      const Color(0xFF75CDD3),
      icon: FridayySvg.utilitiesIcon,
      spendAmount: '33366.66',
      spendTimes: 20,
    ),
    DoughnutChartData(
      'Payments',
      30.7,
      const Color(0xFF0A8677),
      icon: FridayySvg.foodIcon,
      spendAmount: '23877.77',
      spendTimes: 15,
    ),
    DoughnutChartData(
      'Travel',
      18.4,
      const Color(0xFFFFB731),
      icon: FridayySvg.travelIcon,
      spendAmount: '14311.11',
      spendTimes: 10,
    ),
    DoughnutChartData(
      'Medical',
      4.9,
      const Color(0xFF2128BD),
      icon: FridayySvg.medicineIcon,
      spendAmount: '3811.11',
      spendTimes: 5,
    ),
    DoughnutChartData(
      'Food & Drinks',
      3.1,
      const Color(0xFFF86F34),
      icon: FridayySvg.foodIcon,
      spendAmount: '2411.11',
      spendTimes: 4,
    ),
    DoughnutChartData(
      'Unknown',
      0.9,
      const Color(0xFFC61C1C),
      icon: FridayySvg.foodIcon,
      spendAmount: '700',
      spendTimes: 2,
    ),
  ];

  final List<BrandData> brandData = [
    BrandData(
      brandCategory: 'Food & Drinks',
      brandName: 'Zomato',
      brandSpendTimes: '7',
    ),
    BrandData(
      brandCategory: 'Food & Drinks',
      brandName: 'Swiggy',
      brandSpendTimes: '7',
    ),
    BrandData(
      brandCategory: 'Travel',
      brandName: 'Uber',
      brandSpendTimes: '7',
    ),
    BrandData(
      brandCategory: 'Medical',
      brandName: 'Apollo',
      brandSpendTimes: '7',
    ),
    BrandData(
      brandCategory: 'Payment',
      brandName: 'Airtel',
      brandSpendTimes: '7',
    ),
    BrandData(
      brandCategory: 'Unknown',
      brandName: 'Myntra',
      brandSpendTimes: '7',
    ),
  ];
}
