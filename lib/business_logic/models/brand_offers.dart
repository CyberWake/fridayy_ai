import 'package:fridayy_one/business_logic/models/user_overview_model.dart';

class BrandOffer {
  BrandOffer({required this.offers});

  factory BrandOffer.fromJson(Map<String, dynamic> json) {
    final List<OfferInfo> offers = [];
    if (json['offers'] != null) {
      json['offers'].forEach((v) {
        offers.add(OfferInfo.fromJson(v as Map<String, dynamic>));
      });
    }
    return BrandOffer(offers: offers);
  }

  final List<OfferInfo> offers;

  set offers(List<OfferInfo> newOffers) {
    offers.clear();
    offers.addAll(newOffers);
  }
}
