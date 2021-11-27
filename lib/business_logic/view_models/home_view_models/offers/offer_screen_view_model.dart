import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fridayy_one/business_logic/models/offer_category_brands_model.dart';
import 'package:fridayy_one/business_logic/models/pass_call_outcome.dart';
import 'package:fridayy_one/business_logic/utils/api_constants.dart';
import 'package:fridayy_one/business_logic/utils/dummy_data.dart';
import 'package:fridayy_one/business_logic/utils/enums.dart';
import 'package:fridayy_one/business_logic/utils/fridayy_svg.dart';
import 'package:fridayy_one/business_logic/utils/routing_constants.dart';
import 'package:fridayy_one/business_logic/view_models/base_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/widgets/popups/offers/category_page_filter.dart';

class OfferScreenViewModel extends BaseModel {
  late PageController offerPageController;
  String currentOfferType = 'Cashback';
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

  init(int index) async {
    currentTabIndex = index;
    offerPageController = PageController(initialPage: currentTabIndex);
    final date = DateTime.now();
    month = date.month;
    year = date.year.toString().substring(2);
    dateFilter = year + (month > 9 ? month.toString() : '0${month.toString()}');
    setState(ViewState.busy);
    final result = await apiService.getRequest(
      "${ApiConstants.offerOnCategory}/${types[currentTabIndex]["id"]}?date=$dateFilter}",
    );
    if (result.data != null) {
      offersOfCategory[currentTabIndex] =
          OfferCategoryBrands.fromJson(result.data as Map<String, dynamic>);
      setState(ViewState.idle);
    } else if (result.exception != null) {
      offersOfCategory[currentTabIndex] =
          OfferCategoryBrands.fromJson(offersPage[currentTabIndex]);
      setState(ViewState.idle);
    }
    offerPageController.addListener(() async {
      currentTabIndex = offerPageController.page!.round();
      filterDiscountType = "High to Low";
      filterExpiryType = "Any";
      filterRecommended = true;
      notifyListeners();
    });
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
          "${ApiConstants.offerOnCategory}/${types[newTabIndex]["id"]}?date=$dateFilter",
        );
        if (result.data != null) {
          offersOfCategory[newTabIndex] =
              OfferCategoryBrands.fromJson(result.data as Map<String, dynamic>);
          setState(ViewState.idle);
        } else if (result.exception != null) {
          offersOfCategory[newTabIndex] = OfferCategoryBrands.fromJson(
            offersPage[newTabIndex],
          );
          setState(ViewState.idle);
        }
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
