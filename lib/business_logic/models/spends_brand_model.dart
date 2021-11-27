import 'package:fridayy_one/business_logic/models/spends_model.dart';

class SpendsBrandModel {
  SpendsBrandModel({
    required this.totalSpend,
    required this.currency,
    required this.brands,
  });

  factory SpendsBrandModel.fromJson(Map<String, dynamic> json) {
    final List<SpendsModel> brands = [];
    if (json['brands'] != null) {
      json['brands'].forEach((v) {
        brands.add(SpendsModel.fromJson(v as Map<String, dynamic>));
      });
    }
    return SpendsBrandModel(
      totalSpend: double.parse(json['total_spend'].toString()),
      currency: json['currency'].toString(),
      brands: brands,
    );
  }
  double totalSpend;
  String currency;
  List<SpendsModel> brands;
}
