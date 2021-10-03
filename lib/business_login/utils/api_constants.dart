class ApiConstants {
  static const String baseUrl = "https://app.fridayy.ai";
  static const String authKey = 'PQwnTq2cnaHS0YOybjb2';

  //auth endpoints
  static const String register = "/user/register/mobile";
  static const String registerOtpValidate = "/user/register/otp/validate";
  static const String login = "/user/login/mobile";
  static const String loginOtpValidate = "/user/login/otp/validate";

  //homepage endpoint
  static const String userOverview = '/user/overview';
  static const String categoryOffers = '/user/offers/category';
  static const String offerDetails = '/user/offer';
  static const String spendingTransactions = '/user/spendings/period';
  static const String spendingCategory = '/user/spendings/category';
  static const String spendingBrand = '/user/spendings/brand';
}
