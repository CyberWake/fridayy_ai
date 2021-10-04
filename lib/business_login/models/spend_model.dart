class Spend {
  Spend({
    required this.amount,
    required this.date,
    required this.spendingId,
    required this.transactionType,
    required this.from,
    required this.to,
    required this.remainingBalance,
    required this.categoryId,
  });

  factory Spend.fromJson(Map<String, dynamic> json) {
    return Spend(
      amount: json['amount'] as double,
      date: json['date'] as String,
      spendingId: json['spending_id'] as String?,
      transactionType: json['transaction_type'] as String,
      from: json['from'] as String?,
      to: json['to'] as String?,
      remainingBalance: json['remaining_balance'] as double?,
      categoryId: json['category_id'] as String,
    );
  }

  double amount;
  String date;
  String? spendingId;
  String transactionType;
  String? from;
  String? to;
  double? remainingBalance;
  String categoryId;

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
