import 'package:flutter/material.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/widgets/offer.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class OfferCard extends StatelessWidget {
  const OfferCard({
    Key? key,
    this.onTap,
    required this.totalOffers,
    this.onActiveTap,
    this.onExpiredTap,
    required this.activeOffers,
    required this.inActiveOffers,
  }) : super(key: key);
  final void Function()? onActiveTap;
  final void Function()? onExpiredTap;
  final void Function()? onTap;
  final double totalOffers;
  final double activeOffers;
  final double inActiveOffers;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: sizeConfig.getPropHeight(169),
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
                                    totalOffers.toInt().toString(),
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
                              value: 240 * (activeOffers / totalOffers),
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
                  onTap: onActiveTap,
                  offerCount: activeOffers.round(),
                  isExpiredOffer: false,
                  height: 32,
                ),
                SizedBox(
                  height: sizeConfig.getPropWidth(44),
                ),
                Offer(
                  onTap: onExpiredTap,
                  offerCount: inActiveOffers.round(),
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
