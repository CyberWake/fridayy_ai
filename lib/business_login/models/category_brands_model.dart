import 'package:fridayy_one/business_login/models/user_overview_model.dart';

class CategoryBrandModel {
  CategoryBrandModel({
    required this.categoryId,
    required this.brandId,
    required this.brandName,
    required this.brandImg,
    required this.brandCouponCount,
    required this.offers,
  });

  String categoryId;
  String brandId;
  String brandName;
  String brandImg;
  int brandCouponCount;
  List<Offers> offers;
}
