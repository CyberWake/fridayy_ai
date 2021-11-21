import 'package:flutter/material.dart';
import 'package:fridayy_one/business_logic/models/new_user_overview_model.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/widgets/offer.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class OffersInfoWidgets extends StatelessWidget {
  const OffersInfoWidgets({
    Key? key,
    this.onTap,
    required this.offersData,
  }) : super(key: key);
  final void Function()? onTap;
  final Offers offersData;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: sizeConfig.getPropHeight(340),
        width: sizeConfig.getPropWidth(379),
        padding: EdgeInsets.only(
          left: sizeConfig.getPropWidth(32.65),
          right: sizeConfig.getPropWidth(6),
          top: sizeConfig.getPropWidth(20.15),
          bottom: sizeConfig.getPropWidth(20.15),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            sizeConfig.getPropWidth(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                InkWell(
                  onTap: onTap,
                  child: SizedBox(
                    height: sizeConfig.getPropHeight(90),
                    width: sizeConfig.getPropWidth(90), //128.69
                    child: SfRadialGauge(
                      enableLoadingAnimation: true,
                      axes: <RadialAxis>[
                        RadialAxis(
                          showLabels: false,
                          showTicks: false,
                          radiusFactor: 1.35,
                          minimum: 0,
                          maximum: 240,
                          axisLineStyle: const AxisLineStyle(
                            cornerStyle: CornerStyle.bothFlat,
                            thickness: 10,
                            color: Color(0xFFFFB731),
                          ),
                          annotations: <GaugeAnnotation>[
                            GaugeAnnotation(
                              angle: 90,
                              positionFactor: 0,
                              widget: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    "10",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(fontSize: 20),
                                  ),
                                ],
                              ),
                            )
                          ],
                          pointers: <GaugePointer>[
                            RangePointer(
                              value: 240 * (10 / 20),
                              width: 10,
                              cornerStyle: CornerStyle.bothFlat,
                              color: const Color(0xFFF67280),
                              gradient: const SweepGradient(
                                colors: <Color>[
                                  Color(0xFFFF7676),
                                  Color(0xFFF54EA2)
                                ],
                                stops: <double>[0.25, 0.75],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child: const Text(
                    'Total Offers',
                  ),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Offer(
                  offerCount: 10,
                  isExpiredOffer: false,
                  height: 32,
                ),
                SizedBox(
                  height: sizeConfig.getPropWidth(40),
                ),
                Offer(
                  offerCount: 10,
                  isExpiredOffer: true,
                  height: 32,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
