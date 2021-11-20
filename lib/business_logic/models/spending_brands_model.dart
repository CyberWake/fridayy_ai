import 'package:fridayy_one/business_logic/models/spends_model.dart';

class SpendingBrandModel {
  SpendingBrandModel({
    required this.brandId,
    required this.brandName,
    required this.amount,
    required this.count,
    required this.spends,
  });

  factory SpendingBrandModel.fromJson(Map<String, dynamic> json) {
    final List<Spends> list = [];
    if (json['spends'] != null) {
      json['spends'].forEach((v) {
        list.add(Spends.fromJson(v as Map<String, dynamic>));
      });
    }
    return SpendingBrandModel(
      brandId: json['brand_id'] as String,
      brandName: json['brand_name'] as String,
      amount: json['amount'] as double,
      count: json['count'] as int,
      spends: list,
    );
  }

  String brandId;
  String brandName;
  double amount;
  int count;
  List<Spends> spends;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['brand_id'] = this.brandId;
    data['brand_name'] = this.brandName;
    data['amount'] = this.amount;
    data['count'] = this.count;
    data['spends'] = this.spends.map((v) => v.toJson()).toList();
    return data;
  }
}
