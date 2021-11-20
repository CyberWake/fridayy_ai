import 'package:fridayy_one/business_logic/models/user_model.dart';

abstract class AuthService {
  Future<String> login(UserModel user);
  Future<String> register(UserModel user);
  Future<bool> validateOTP(
    String otpId,
    String otp,
    String mobile,
  );
}
