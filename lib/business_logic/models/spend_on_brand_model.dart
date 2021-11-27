import 'package:fridayy_one/business_logic/models/spends_model.dart';

class SpendsOnBrand {
  SpendsOnBrand({
    required this.totalSpend,
    required this.currency,
    required this.brandId,
    required this.brandName,
    required this.spends,
  });

  factory SpendsOnBrand.fromJson(Map<String, dynamic> json) {
    final List<SpendsModel> spends = [];
    if (json['spends'] != null) {
      json['spends'].forEach((v) {
        spends.add(SpendsModel.fromJson(v as Map<String, dynamic>));
      });
    }
    return SpendsOnBrand(
      totalSpend: json['total_spend'] as double,
      currency: json['currency'] as String,
      brandId: json['brand_id'] as String,
      brandName: json['brand_name'] as String,
      spends: spends,
    );
  }
  double totalSpend;
  String currency;
  String brandId;
  String brandName;
  List<SpendsModel> spends;
}
