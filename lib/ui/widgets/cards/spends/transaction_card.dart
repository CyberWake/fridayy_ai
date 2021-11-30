import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fridayy_one/business_logic/models/spends_model.dart';
import 'package:fridayy_one/business_logic/utils/extensions.dart';
import 'package:fridayy_one/business_logic/utils/fridayy_svg.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/views/HomePages/spend/spend_view.dart';

class SpendsTransactionCard extends StatelessWidget {
  const SpendsTransactionCard({Key? key, required this.spend, required this.id})
      : super(key: key);
  final SpendsModel spend;
  final String? id;

  Widget getTransactionIcon() {
    switch (spend.paymentType) {
      case 'CARD':
        return const Icon(
          Icons.payment,
          color: Color(0xFF2128BD),
        );
      case 'UPI':
        return SvgPicture.string(FridayySvg.upiIcon);
      default:
        return const Icon(
          Icons.credit_score,
          color: Color(0xFF2128BD),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedBuilder: (context, onTap) {
        return ListTile(
          leading: Container(
            width: sizeConfig.getPropHeight(44),
            height: sizeConfig.getPropHeight(44),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                sizeConfig.getPropWidth(8),
              ),
              color: const Color(0xFFF9F9F9),
            ),
            child: id == null
                ? CachedNetworkImage(
                    imageUrl:
                        'https://friday-images.s3.ap-south-1.amazonaws.com/${spend.brandId ?? id}.jpeg',
                    imageBuilder: (context, imageProvider) => Container(
                      width: sizeConfig.getPropHeight(44),
                      height: sizeConfig.getPropHeight(44),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          sizeConfig.getPropWidth(8),
                        ),
                        color: const Color(0xFFF9F9F9),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  )
                : getTransactionIcon(),
          ),
          title: id == null
              ? Text(
                  spend.brandName ?? '',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                )
              : Text(
                  spend.date?.toDateddMMMyyyy() ?? '',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: 14,
                        color: const Color(0xFF717E95),
                      ),
                ),
          subtitle: id == null
              ? Text(
                  spend.date?.toDateddMMMyyyy() ?? '',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: 14,
                        color: const Color(0xFF717E95),
                      ),
                )
              : Text(
                  spend.paymentType ?? 'Online',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                ),
          trailing: Text(
            "₹ ${spend.amount.toStringAsFixed(1)}",
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontSize: 16,
                  color: const Color(0xFF19B832),
                ),
          ),
        );
      },
      openBuilder: (context, onTap) {
        return SpendView(
          spendId: spend.spendId!,
        );
      },
      transitionDuration: const Duration(milliseconds: 750),
      closedElevation: 0.0,
      openElevation: 0.0,
      tappable: true,
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      closedColor: Colors.transparent,
    );
  }
}
