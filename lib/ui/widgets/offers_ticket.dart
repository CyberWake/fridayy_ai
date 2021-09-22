import 'package:flutter/material.dart';
import 'package:fridayy_one/business_login/utils/custom_painters/ticket_icon.dart';
import 'package:fridayy_one/services/service_locator.dart';

class OfferTicket extends StatelessWidget {
  const OfferTicket({
    Key? key,
    required this.isExpiredTicket,
    required this.size,
  }) : super(key: key);
  final bool isExpiredTicket;
  final double size;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(
        sizeConfig.getPropWidth(size),
        sizeConfig.getPropWidth(size) * 0.8636363636363636,
      ), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
      painter: TicketIcon(
        color: isExpiredTicket
            ? const Color(0xffFFDC60).withOpacity(1.0)
            : const Color(0xff2128BD).withOpacity(1.0),
      ),
    );
  }
}
