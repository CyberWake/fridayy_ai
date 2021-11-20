import 'package:fridayy_one/business_logic/models/spend_model.dart';

class SpendingCategoryModel {
  SpendingCategoryModel({
    required this.categoryId,
    required this.amount,
    required this.count,
    required this.spends,
  });

  factory SpendingCategoryModel.fromJson(Map<String, dynamic> json) {
    final List<Spend> list = [];
    if (json['spends'] != null) {
      json['spends'].forEach((v) {
        list.add(Spend.fromJson(v as Map<String, dynamic>));
      });
    }
    return SpendingCategoryModel(
      categoryId: json['category_id'] as String,
      amount: json['amount'] as double,
      count: json['count'] as int,
      spends: list,
    );
  }

  String categoryId;
  double amount;
  int count;
  List<Spend> spends;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = this.categoryId;
    data['amount'] = this.amount;
    data['count'] = this.count;
    data['spends'] = this.spends.map((v) => v.toJson()).toList();
    return data;
  }
}
