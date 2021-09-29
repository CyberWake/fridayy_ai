import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fridayy_one/business_login/utils/fridayy_svg.dart';
import 'package:fridayy_one/business_login/view_models/base_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';

class OfferScreenViewModel extends BaseModel {
  final PageController offerPageController = PageController(initialPage: 0);

  final List<Map<String, String>> types = [
    {
      'title': 'Food & Drink',
      'image': FridayySvg.foodIcon,
    },
    {
      'title': 'Travel',
      'image': FridayySvg.travelIcon,
    },
    {
      'title': 'Payment',
      'image': FridayySvg.paymentIcon,
    },
    {
      'title': 'Medical',
      'image': FridayySvg.medicineIcon,
    },
    {
      'title': 'Utilities',
      'image': FridayySvg.utilitiesIcon,
    },
  ];

  final List<String> expiringTypes = ['This Week', 'This Month', 'Any'];

  final title = "Offers";
  int currentTabIndex = 0;
  String filterDiscountType = "High to Low";
  String filterExpiryType = "Any";
  bool filterRecommended = true;

  void init() {
    offerPageController.addListener(() {
      currentTabIndex = offerPageController.page!.round();
      filterDiscountType = "High to Low";
      filterExpiryType = "Any";
      filterRecommended = true;
      notifyListeners();
    });
  }

  void tabChanged(int newTabIndex) {
    currentTabIndex = newTabIndex;
    offerPageController.animateToPage(
      currentTabIndex,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeIn,
    );
    notifyListeners();
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
        maxHeight: sizeConfig.getPropHeight(295),
      ),
      context: navigationService.navigatorKey.currentContext!,
      builder: (context) => widget,
    );
  }

  void useCoupon(Widget widget) {
    showModalBottomSheet(
      context: navigationService.navigatorKey.currentContext!,
      constraints: BoxConstraints(
        maxWidth: sizeConfig.getPropWidth(336),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
        child: widget,
      ),
    );
  }
}
