import 'package:fridayy_one/business_logic/models/new_models/spends_on_brand_model.dart';

class SpendsTransactionModel {
  SpendsTransactionModel({
    required this.totalAmount,
    required this.currency,
    required this.spends,
  });

  factory SpendsTransactionModel.fromJson(Map<String, dynamic> json) {
    final List<SpendsOnBrand> list = [];
    json['spends'].forEach((v) {
      list.add(SpendsOnBrand.fromJson(v as Map<String, dynamic>));
    });
    return SpendsTransactionModel(
      totalAmount: json['total_spend'] as double,
      currency: json['currency'] as String,
      spends: list,
    );
  }

  double totalAmount;
  String currency;
  List<SpendsOnBrand> spends;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = this.totalAmount;
    data['count'] = this.currency;
    data['spends'] = this.spends.map((v) => v.toJson()).toList();
    return data;
  }
}
