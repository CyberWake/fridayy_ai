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
      formattedDate: json['formatted_date'] as String,
      date: json['date'].toString(),
      brandId: json['brand_id'] as String,
      brandName: json['brand_name'] as String,
      brandImg: json['brand_img'] as String,
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
