class SpendsModel {
  SpendsModel({
    required this.amount,
    required this.spendId,
    required this.date,
    required this.brandId,
    required this.brandName,
    required this.categoryId,
    required this.count,
    required this.paymentType,
  });

  factory SpendsModel.fromJson(Map<String, dynamic> json) {
    return SpendsModel(
      amount: json['amount'] as double,
      spendId: json['spend_id'] as String?,
      date: json['date'] == null
          ? null
          : int.parse(json['date'].toString().split('.')[0]),
      paymentType: json['payment_type'] as String?,
      brandId: json['brand_id'] as String?,
      brandName: json['brand_name'] as String?,
      categoryId: json['category_id'] as String?,
      count: json['count'] as int?,
    );
  }

  double amount;
  String? spendId;
  int? date;
  int? count;
  String? paymentType;
  String? brandId;
  String? brandName;
  String? categoryId;
}
