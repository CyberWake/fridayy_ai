import 'package:flutter/material.dart';
import 'package:fridayy_one/business_logic/models/new_user_overview_model.dart';
import 'package:fridayy_one/services/service_locator.dart';

class LovedBrandCard extends StatelessWidget {
  const LovedBrandCard({Key? key, required this.lovedBrand}) : super(key: key);
  final LovedBrand lovedBrand;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(sizeConfig.getPropHeight(27)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: sizeConfig.getPropHeight(140),
            child: Center(
              child: Image.network(
                'https://friday-images.s3.ap-south-1.amazonaws.com/${lovedBrand.brandId}.jpeg',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Text(
            lovedBrand.brandName,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontSize: 16, color: Colors.black),
          ),
          Text(
            "Loves you the most!",
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 24,
              color: const Color(0xFF2128BD),
              shadows: [
                const Shadow(
                  blurRadius: 2,
                  color: Colors.yellow,
                  offset: Offset(2, 2),
                )
              ],
            ),
          ),
          SizedBox(
            height: sizeConfig.getPropHeight(10),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lovedBrand.count.toString(),
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 40,
                    color: const Color(0xFF2128BD),
                    shadows: [
                      const Shadow(
                        blurRadius: 2,
                        color: Color(0xFFFAB8C4),
                        offset: Offset(2, 2),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: sizeConfig.getPropWidth(10),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "offers",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 24,
                        color: const Color(0xFF2128BD),
                        shadows: [
                          const Shadow(
                            blurRadius: 2,
                            color: Color(0xFFFAB8C4),
                            offset: Offset(2, 2),
                          )
                        ],
                      ),
                    ),
                    Text(
                      "in last 3 months",
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(fontSize: 12),
                    ),
                  ],
                ),
                const Spacer(),
                Image.asset('assets/images/loved_emoji.png')
              ],
            ),
          )
        ],
      ),
    );
  }
}
