class OfferCategoryBrands {
  OfferCategoryBrands({required this.brands});

  factory OfferCategoryBrands.fromJson(Map<String, dynamic> json) {
    final List<Brands> brands = [];
    if (json['brands'] != null) {
      json['brands'].forEach((v) {
        brands.add(Brands.fromJson(v as Map<String, dynamic>));
      });
    }
    return OfferCategoryBrands(brands: brands);
  }
  List<Brands> brands;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['brands'] = this.brands.map((v) => v.toJson()).toList();
    return data;
  }
}

class Brands {
  Brands({
    required this.brandName,
    required this.brandId,
    required this.totalOffers,
    required this.expiringThisWeek,
  });

  factory Brands.fromJson(Map<String, dynamic> json) {
    return Brands(
      brandName: json['brand_name'].toString(),
      brandId: json['brand_id'].toString(),
      totalOffers: json['total_offers'].toString(),
      expiringThisWeek: json['expiring_this_week'].toString(),
    );
  }

  String brandName;
  String brandId;
  String totalOffers;
  String expiringThisWeek;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['brand_name'] = this.brandName;
    data['brand_id'] = this.brandId;
    data['total_offers'] = this.totalOffers;
    data['expiring_this_week'] = this.expiringThisWeek;
    return data;
  }
}
