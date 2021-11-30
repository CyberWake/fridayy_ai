import 'package:fridayy_one/business_logic/models/brand_offers.dart';
import 'package:fridayy_one/business_logic/utils/api_constants.dart';
import 'package:fridayy_one/business_logic/utils/dummy_data.dart';
import 'package:fridayy_one/business_logic/utils/enums.dart';
import 'package:fridayy_one/business_logic/view_models/base_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';

class BrandOffersViewModel extends BaseModel {
  BrandOffer visibleBrandOffers = BrandOffer(offers: []);
  BrandOffer brandOffers = BrandOffer(offers: []);
  String? currentOfferType;
  bool? currentExpiringType;

  void init(String brandId) {
    setState(ViewState.busy);
    fetchOffers(brandId);
  }

  fetchOffers(String brandId) async {
    final result =
        await apiService.getRequest('${ApiConstants.offersOnBrand}/$brandId');
    if (result.data != null) {
      brandOffers = BrandOffer.fromJson(result.data as Map<String, dynamic>);
      visibleBrandOffers.offers = brandOffers.offers;
      setState(ViewState.idle);
    } else if (result.exception != null) {
      visibleBrandOffers = BrandOffer.fromJson(brandOffersDummyData);
      setState(ViewState.idle);
    }
  }

  updatefilter(String? offerType, bool? expiringType) {
    currentOfferType = offerType;
    currentExpiringType = expiringType;
    visibleBrandOffers.offers = brandOffers.offers.where((element) {
      print(element.rewardType);
      if (currentOfferType == null) {
        return true;
      }
      return element.rewardType == currentOfferType?.toUpperCase();
    }).toList();
    visibleBrandOffers.offers = visibleBrandOffers.offers.where((element) {
      if (currentExpiringType == null) {
        return true;
      } else if (!currentExpiringType!) {
        return true;
      }
      return DateTime.fromMillisecondsSinceEpoch(element.expiryDate! * 1000)
              .difference(DateTime.now())
              .inDays <
          7;
    }).toList();
    setState(ViewState.idle);
  }
}
