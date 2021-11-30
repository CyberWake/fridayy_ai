import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fridayy_one/business_logic/models/offer_category_brands_model.dart';
import 'package:fridayy_one/business_logic/models/pass_call_outcome.dart';
import 'package:fridayy_one/business_logic/utils/api_constants.dart';
import 'package:fridayy_one/business_logic/utils/enums.dart';
import 'package:fridayy_one/business_logic/utils/routing_constants.dart';
import 'package:fridayy_one/business_logic/view_models/base_view_model.dart';
import 'package:fridayy_one/business_logic/view_models/home_view_models/home_screen_holder_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/widgets/popups/offers/category_page_filter.dart';

class OfferScreenViewModel extends BaseModel {
  late PageController offerPageController;
  String currentOfferType = 'Cashback';

  final List<String> types = [
    'FAD',
    'LUX',
    'TRVL',
    'FIN',
    'MDCL',
    'UTL',
    'EAD',
    'OTH'
  ];

  final List<String> expiringTypes = ['This Week', 'This Month', 'Any'];

  final title = "Offers";
  int currentTabIndex = 0;
  String filterDiscountType = "High to Low";
  String filterViewBy = "Brand";
  String filterExpiryType = "Any";

  bool filterRecommended = true;
  late String dateFilter;
  late int month;
  late String year;
  late HomeScreenHolderViewModel homeModel;

  init(HomeScreenHolderViewModel model) async {
    homeModel = model;
    currentTabIndex = homeModel.offerCategoryIndex;
    offerPageController = PageController(initialPage: currentTabIndex);
    final date = DateTime.now();
    month = date.month;
    year = date.year.toString().substring(2);
    dateFilter = year + (month > 9 ? month.toString() : '0${month.toString()}');
    offerPageController.addListener(() async {
      currentTabIndex = offerPageController.page!.round();
      homeModel.offerCategoryIndex = currentTabIndex;
      filterDiscountType = "High to Low";
      filterExpiryType = "Any";
      filterRecommended = true;
      notifyListeners();
    });
    if (homeModel.offersOfCategory[currentTabIndex].brands.isEmpty) {
      fetchCategoryOffer(currentTabIndex);
    }
  }

  fetchCategoryOffer(int index) async {
    setState(ViewState.busy);
    final CallOutcome result = await apiService.getRequest(
      "${ApiConstants.offerOnCategory}/${types[index]}?date=$dateFilter",
    );
    if (result.data != null) {
      homeModel.offersOfCategory[index] =
          OfferCategoryBrands.fromJson(result.data as Map<String, dynamic>);
    } else if (result.exception != null) {}
    if (homeModel.currentTabIndex == 1) {
      setState(ViewState.idle);
    }
  }

  void tabChanged(int newTabIndex) {
    currentTabIndex = newTabIndex;
    offerPageController
        .animateToPage(
      currentTabIndex,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeIn,
    )
        .whenComplete(() async {
      if (homeModel.offersOfCategory[newTabIndex].brands.isEmpty) {
        fetchCategoryOffer(newTabIndex);
      }
    });
  }

  void useFilter() {
    showModalBottomSheet(
      context: navigationService.navigatorKey.currentContext!,
      constraints: BoxConstraints(
        maxWidth: sizeConfig.getPropWidth(379),
        minHeight: sizeConfig.getPropHeight(194),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
        child: Center(
          child: CategoryPageFilter(
            offerType: currentOfferType,
            onSaveFilter: updatefilter,
          ),
        ),
      ),
    );
  }

  updatefilter(String? offerType) {
    currentOfferType = offerType ?? 'Cashback';
    // TODO: applying filter
    setState(ViewState.idle);
  }

  void gotoBrandOffers(String brandId, String brandName) {
    navigationService.pushScreen(
      Routes.brandOffers,
      arguments: {
        "brandId": brandId,
        "brandName": brandName,
      },
    );
  }

  Future refreshData() async {
    fetchCategoryOffer(currentTabIndex);
  }

  void updateFilter() {
    navigationService.pop();
    notifyListeners();
  }
}
