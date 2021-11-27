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

  //category endpoint
  static const String offerOnCategory = '/user/offers/category';
  static const String offersOnBrand = '/user/offers/brand';

  //spending endpoint
  static const String spendingTransactions = '/user/spends';
  static const String spendingCategory = '/user/spends/categories';
  static const String spendingBrand = '/user/spends/brands';
  static const String spendingOnBrand = '/user/spends/brand';
  static const String spendingOnCategory = '/user/spends/category';

  //user details endpoint
  static const String userProfile = '/user/profile';
  static const String userLogout = '/user/logout';

  //sms endpoint
  static const String processMessages = '/user/process/messages';
  static const String messageTransit = '/user/transit/messages';
}
