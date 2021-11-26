class SpendsOnBrand {
  SpendsOnBrand({
    required this.amount,
    required this.spendId,
    required this.date,
    required this.brandId,
    required this.brandName,
    required this.categoryId,
    required this.count,
  });

  factory SpendsOnBrand.fromJson(Map<String, dynamic> json) {
    return SpendsOnBrand(
      amount: json['amount'] as double,
      spendId: json['spend_id'] as String?,
      date: json['date'] == null
          ? null
          : int.parse(json['date'].toString().split('.')[0]),
      brandId: json['brand_id'] as String,
      brandName: json['brand_name'] as String,
      categoryId: json['category_id'] as String?,
      count: json['count'] as int?,
    );
  }

  double amount;
  String? spendId;
  int? date;
  int? count;
  String brandId;
  String brandName;
  String? categoryId;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = this.amount;
    data['spend_id'] = this.spendId;
    data['date'] = this.date;
    data['brandId'] = this.brandId;
    data['brandName'] = this.brandName;
    return data;
  }
}
