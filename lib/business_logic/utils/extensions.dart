import 'package:fridayy_one/business_logic/utils/enums.dart';

extension GenderExtension on Gender {
  String string() {
    String gender = this.toString().replaceAll('Gender.', '');
    gender = gender.substring(0, 1).toUpperCase() + gender.substring(1);
    return gender;
  }
}
