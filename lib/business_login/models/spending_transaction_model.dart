class SpendingTransactionModel {
  SpendingTransactionModel({
    required this.amount,
    required this.count,
    required this.spends,
  });

  factory SpendingTransactionModel.fromJson(Map<String, dynamic> json) {
    final List<Spends> list = [];
    json['spends'].forEach((v) {
      list.add(Spends.fromJson(v as Map<String, dynamic>));
    });
    return SpendingTransactionModel(
      amount: json['amount'] as double,
      count: json['count'] as int,
      spends: list,
    );
  }

  double amount;
  int count;
  List<Spends> spends;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = this.amount;
    data['count'] = this.count;
    data['spends'] = this.spends.map((v) => v.toJson()).toList();
    return data;
  }
}

class Spends {
  Spends({
    required this.amount,
    required this.formattedDate,
    required this.date,
    required this.brandId,
    required this.brandName,
    required this.brandImg,
  });

  factory Spends.fromJson(Map<String, dynamic> json) {
    return Spends(
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
