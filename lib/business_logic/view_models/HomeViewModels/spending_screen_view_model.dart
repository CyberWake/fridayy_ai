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
  final PageController controller = PageController(initialPage: 0);
  final String title = "Spending Analysis";
  SpendsTransactionModel spendsTransactionData =
      SpendsTransactionModel(totalAmount: 0, currency: "Rs", spends: []);
  SpendCategoryModel spendCategoryData =
      SpendCategoryModel(totalSpend: 0, currency: "Rs", distribution: []);
  SpendsBrandModel spendBrandData =
      SpendsBrandModel(totalSpend: 0, currency: "Rs", brands: []);
  late String dateFilter;
  late int month;
  late String year;
  final List<String> years = [];
  final List<bool> fetchedPage = [false, false, false];
  int pageIndex = 0;

  String get totalSpendAmount {
    if (pageIndex == 0) {
      return "Total Spent - ${spendsTransactionData.currency} ${spendsTransactionData.totalAmount}";
    } else if (pageIndex == 1) {
      return "Total Spent - ${spendCategoryData.currency} ${spendCategoryData.totalSpend}";
    } else {
      return "Total Spent - ${spendBrandData.currency} ${spendBrandData.totalSpend}";
    }
  }

  final List<DistributionSpending> categoryData = [];
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
    controller.addListener(() {
      pageIndex = controller.page?.round() ?? 0;
      fetchData();
      notifyListeners();
    });
  }

  changeIndex(int index) {
    controller.jumpToPage(index);
  }

  fetchData({bool fetchRefresh = false}) {
    switch (pageIndex) {
      case 0:
        if (!fetchedPage[pageIndex]) {
          getTransactionData();
        } else if (fetchRefresh) {
          getTransactionData();
        }
        break;
      case 1:
        if (!fetchedPage[pageIndex]) {
          getCategoryData();
        } else if (fetchRefresh) {
          getCategoryData();
        }
        break;
      case 2:
        if (!fetchedPage[pageIndex]) {
          getBrandData();
        } else if (fetchRefresh) {
          getBrandData();
        }
        break;
    }
  }

  setDate() {
    dateFilter = year.substring(2) +
        (month > 9 ? month.toString() : '0${month.toString()}');
    notifyListeners();
    fetchedPage.clear();
    fetchedPage.addAll([false, false, false]);
    fetchData(fetchRefresh: true);
  }

  Future getTransactionData() async {
    setState(ViewState.busy);
    spendsTransactionData =
        SpendsTransactionModel(totalAmount: 0, currency: "Rs", spends: []);
    final CallOutcome resultSpendingTransactions = await apiService
        .getRequest("${ApiConstants.spendingTransactions}?month=$dateFilter");
    if (resultSpendingTransactions.data != null) {
      fetchedPage[0] = true;
      spendsTransactionData = SpendsTransactionModel.fromJson(
        resultSpendingTransactions.data! as Map<String, dynamic>,
      );
    } else {
      spendsTransactionData =
          SpendsTransactionModel(totalAmount: 0.0, currency: "Rs", spends: []);
    }
    setState(ViewState.idle);
  }

  Future getCategoryData() async {
    setState(ViewState.busy);
    final CallOutcome result = await apiService.getRequest(
      "${ApiConstants.spendingCategory}?month=$dateFilter",
    );
    if (result.data != null) {
      fetchedPage[1] = true;
      categoryData.clear();
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
    } else {}
    setState(ViewState.idle);
  }

  Future getBrandData() async {
    setState(ViewState.busy);
    final CallOutcome result = await apiService
        .getRequest('${ApiConstants.spendingBrand}?month=$dateFilter');
    if (result.data != null) {
      fetchedPage[2] = true;
      spendBrandData =
          SpendsBrandModel.fromJson(result.data as Map<String, dynamic>);
    } else {}
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
