class SpendCategoryModel {
  SpendCategoryModel({
    required this.totalSpend,
    required this.currency,
    required this.distribution,
  });

  factory SpendCategoryModel.fromJson(Map<String, dynamic> json) {
    final List<Distribution> distribution = [];
    if (json['distribution'] != null) {
      json['distribution'].forEach((v) {
        distribution.add(Distribution.fromJson(v as Map<String, dynamic>));
      });
    }
    return SpendCategoryModel(
      totalSpend: double.parse(json['total_spend'].toString()),
      currency: json['currency'] as String,
      distribution: distribution,
    );
  }
  double totalSpend;
  String currency;
  List<Distribution> distribution;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_spend'] = this.totalSpend;
    data['currency'] = this.currency;
    data['distribution'] = this.distribution.map((v) => v.toJson()).toList();
    return data;
  }
}

class Distribution {
  Distribution({
    required this.categoryId,
    required this.percentage,
    required this.amount,
    required this.count,
  });

  factory Distribution.fromJson(Map<String, dynamic> json) {
    return Distribution(
      categoryId: json['category_id'] as String,
      percentage: double.parse(json['percentage'].toString()),
      amount: double.parse(json['amount'].toString()),
      count: json['count'] as int,
    );
  }
  String categoryId;
  double percentage;
  double amount;
  int count;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = this.categoryId;
    data['percentage'] = this.percentage;
    data['amount'] = this.amount;
    data['count'] = this.count;
    return data;
  }
}
