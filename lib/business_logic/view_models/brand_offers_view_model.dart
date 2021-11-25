import 'package:fridayy_one/business_logic/models/new_models/brand_offers.dart';
import 'package:fridayy_one/business_logic/utils/api_constants.dart';
import 'package:fridayy_one/business_logic/utils/dummy_data.dart';
import 'package:fridayy_one/business_logic/utils/enums.dart';
import 'package:fridayy_one/business_logic/view_models/base_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';

class BrandOffersViewModel extends BaseModel {
  BrandOffer brandOffers = BrandOffer(offers: []);

  void init(String brandId) {
    setState(ViewState.busy);
    fetchOffers(brandId);
  }

  fetchOffers(String brandId) async {
    final result =
        await apiService.getRequest(ApiConstants.brandOffers + brandId);
    if (result.data != null) {
      brandOffers = BrandOffer.fromJson(result.data as Map<String, dynamic>);
      setState(ViewState.idle);
    } else if (result.exception != null) {
      brandOffers = BrandOffer.fromJson(brandOffersDummyData);
      setState(ViewState.idle);
    }
  }
}
