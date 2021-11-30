import 'package:flutter/material.dart';
import 'package:fridayy_one/business_logic/models/pass_call_outcome.dart';
import 'package:fridayy_one/business_logic/models/spend_category_model.dart';
import 'package:fridayy_one/business_logic/models/spends_brand_model.dart';
import 'package:fridayy_one/business_logic/models/spends_transaction_model.dart';
import 'package:fridayy_one/business_logic/models/user_overview_model.dart';
import 'package:fridayy_one/business_logic/utils/api_constants.dart';
import 'package:fridayy_one/business_logic/utils/enums.dart';
import 'package:fridayy_one/business_logic/view_models/base_view_model.dart';
import 'package:fridayy_one/business_logic/view_models/home_view_models/home_screen_holder_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';

class SpendingScreenViewModel extends BaseModel {
  late PageController controller;
  final String title = "Spending Analysis";
  // SpendsTransactionModel spendsTransactionData =
  //     SpendsTransactionModel(totalAmount: 0, currency: "Rs", spends: []);
  // SpendCategoryModel spendCategoryData =
  //     SpendCategoryModel(totalSpend: 0, currency: "Rs", distribution: []);
  // SpendsBrandModel spendBrandData =
  //     SpendsBrandModel(totalSpend: 0, currency: "Rs", brands: []);
  // late String dateFilter;
  bool loadingTransactions = true;
  bool loadingCategories = true;
  bool loadingBrands = true;
  late int month;
  late String year;
  final List<String> years = [];
  int pageIndex = 0;
  late HomeScreenHolderViewModel homeModel;

  String get totalSpendAmount {
    if (pageIndex == 0) {
      return "Total Spent - ${homeModel.spendsTransactionData!.currency} ${homeModel.spendsTransactionData!.totalAmount.toStringAsFixed(1)}";
    } else if (pageIndex == 1) {
      return "Total Spent - ${homeModel.spendCategoryData!.currency} ${homeModel.spendCategoryData!.totalSpend.toStringAsFixed(1)}";
    } else {
      return "Total Spent - ${homeModel.spendBrandData!.currency} ${homeModel.spendBrandData!.totalSpend.toStringAsFixed(1)}";
    }
  }

  final List<DistributionSpending> categoryData = [];

  init(HomeScreenHolderViewModel model) async {
    homeModel = model;
    pageIndex = model.spendingPageIndex;
    print(pageIndex);
    controller = PageController(initialPage: pageIndex);
    final date = DateTime.now();
    month = date.month;
    year = date.year.toString().substring(2);
    homeModel.dateFilter ??=
        year + (month > 9 ? month.toString() : '0${month.toString()}');
    year = date.year.toString();
    for (int i = 2010; i <= DateTime.now().year; i++) {
      years.add(i.toString());
    }
    controller.addListener(() {
      pageIndex = controller.page?.round() ?? 0;
      homeModel.spendingPageIndex = pageIndex;
      fetchData();
      notifyListeners();
    });
    fetchData();
  }

  changeIndex(int index) {
    controller.jumpToPage(index);
  }

  fetchData({bool fetchRefresh = false}) {
    switch (pageIndex) {
      case 0:
        if (!homeModel.fetchedPage[pageIndex]) {
          getTransactionData();
        } else if (fetchRefresh) {
          getTransactionData();
        }
        break;
      case 1:
        if (!homeModel.fetchedPage[pageIndex]) {
          getCategoryData();
        } else if (fetchRefresh) {
          getCategoryData();
        }
        break;
      case 2:
        if (!homeModel.fetchedPage[pageIndex]) {
          getBrandData();
        } else if (fetchRefresh) {
          getBrandData();
        }
        break;
    }
  }

  setDate() {
    homeModel.dateFilter = year.substring(2) +
        (month > 9 ? month.toString() : '0${month.toString()}');
    notifyListeners();
    homeModel.spendsTransactionData = null;
    homeModel.spendCategoryData = null;
    homeModel.spendBrandData = null;
    homeModel.fetchedPage.clear();
    homeModel.fetchedPage.addAll([false, false, false]);
    fetchData(fetchRefresh: true);
  }

  Future getTransactionData() async {
    setState(ViewState.busy);
    final CallOutcome resultSpendingTransactions = await apiService.getRequest(
      "${ApiConstants.spendingTransactions}?month=${homeModel.dateFilter}",
    );
    if (resultSpendingTransactions.data != null) {
      homeModel.fetchedPage[0] = true;
      homeModel.spendsTransactionData = SpendsTransactionModel.fromJson(
        resultSpendingTransactions.data! as Map<String, dynamic>,
      );
    } else {
      // spendsTransactionData =
      //     SpendsTransactionModel(totalAmount: 0.0, currency: "Rs", spends: []);
    }
    if (homeModel.currentTabIndex == 2) {
      loadingTransactions = false;
      setState(ViewState.idle);
    }
  }

  Future getCategoryData() async {
    setState(ViewState.busy);
    final CallOutcome result = await apiService.getRequest(
      "${ApiConstants.spendingCategory}?month=${homeModel.dateFilter}",
    );
    if (result.data != null) {
      homeModel.fetchedPage[1] = true;
      homeModel.categoryData.clear();
      homeModel.spendCategoryData =
          SpendCategoryModel.fromJson(result.data as Map<String, dynamic>);
      homeModel.spendCategoryData!.distribution
          .sort((a, b) => b.percentage.compareTo(a.percentage));
      homeModel.spendCategoryData!.distribution.forEach((element) {
        homeModel.categoryData.add(
          DistributionSpending(
            categoryId: element.categoryId,
            percentage: element.percentage,
            count: element.count,
          ),
        );
      });
    } else {}
    if (homeModel.currentTabIndex == 2) {
      loadingCategories = false;
      setState(ViewState.idle);
    }
  }

  Future getBrandData() async {
    setState(ViewState.busy);
    final CallOutcome result = await apiService.getRequest(
      '${ApiConstants.spendingBrand}?month=${homeModel.dateFilter}',
    );
    if (result.data != null) {
      homeModel.fetchedPage[2] = true;
      homeModel.spendBrandData =
          SpendsBrandModel.fromJson(result.data as Map<String, dynamic>);
    } else {}
    if (homeModel.currentTabIndex == 2) {
      loadingBrands = false;
      setState(ViewState.idle);
    }
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
