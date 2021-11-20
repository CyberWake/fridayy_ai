import 'package:fridayy_one/business_logic/models/spends_on_brand_model.dart';

class SpendingTransactionModel {
  SpendingTransactionModel({
    required this.amount,
    required this.count,
    required this.spends,
  });

  factory SpendingTransactionModel.fromJson(Map<String, dynamic> json) {
    final List<SpendsOnBrand> list = [];
    json['spendings'].forEach((v) {
      list.add(SpendsOnBrand.fromJson(v as Map<String, dynamic>));
    });
    return SpendingTransactionModel(
      amount: json['amount'] as double,
      count: json['count'] as int,
      spends: list,
    );
  }

  double amount;
  int count;
  List<SpendsOnBrand> spends;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = this.amount;
    data['count'] = this.count;
    data['spends'] = this.spends.map((v) => v.toJson()).toList();
    return data;
  }
}
