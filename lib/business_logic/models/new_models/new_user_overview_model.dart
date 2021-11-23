class NewUserOverView {
  NewUserOverView({
    required this.user,
    required this.offers,
    required this.spending,
  });

  factory NewUserOverView.fromJson(Map<String, dynamic> json) {
    return NewUserOverView(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      offers: Offers.fromJson(json['offers'] as Map<String, dynamic>),
      spending: Spending.fromJson(json['spending'] as Map<String, dynamic>),
    );
  }

  User user;
  Offers offers;
  Spending spending;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = this.user.toJson();
    data['offers'] = this.offers.toJson();
    data['spending'] = this.spending.toJson();
    return data;
  }
}

class User {
  User({
    required this.userName,
    this.userImg,
    this.email,
    this.mobile,
    this.countryCode,
  });

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

class Offers {
  Offers({
    required this.totalOffers,
    required this.activeOffers,
    required this.expiringSoonOffers,
    this.sortedCategories,
    required this.lovedBrand,
    this.recommendedOffers,
    this.notifiedOffers,
  });

  factory Offers.fromJson(Map<String, dynamic> json) {
    final List<SortedCategories> sortedCategories = [];
    final List<OffersByBrand> recommendedOffers = [];
    final List<OffersByBrand> notifiedOffers = [];
    if (json['sorted_categories'] != null) {
      json['sorted_categories'].forEach((v) {
        sortedCategories
            .add(SortedCategories.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['recommended_offers'] != null) {
      json['recommended_offers'].forEach((v) {
        recommendedOffers
            .add(OffersByBrand.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['notified_offers'] != null) {
      json['notified_offers'].forEach((v) {
        notifiedOffers.add(OffersByBrand.fromJson(v as Map<String, dynamic>));
      });
    }
    return Offers(
      totalOffers: json['total_offers'] as int,
      activeOffers: json['active_offers'] as int,
      expiringSoonOffers: json['expiring_soon_offers'] as int,
      lovedBrand:
          LovedBrand.fromJson(json['loved_brand'] as Map<String, dynamic>),
      recommendedOffers: recommendedOffers,
      notifiedOffers: notifiedOffers,
      sortedCategories: sortedCategories,
    );
  }
  int totalOffers;
  int activeOffers;
  int expiringSoonOffers;
  LovedBrand lovedBrand;
  List<SortedCategories>? sortedCategories;
  List<OffersByBrand>? recommendedOffers;
  List<OffersByBrand>? notifiedOffers;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_offers'] = this.totalOffers;
    data['active_offers'] = this.activeOffers;
    data['expiring_soon_offers'] = this.expiringSoonOffers;
    if (this.sortedCategories != null) {
      data['sorted_categories'] =
          this.sortedCategories?.map((v) => v.toJson()).toList();
    }

    data['loved_brand'] = this.lovedBrand.toJson();
    if (this.recommendedOffers != null) {
      data['recommended_offers'] =
          this.recommendedOffers?.map((v) => v.toJson()).toList();
    }
    if (this.notifiedOffers != null) {
      data['notified_offers'] =
          this.notifiedOffers?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SortedCategories {
  SortedCategories({required this.categoryId, required this.count});

  factory SortedCategories.fromJson(Map<String, dynamic> json) {
    return SortedCategories(
      categoryId: json['category_id'] as String,
      count: json['count'] as int,
    );
  }
  String categoryId;
  int count;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = this.categoryId;
    data['count'] = this.count;
    return data;
  }
}

class LovedBrand {
  LovedBrand({
    required this.brandName,
    required this.brandId,
    required this.count,
  });

  factory LovedBrand.fromJson(Map<String, dynamic> json) {
    return LovedBrand(
      brandName: json['brand_name'] as String,
      brandId: json['brand_id'] as String,
      count: json['count'] as int,
    );
  }
  String brandName;
  String brandId;
  int count;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['brand_name'] = this.brandName;
    data['brand_id'] = this.brandId;
    data['count'] = this.count;
    return data;
  }
}

class OffersByBrand {
  OffersByBrand({
    required this.brandName,
    required this.brandId,
    this.offers,
  });

  factory OffersByBrand.fromJson(Map<String, dynamic> json) {
    final List<OfferInfo> offers = [];
    if (json['offers'] != null) {
      json['offers'].forEach((v) {
        offers.add(OfferInfo.fromJson(v as Map<String, dynamic>));
      });
    }
    return OffersByBrand(
      brandName: json['brand_name'] as String,
      brandId: json['brand_id'] as String,
      offers: offers,
    );
  }
  String brandName;
  String brandId;
  List<OfferInfo>? offers;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['brand_name'] = this.brandName;
    data['brand_id'] = this.brandId;
    if (this.offers != null) {
      data['offers'] = this.offers?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OfferInfo {
  OfferInfo({
    required this.body,
    required this.rewardType,
    required this.rewardAmount,
    this.link,
    required this.termsAndConditionsApply,
    this.expiryDate,
    this.code,
    this.rewardDescription,
  });

  factory OfferInfo.fromJson(Map<String, dynamic> json) {
    return OfferInfo(
      body: json['body'] as String,
      rewardType: json['reward_type'] as String,
      rewardAmount: json['reward_amount'] as double?,
      termsAndConditionsApply: json['terms_and_conditions_apply'] as bool,
      link: json['link'] as String?,
      code: json['code'] as String?,
      expiryDate: json['expiry_date'] as int?,
      rewardDescription: json['reward_description'] as String?,
    );
  }
  String body;
  String rewardType;
  double? rewardAmount;
  String? link;
  bool termsAndConditionsApply;
  int? expiryDate;
  String? code;
  String? rewardDescription;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['body'] = this.body;
    data['reward_type'] = this.rewardType;
    data['reward_amount'] = this.rewardAmount;
    data['link'] = this.link;
    data['terms_and_conditions_apply'] = this.termsAndConditionsApply;
    data['expiry_date'] = this.expiryDate;
    data['code'] = this.code;
    data['reward_description'] = this.rewardDescription;
    return data;
  }
}

class Spending {
  Spending({
    required this.total,
    required this.currency,
    required this.distribution,
  });

  factory Spending.fromJson(Map<String, dynamic> json) {
    final List<Distribution> distributions = [];
    if (json['distribution'] != null) {
      json['distribution'].forEach((v) {
        distributions.add(Distribution.fromJson(v as Map<String, dynamic>));
      });
    }
    return Spending(
      total: json['total'] as double,
      currency: json['currency'] as String,
      distribution: distributions,
    );
  }
  double total;
  String currency;
  List<Distribution>? distribution;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = this.total;
    data['currency'] = this.currency;
    if (this.distribution != null) {
      data['distribution'] = this.distribution?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Distribution {
  Distribution({
    required this.categoryId,
    required this.percentage,
    this.count,
    this.radius,
  });

  factory Distribution.fromJson(Map<String, dynamic> json) {
    return Distribution(
      categoryId: json['category_id'] as String,
      percentage: json['percentage'] as double,
    );
  }
  String categoryId;
  double percentage;
  int? count;
  int? radius;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = this.categoryId;
    data['percentage'] = this.percentage;
    return data;
  }
}
