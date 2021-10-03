import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fridayy_one/business_login/models/category_brands_model.dart';
import 'package:fridayy_one/business_login/models/user_overview_model.dart';
import 'package:fridayy_one/business_login/utils/api_constants.dart';
import 'package:fridayy_one/business_login/utils/enums.dart';
import 'package:fridayy_one/business_login/utils/fridayy_svg.dart';
import 'package:fridayy_one/business_login/utils/routing_constants.dart';
import 'package:fridayy_one/business_login/view_models/base_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';

class OfferScreenViewModel extends BaseModel {
  final PageController offerPageController = PageController(initialPage: 0);
  final List<List<Offers>> offersOfCategory = [
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    [],
  ];

  final List<List<CategoryBrandModel>> categoryBrands = [
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    [],
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

  init() async {
    offerPageController.addListener(() async {
      currentTabIndex = offerPageController.page!.round();
      filterDiscountType = "High to Low";
      filterExpiryType = "Any";
      filterRecommended = true;
      notifyListeners();
    });
    setState(ViewState.busy);
    final result = await apiService.getRequest(
      "${ApiConstants.categoryOffers}/${types[0]["id"]}?date=2109",
    );
    if (result != null) {
      (result as List).forEach((element) {
        offersOfCategory[0].add(
          Offers.fromJsonOffers(element as Map<String, dynamic>),
        );
        bool found = false;
        for (int i = 0; i < categoryBrands[0].length; i++) {
          if (categoryBrands[0][i].brandId ==
              offersOfCategory[0].last.brandId) {
            categoryBrands[0][i].brandCouponCount++;
            categoryBrands[0][i].offers.add(offersOfCategory[0].last);
            found = true;
          }
        }
        if (!found) {
          categoryBrands[0].add(
            CategoryBrandModel(
              categoryId: types[0]["id"].toString(),
              brandId: offersOfCategory[0].last.brandId,
              brandName: offersOfCategory[0].last.brandName,
              brandImg: offersOfCategory[0].last.brandImg,
              brandCouponCount: 1,
              offers: [offersOfCategory[0].last],
            ),
          );
        }
      });
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
      if (offersOfCategory[newTabIndex].isEmpty) {
        setState(ViewState.busy);
        final result = await apiService.getRequest(
          "${ApiConstants.categoryOffers}/${types[newTabIndex]["id"]}?date=2109",
        );
        if (result != null) {
          (result as List).forEach((element) {
            offersOfCategory[newTabIndex].add(
              Offers.fromJsonOffers(element as Map<String, dynamic>),
            );
            bool found = false;
            for (int i = 0; i < categoryBrands[newTabIndex].length; i++) {
              if (categoryBrands[newTabIndex][i].brandId ==
                  offersOfCategory[newTabIndex].last.brandId) {
                categoryBrands[newTabIndex][i].brandCouponCount++;
                categoryBrands[newTabIndex][i]
                    .offers
                    .add(offersOfCategory[newTabIndex].last);
                found = true;
              }
            }
            if (!found) {
              categoryBrands[newTabIndex].add(
                CategoryBrandModel(
                  categoryId: types[newTabIndex]["id"].toString(),
                  brandId: offersOfCategory[newTabIndex].last.brandId,
                  brandName: offersOfCategory[newTabIndex].last.brandName,
                  brandImg: offersOfCategory[newTabIndex].last.brandImg,
                  brandCouponCount: 1,
                  offers: [offersOfCategory[newTabIndex].last],
                ),
              );
            }
          });
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

  void gotoBrandOffers(List brandData, int brandIndex, int categoryIndex) {
    navigationService.pushScreen(
      Routes.brandOffers,
      arguments: {
        "brandData": brandData,
        "offers": categoryBrands[categoryIndex][brandIndex].offers,
      },
    );
  }
}
