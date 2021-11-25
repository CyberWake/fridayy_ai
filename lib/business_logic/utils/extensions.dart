import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fridayy_one/business_logic/utils/enums.dart';
import 'package:fridayy_one/business_logic/utils/fridayy_svg.dart';

extension GenderExtension on Gender {
  String string() {
    String gender = this.toString().replaceAll('Gender.', '');
    gender = gender.substring(0, 1).toUpperCase() + gender.substring(1);
    return gender;
  }
}

extension Category on String {
  String getName() {
    switch (this) {
      case 'FAD':
        return 'Food & Drinks';
      case 'MDCL':
        return 'Medical';
      case 'UTL':
        return 'Utilities';
      case 'TRVL':
        return 'Travel';
      case 'LUX':
        return 'Shopping';
      case 'FIN':
        return 'Finance';
      case 'OTH':
        return 'Others';
      case 'EAD':
        return 'Education & Development';
      case 'EXP':
        return 'Expired';
      case 'ACT':
        return 'Active';
      case 'EXS':
        return 'Expiring Soon';
      default:
        return "";
    }
  }

  int getIndex() {
    switch (this) {
      case 'FAD':
        return 0;
      case 'LUX':
        return 1;
      case 'TRVL':
        return 2;
      case 'FIN':
        return 3;
      case 'MDCL':
        return 4;
      case 'UTL':
        return 5;
      case 'EAD':
        return 6;
      case 'OTH':
        return 7;
      default:
        return -1;
    }
  }

  Color getColor() {
    switch (this) {
      case 'FAD':
        return const Color(0xFFF86F34);
      case 'MDCL':
        return const Color(0xFF2128BD);
      case 'UTL':
        return const Color(0xFF75CDD3);
      case 'TRVL':
        return const Color(0xFFFFB731);
      case 'LUX':
        return const Color(0xFF16331C);
      case 'FIN':
        return const Color(0xFF0A8677);
      case 'OTH':
        return const Color(0xFFC61C1C);
      case 'EAD':
        return const Color(0xFF14EDAA);
      case 'EXP':
        return const Color(0xFFF14A25);
      case 'ACT':
        return const Color(0xFFB160B7);
      case 'EXS':
        return const Color(0xFFFFE500);
      default:
        return const Color(0xFFFFFFFF);
    }
  }

  Widget getSvgIcon() {
    switch (this) {
      case 'FAD':
        return SvgPicture.string(FridayySvg.foodIcon);
      case 'MDCL':
        return SvgPicture.string(FridayySvg.medicineIcon);
      case 'UTL':
        return SvgPicture.string(FridayySvg.utilitiesIcon);
      case 'TRVL':
        return SvgPicture.string(FridayySvg.travelIcon);
      case 'LUX':
        return SvgPicture.string(FridayySvg.shoppingIcon);
      case 'FIN':
        return SvgPicture.string(FridayySvg.financeIcon);
      case 'OTH':
        return SvgPicture.string(FridayySvg.othersIcon);
      case 'EAD':
        return SvgPicture.string(FridayySvg.educationIcon);
      default:
        return Container();
    }
  }
}
