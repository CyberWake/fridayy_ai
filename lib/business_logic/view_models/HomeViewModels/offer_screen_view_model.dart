import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fridayy_one/business_logic/models/new_models/offer_category_brands_model.dart';
import 'package:fridayy_one/business_logic/models/pass_call_outcome.dart';
import 'package:fridayy_one/business_logic/utils/api_constants.dart';
import 'package:fridayy_one/business_logic/utils/dummy_data.dart';
import 'package:fridayy_one/business_logic/utils/enums.dart';
import 'package:fridayy_one/business_logic/utils/fridayy_svg.dart';
import 'package:fridayy_one/business_logic/utils/routing_constants.dart';
import 'package:fridayy_one/business_logic/view_models/base_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';

class OfferScreenViewModel extends BaseModel {
  final PageController offerPageController = PageController(initialPage: 0);
  final List<OfferCategoryBrands> offersOfCategory = [
    OfferCategoryBrands(brands: []),
    OfferCategoryBrands(brands: []),
    OfferCategoryBrands(brands: []),
    OfferCategoryBrands(brands: []),
    OfferCategoryBrands(brands: []),
    OfferCategoryBrands(brands: []),
    OfferCategoryBrands(brands: []),
    OfferCategoryBrands(brands: []),
  ];

  final List<Map<String, String>> types = [
    {
      'id': 'FAD',
      'title': 'Food & Drink',
      'image': FridayySvg.foodIcon,
    },
    {
      'id': 'LUX',
      'title': 'Shopping',
      'image': FridayySvg.shoppingIcon,
    },
    {
      'id': 'TRVL',
      'title': 'Travel',
      'image': FridayySvg.travelIcon,
    },
    {
      'id': 'FIN',
      'title': 'Finance',
      'image': FridayySvg.financeIcon,
    },
    {
      'id': 'MDCL',
      'title': 'Medical',
      'image': FridayySvg.medicineIcon,
    },
    {
      'id': 'UTL',
      'title': 'Utilities',
      'image': FridayySvg.utilitiesIcon,
    },
    {
      'id': 'EAD',
      'title': 'Edu & Dev',
      'image': FridayySvg.educationIcon,
    },
    {
      'id': 'OTH',
      'title': 'Others',
      'image': FridayySvg.othersIcon,
    },
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

  init() async {
    offerPageController.addListener(() async {
      currentTabIndex = offerPageController.page!.round();
      filterDiscountType = "High to Low";
      filterExpiryType = "Any";
      filterRecommended = true;
      notifyListeners();
    });
    final date = DateTime.now();
    month = date.month;
    year = date.year.toString().substring(2);
    dateFilter = year + (month > 9 ? month.toString() : '0${month.toString()}');
    setState(ViewState.busy);
    final result = await apiService.getRequest(
      "${ApiConstants.categoryOffers}/${types[0]["id"]}?date=$dateFilter}",
    );
    if (result.data != null) {
      offersOfCategory[0] =
          OfferCategoryBrands.fromJson(result.data as Map<String, dynamic>);
    } else if (result.exception != null) {
      offersOfCategory[0] = OfferCategoryBrands.fromJson(offersPage[0]);
    }
    setState(ViewState.idle);
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
      if (offersOfCategory[newTabIndex].brands.isEmpty) {
        setState(ViewState.busy);
        final CallOutcome result = await apiService.getRequest(
          "${ApiConstants.categoryOffers}/${types[newTabIndex]["id"]}?date=$dateFilter",
        );
        if (result.data != null) {
          offersOfCategory[newTabIndex] =
              OfferCategoryBrands.fromJson(result.data as Map<String, dynamic>);
        } else if (result.exception != null) {
          offersOfCategory[newTabIndex] = OfferCategoryBrands.fromJson(
              offersPage[newTabIndex] as Map<String, dynamic>);
        }
        setState(ViewState.idle);
      }
    });
  }

  void useFilter(Widget widget) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(sizeConfig.getPropWidth(16)),
          topRight: Radius.circular(sizeConfig.getPropWidth(16)),
        ),
      ),
      constraints: BoxConstraints(
        maxWidth: sizeConfig.getPropWidth(379),
        maxHeight: sizeConfig.getPropHeight(394),
      ),
      context: navigationService.navigatorKey.currentContext!,
      builder: (context) => widget,
    );
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
    offersOfCategory.forEach((element) {
      element.brands.clear();
    });
    tabChanged(currentTabIndex);
  }

  void updateFilter() {
    navigationService.pop();
    notifyListeners();
  }
}
