import 'package:fridayy_one/business_logic/models/spends_model.dart';

class SpendsTransactionModel {
  SpendsTransactionModel({
    required this.totalAmount,
    required this.currency,
    required this.spends,
  });

  factory SpendsTransactionModel.fromJson(Map<String, dynamic> json) {
    final List<SpendsModel> list = [];
    json['spends'].forEach((v) {
      list.add(SpendsModel.fromJson(v as Map<String, dynamic>));
    });
    return SpendsTransactionModel(
      totalAmount: json['total_spend'] as double,
      currency: json['currency'] as String,
      spends: list,
    );
  }

  double totalAmount;
  String currency;
  List<SpendsModel> spends;
}
