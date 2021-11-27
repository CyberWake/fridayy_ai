import 'package:fridayy_one/business_logic/models/spends_model.dart';

class SpendsOnCategory {
  SpendsOnCategory({
    required this.totalSpend,
    required this.currency,
    required this.spends,
  });

  factory SpendsOnCategory.fromJson(Map<String, dynamic> json) {
    final List<SpendsModel> spends = [];
    if (json['spends'] != null) {
      json['spends'].forEach((v) {
        spends.add(SpendsModel.fromJson(v as Map<String, dynamic>));
      });
    }
    return SpendsOnCategory(
      totalSpend: json['total_spend'] as double,
      currency: json['currency'] as String,
      spends: spends,
    );
  }
  double totalSpend;
  String currency;
  List<SpendsModel> spends;
}
