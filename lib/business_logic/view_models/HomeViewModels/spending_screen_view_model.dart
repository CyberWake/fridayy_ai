import 'package:flutter/material.dart';
import 'package:fridayy_one/business_logic/models/new_models/new_user_overview_model.dart';
import 'package:fridayy_one/business_logic/models/new_models/spend_category_model.dart';
import 'package:fridayy_one/business_logic/models/new_models/spends_brand_model.dart';
import 'package:fridayy_one/business_logic/models/new_models/spends_transaction_model.dart';
import 'package:fridayy_one/business_logic/models/pass_call_outcome.dart';
import 'package:fridayy_one/business_logic/utils/api_constants.dart';
import 'package:fridayy_one/business_logic/utils/enums.dart';
import 'package:fridayy_one/business_logic/view_models/base_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';

class SpendingScreenViewModel extends BaseModel {
  final String title = "Spending Analysis";
  SpendsTransactionModel data =
      SpendsTransactionModel(totalAmount: 0, currency: "Rs", spends: []);
  late SpendCategoryModel spendCategoryData;
  late SpendsBrandModel spendBrandData;
  late String dateFilter;
  late int month;
  late String year;
  final List<String> years = [];

  final List<DistributionSpending> categoryData = [];

  final List<List> dataCategory = [
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    [],
  ];

  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  init() async {
    final date = DateTime.now();
    month = date.month;
    year = date.year.toString().substring(2);
    dateFilter = year + (month > 9 ? month.toString() : '0${month.toString()}');
    year = date.year.toString();
    for (int i = 2010; i <= DateTime.now().year; i++) {
      years.add(i.toString());
    }
    getData();
  }

  getData() async {
    await getTransactionData();
    await getCategoryData();
    await getBrandData();
  }

  setDate() {
    dateFilter = year.substring(2) +
        (month > 9 ? month.toString() : '0${month.toString()}');
    notifyListeners();
    getData();
  }

  Future getTransactionData() async {
    setState(ViewState.busy);
    data = SpendsTransactionModel(totalAmount: 0, currency: "Rs", spends: []);
    final CallOutcome resultSpendingTransactions = await apiService
        .getRequest("${ApiConstants.spendingTransactions}?month=$dateFilter");
    if (resultSpendingTransactions.data != null) {
      data = SpendsTransactionModel.fromJson(
        resultSpendingTransactions.data! as Map<String, dynamic>,
      );
    } else {
      data =
          SpendsTransactionModel(totalAmount: 0.0, currency: "Rs", spends: []);
    }
    setState(ViewState.idle);
  }

  Future getCategoryData() async {
    print('here1');
    setState(ViewState.busy);
    categoryData.clear();
    final CallOutcome result = await apiService.getRequest(
      "${ApiConstants.spendingCategory}?month=$dateFilter",
    );
    print('here');
    if (result.data != null) {
      print(result.data);
      spendCategoryData =
          SpendCategoryModel.fromJson(result.data as Map<String, dynamic>);
      spendCategoryData.distribution.forEach((element) {
        categoryData.add(
          DistributionSpending(
            categoryId: element.categoryId,
            percentage: element.percentage,
            count: element.count,
          ),
        );
      });
    } else {
      print(result.exception);
    }
    setState(ViewState.idle);
  }

  Future getBrandData() async {
    setState(ViewState.busy);
    final CallOutcome result = await apiService
        .getRequest('${ApiConstants.spendingBrand}?month=$dateFilter');
    if (result.data != null) {
      spendBrandData =
          SpendsBrandModel.fromJson(result.data as Map<String, dynamic>);
    } else {
      print(result.exception);
    }
    setState(ViewState.idle);
  }

  void changeDateTimeFilter(Widget widget) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(sizeConfig.getPropWidth(16)),
          topRight: Radius.circular(sizeConfig.getPropWidth(16)),
        ),
      ),
      constraints: BoxConstraints(
        maxWidth: sizeConfig.getPropWidth(379),
        maxHeight: sizeConfig.getPropHeight(233),
      ),
      context: navigationService.navigatorKey.currentContext!,
      builder: (context) => widget,
    );
  }
}
