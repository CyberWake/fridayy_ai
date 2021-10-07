import 'package:flutter/material.dart';
import 'package:fridayy_one/business_login/models/spending_brands_model.dart';
import 'package:fridayy_one/business_login/models/spending_category_model.dart';
import 'package:fridayy_one/business_login/models/spending_transaction_model.dart';
import 'package:fridayy_one/business_login/models/user_overview_model.dart';
import 'package:fridayy_one/business_login/utils/api_constants.dart';
import 'package:fridayy_one/business_login/utils/enums.dart';
import 'package:fridayy_one/business_login/view_models/base_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';

class SpendingScreenViewModel extends BaseModel {
  final String title = "Spending Analysis";
  SpendingTransactionModel data =
      SpendingTransactionModel(amount: 0, count: 0, spends: []);
  final List<SpendingCategoryModel> spendCategoryData = [];
  final List<SpendingBrandModel> spendBrandData = [];
  late String dateFilter;
  late int month;
  late String year;
  final List<String> years = [];

  final List<Distribution> categoryData = [];

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
    data = SpendingTransactionModel(amount: 0, count: 0, spends: []);
    final resultSpendingTransactions = await apiService
        .getRequest("${ApiConstants.spendingTransactions}/$dateFilter");
    if (resultSpendingTransactions != null) {
      data = SpendingTransactionModel.fromJson(
        resultSpendingTransactions as Map<String, dynamic>,
      );
    } else {
      data = SpendingTransactionModel(amount: 0.0, count: 0, spends: []);
    }
    setState(ViewState.idle);
  }

  Future getCategoryData() async {
    setState(ViewState.busy);
    double totalAmount = 0;
    spendCategoryData.clear();
    categoryData.clear();
    final result = await apiService.getRequest(
      "${ApiConstants.spendingCategory}/?date=$dateFilter",
    );
    if (result != null) {
      (result['result'] as List).forEach((element) {
        spendCategoryData.add(
          SpendingCategoryModel.fromJson(element as Map<String, dynamic>),
        );
        totalAmount += spendCategoryData.last.amount;
      });
      spendCategoryData.forEach((element) {
        categoryData.add(
          Distribution(
            categoryId: element.categoryId,
            percentage: (element.amount / totalAmount) * 100,
          ),
        );
      });
    }
    setState(ViewState.idle);
  }

  Future getBrandData() async {
    setState(ViewState.busy);
    spendBrandData.clear();
    final result = await apiService
        .getRequest('${ApiConstants.spendingBrand}?date=$dateFilter');
    if (result != null) {
      (result['result'] as List).forEach((element) {
        spendBrandData
            .add(SpendingBrandModel.fromJson(element as Map<String, dynamic>));
      });
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
