class SpendsOnBrand {
  SpendsOnBrand({
    required this.amount,
    required this.spendId,
    required this.date,
    required this.brandId,
    required this.brandName,
    required this.categoryId,
  });

  factory SpendsOnBrand.fromJson(Map<String, dynamic> json) {
    return SpendsOnBrand(
        amount: json['amount'] as double,
        spendId: json['spend_id'] as String?,
        date: json['date'].toString(),
        brandId: json['brand_id'] as String,
        brandName: json['brand_name'] as String,
        categoryId: json['category_id'] as String?);
  }

  double amount;
  String? spendId;
  String date;
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
