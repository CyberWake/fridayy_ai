class Spends {
  Spends({
    required this.amount,
    required this.date,
    this.spendingId,
    required this.transactionType,
    this.from,
    this.to,
    this.remainingBalance,
    required this.categoryId,
  });

  factory Spends.fromJson(Map<String, dynamic> json) {
    return Spends(
      amount: json['amount'] as double,
      date: json['date'] as String,
      transactionType: json['transaction_type'] as String,
      categoryId: json['category_id'] as String?,
      spendingId: json['spending_id'] as String?,
      to: json['to'] as String?,
      from: json['from'] as String?,
      remainingBalance: json['remaining_balance'] as double?,
    );
  }

  double amount;
  String date;
  String? spendingId;
  String transactionType;
  String? from;
  String? to;
  double? remainingBalance;
  String? categoryId;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = this.amount;
    data['date'] = this.date;
    data['spending_id'] = this.spendingId;
    data['transaction_type'] = this.transactionType;
    data['from'] = this.from;
    data['to'] = this.to;
    data['remaining_balance'] = this.remainingBalance;
    data['category_id'] = this.categoryId;
    return data;
  }
}
