import 'package:flutter/material.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class OfferMeter extends StatelessWidget {
  const OfferMeter({Key? key, required this.size, this.onTap})
      : super(key: key);
  final double size;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: sizeConfig.getPropHeight(size),
        width: sizeConfig.getPropWidth(size), //128.69
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
                        '2000',
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
                const RangePointer(
                  value: 136,
                  width: 10,
                  cornerStyle: CornerStyle.bothFlat,
                  color: Color(0xFFF67280),
                  gradient: SweepGradient(
                    colors: <Color>[Color(0xFFFF7676), Color(0xFFF54EA2)],
                    stops: <double>[0.25, 0.75],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
