import 'package:fridayy_one/business_logic/models/user_overview_model.dart';

class CategoryBrandModel {
  CategoryBrandModel({
    required this.categoryId,
    required this.brandId,
    required this.brandName,
    required this.brandCouponCount,
    required this.offers,
  });

  String categoryId;
  String brandId;
  String brandName;
  int brandCouponCount;
  List<NotifiedOffers> offers;
}
