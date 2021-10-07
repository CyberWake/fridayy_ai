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
  User({required this.userName, this.userImg});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userName: json['user_name'] as String,
      userImg: json['user_img'] as String?,
    );
  }

  String userName;
  String? userImg;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_name'] = this.userName;
    data['user_img'] = this.userImg;
    return data;
  }
}

class Offer {
  Offer({
    required this.totalOffers,
    required this.activeOffers,
    required this.offersExpiring,
    required this.notifiedOffers,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    final List<NotifiedOffers> list = [];

    if (json['notified_offers'] != null) {
      json['notified_offers'].forEach((v) {
        list.add(NotifiedOffers.fromJson(v as Map<String, dynamic>));
      });
    }
    return Offer(
      totalOffers: json['total_offers'] as int,
      activeOffers: json['active_offers'] as int,
      offersExpiring: json['offers_expiring'] as int,
      notifiedOffers: list,
    );
  }

  int totalOffers;
  int activeOffers;
  int offersExpiring;
  List<NotifiedOffers> notifiedOffers;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_offers'] = this.totalOffers;
    data['active_offers'] = this.activeOffers;
    data['offers_expiring'] = this.offersExpiring;
    data['notified_offers'] =
        this.notifiedOffers.map((v) => v.toJson()).toList();
    return data;
  }
}

class NotifiedOffers {
  NotifiedOffers({
    required this.offerId,
    required this.expiryDate,
    required this.relativeDay,
    this.offers,
  });

  factory NotifiedOffers.fromJson(Map<String, dynamic> json) {
    return NotifiedOffers(
      offerId: json['offer_id'] as String,
      expiryDate: json['expiry_date'] as String,
      relativeDay: json['relative_day'] as int,
      offers: json['offers'] != null
          ? Offers.fromJsonOverView(json['offers'] as Map<String, dynamic>)
          : null,
    );
  }

  String offerId;
  String expiryDate;
  int relativeDay;
  Offers? offers;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['offer_id'] = this.offerId;
    data['expiry_date'] = this.expiryDate;
    data['relative_day'] = this.relativeDay;
    if (this.offers != null) {
      data['offers'] = this.offers!.toJson();
    }
    return data;
  }
}

class Offers {
  Offers({
    required this.offerId,
    required this.brandName,
    required this.brandId,
    required this.brandImg,
    required this.body,
    this.rewardType,
    this.rewardAmount,
    this.code,
    this.link,
    this.rewardDescription,
    this.expiryDate,
  });

  factory Offers.fromJsonOverView(Map<String, dynamic> json) {
    return Offers(
      offerId: json['offer_id'] as String,
      brandName: json['brand_name'] as String,
      brandId: json['brand_id'] as String,
      brandImg: json['brand_img'] as String,
      body: json['body'] as String,
      rewardType: json['reward_type'] as String?,
      rewardAmount: json['reward_amount'] as double?,
      code: json['code'] as String?,
      expiryDate: json['expiryDate'] as String?,
      link: json['link'] as String?,
      rewardDescription: json['reward_description'] as String?,
    );
  }

  factory Offers.fromJsonOffers(Map<String, dynamic> json) {
    return Offers(
      offerId: json['offerId'] as String,
      brandName: json['brandName'] as String,
      brandId: json['brandId'] as String,
      brandImg: json['brandImg'] as String,
      body: json['body'] as String,
      rewardType: json['rewardType'] as String?,
      rewardAmount: json['rewardAmount'] as double?,
      code: json['code'] as String?,
      expiryDate: json['expiryDate'] as String?,
      link: json['link'] as String?,
      rewardDescription: json['rewardDescription'] as String?,
    );
  }

  String offerId;
  String brandName;
  String brandId;
  String brandImg;
  String body;
  String? rewardType;
  double? rewardAmount;
  String? code;
  String? link;
  String? rewardDescription;
  String? expiryDate;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['offer_id'] = this.offerId;
    data['brand_name'] = this.brandName;
    data['brand_id'] = this.brandId;
    data['brand_img'] = this.brandImg;
    data['body'] = this.body;
    data['reward_type'] = this.rewardType;
    data['reward_amount'] = this.rewardAmount;
    data['code'] = this.code;
    data['link'] = this.link;
    data['expiryDate'] = this.expiryDate;
    data['reward_description'] = this.rewardDescription;
    return data;
  }
}

class Spending {
  Spending({
    required this.month,
    required this.currency,
    required this.amount,
    required this.distribution,
  });

  factory Spending.fromJson(Map<String, dynamic> json) {
    final List<Distribution> list = [];
    if (json['distribution'] != null) {
      (json['distribution'] as List).forEach((element) {
        list.add(Distribution.fromJson(element as Map<String, dynamic>));
      });
    }
    return Spending(
      month: json['month'] as String,
      currency: json['currency'] as String,
      amount: json['amount'] as int,
      distribution: list,
    );
  }

  String month;
  String currency;
  int amount;
  List<Distribution> distribution;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['month'] = this.month;
    data['currency'] = this.currency;
    data['amount'] = this.amount;
    data['distribution'] = this.distribution.map((v) => v.toJson()).toList();
    return data;
  }
}

class Distribution {
  Distribution({required this.categoryId, required this.percentage});

  factory Distribution.fromJson(Map<String, dynamic> json) {
    return Distribution(
      categoryId: json['categoryId'] as String,
      percentage: json['percentage'] as double,
    );
  }

  String categoryId;
  double percentage;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryId'] = this.categoryId;
    data['percentage'] = this.percentage;
    return data;
  }
}

class Financial {
  Financial({required this.percentile});

  factory Financial.fromJson(Map<String, dynamic> json) {
    return Financial(percentile: json['percentile'] as int);
  }
  int percentile;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['percentile'] = this.percentile;
    return data;
  }
}
