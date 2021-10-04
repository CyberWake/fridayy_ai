class SpendsOnBrand {
  SpendsOnBrand({
    required this.amount,
    required this.formattedDate,
    required this.date,
    required this.brandId,
    required this.brandName,
    required this.brandImg,
  });

  factory SpendsOnBrand.fromJson(Map<String, dynamic> json) {
    return SpendsOnBrand(
      amount: json['amount'] as double,
      formattedDate: json['formattedDate'] as String,
      date: json['date'] as String,
      brandId: json['brandId'] as String,
      brandName: json['brandName'] as String,
      brandImg: json['brandImg'] as String,
    );
  }

  double amount;
  String formattedDate;
  String date;
  String brandId;
  String brandName;
  String brandImg;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = this.amount;
    data['formattedDate'] = this.formattedDate;
    data['date'] = this.date;
    data['brandId'] = this.brandId;
    data['brandName'] = this.brandName;
    data['brandImg'] = this.brandImg;
    return data;
  }
}
