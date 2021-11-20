class UserOverView {
  UserOverView({
    required this.user,
    required this.offer,
    required this.spending,
    required this.financial,
  });

  factory UserOverView.fromJson(Map<String, dynamic> json) {
    return UserOverView(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      offer: Offer.fromJson(json['offer'] as Map<String, dynamic>),
      spending: Spending.fromJson(json['spending'] as Map<String, dynamic>),
      financial: Financial.fromJson(json['financial'] as Map<String, dynamic>),
    );
  }

  User user;
  Offer offer;
  Spending spending;
  Financial financial;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = this.user.toJson();
    data['offer'] = this.offer.toJson();
    data['spending'] = this.spending.toJson();
    data['financial'] = this.financial.toJson();
    return data;
  }
}

class User {
  User(
      {required this.userName,
      this.userImg,
      this.email,
      this.mobile,
      this.countryCode});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userName: json['user_name'] as String,
      userImg: json['user_img'] as String?,
      email: json['email'] as String?,
      mobile: json['mobile'] as String?,
      countryCode: json['country_code'] as String?,
    );
  }
  String userName;
  String? userImg;
  String? email;
  String? mobile;
  String? countryCode;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_name'] = this.userName;
    data['user_img'] = this.userImg;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['country_code'] = this.countryCode;
    return data;
  }
}

class Offer {
  Offer({
    required this.totalOffers,
    required this.activeOffers,
    required this.offersExpiring,
    this.notifiedOffers,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    final List<NotifiedOffers> notifiedOffers = [];
    if (json['notified_offers'] != null) {
      json['notified_offers'].forEach((v) {
        notifiedOffers.add(NotifiedOffers.fromJson(v as Map<String, dynamic>));
      });
    }
    return Offer(
      totalOffers: json['total_offers'] as int,
      activeOffers: json['active_offers'] as int,
      offersExpiring: json['offers_expiring'] as int,
      notifiedOffers: notifiedOffers,
    );
  }
  int totalOffers;
  int activeOffers;
  int offersExpiring;
  List<NotifiedOffers>? notifiedOffers;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_offers'] = this.totalOffers;
    data['active_offers'] = this.activeOffers;
    data['offers_expiring'] = this.offersExpiring;
    if (this.notifiedOffers != null) {
      data['notified_offers'] =
          this.notifiedOffers?.map((v) => v.toJson()).toList() ?? [];
    }
    return data;
  }
}

class NotifiedOffers {
  NotifiedOffers({
    required this.brandId,
    required this.body,
    required this.brandName,
    required this.categoryId,
    required this.tac,
    this.code,
    this.expiryDate,
    this.link,
    this.rewardAmount,
    this.rewardDescription,
    this.rewardType,
  });

  factory NotifiedOffers.fromJson(Map<String, dynamic> json) {
    return NotifiedOffers(
      brandId: json['brand_id'] as String,
      body: json['body'] as String,
      brandName: json['brand_name'] as String,
      categoryId: json['category_id'] as String,
      code: json['code'] as String?,
      expiryDate: json['expiry_date'] as int?,
      link: json['link'] as String?,
      rewardAmount: json['reward_amount'] as String?,
      rewardDescription: json['reward_description'] as String?,
      rewardType: json['reward_type'] as String?,
      tac: json['tac'] as bool,
    );
  }
  String brandId;
  String body;
  String brandName;
  String categoryId;
  String? code;
  int? expiryDate;
  String? link;
  String? rewardAmount;
  String? rewardDescription;
  String? rewardType;
  bool tac;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['brand_id'] = this.brandId;
    data['body'] = this.body;
    data['brand_name'] = this.brandName;
    data['category_id'] = this.categoryId;
    data['code'] = this.code;
    data['expiry_date'] = this.expiryDate;
    data['link'] = this.link;
    data['reward_amount'] = this.rewardAmount;
    data['reward_description'] = this.rewardDescription;
    data['reward_type'] = this.rewardType;
    data['tac'] = this.tac;
    return data;
  }
}

class Spending {
  Spending({
    required this.month,
    required this.currency,
    required this.amount,
    this.distribution,
  });

  factory Spending.fromJson(Map<String, dynamic> json) {
    final List<Distribution> distribution = [];
    if (json['distribution'] != null) {
      json['distribution'].forEach((v) {
        distribution.add(Distribution.fromJson(v as Map<String, dynamic>));
      });
    }
    return Spending(
      month: json['month'] as String,
      currency: json['currency'] as String,
      amount: json['amount'] as double,
      distribution: distribution,
    );
  }
  String month;
  String currency;
  double amount;
  List<Distribution>? distribution;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['month'] = this.month;
    data['currency'] = this.currency;
    data['amount'] = this.amount;
    if (this.distribution != null) {
      data['distribution'] =
          this.distribution?.map((v) => v.toJson()).toList() ?? [];
    }
    return data;
  }
}

class Distribution {
  Distribution({required this.categoryId, required this.percentage});

  factory Distribution.fromJson(Map<String, dynamic> json) {
    return Distribution(
      categoryId: json['category_id'] as String,
      percentage: json['percentage'] as double,
    );
  }
  String categoryId;
  double percentage;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = this.categoryId;
    data['percentage'] = this.percentage;
    return data;
  }
}

class Financial {
  Financial({required this.percentile});

  factory Financial.fromJson(Map<String, dynamic> json) {
    return Financial(
      percentile: json['percentile'] as double,
    );
  }
  double percentile;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['percentile'] = this.percentile;
    return data;
  }
}
