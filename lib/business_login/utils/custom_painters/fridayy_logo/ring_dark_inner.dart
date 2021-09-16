import 'package:flutter/material.dart';

class LogoRingDarkInner extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Path path_0 = Path();
    path_0.moveTo(size.width * 0.6422125, size.height * 0.3577875);
    path_0.cubicTo(
      size.width * 0.6669625,
      size.height * 0.3825375,
      size.width * 0.6686000,
      size.height * 0.4210000,
      size.width * 0.6770250,
      size.height * 0.4525500,
    );
    path_0.cubicTo(
      size.width * 0.6857750,
      size.height * 0.4850500,
      size.width * 0.7029875,
      size.height * 0.5195000,
      size.width * 0.6943000,
      size.height * 0.5520625,
    );
    path_0.cubicTo(
      size.width * 0.6858750,
      size.height * 0.5836125,
      size.width * 0.6543000,
      size.height * 0.6048125,
      size.width * 0.6295750,
      size.height * 0.6295625,
    );
    path_0.cubicTo(
      size.width * 0.6048500,
      size.height * 0.6543125,
      size.width * 0.5836125,
      size.height * 0.6858125,
      size.width * 0.5520750,
      size.height * 0.6942875,
    );
    path_0.cubicTo(
      size.width * 0.5195750,
      size.height * 0.7029750,
      size.width * 0.4851250,
      size.height * 0.6857000,
      size.width * 0.4525625,
      size.height * 0.6770125,
    );
    path_0.cubicTo(
      size.width * 0.4210125,
      size.height * 0.6685875,
      size.width * 0.3825625,
      size.height * 0.6670125,
      size.width * 0.3578000,
      size.height * 0.6422000,
    );
    path_0.cubicTo(
      size.width * 0.3330375,
      size.height * 0.6173875,
      size.width * 0.3314000,
      size.height * 0.5790000,
      size.width * 0.3229750,
      size.height * 0.5475000,
    );
    path_0.cubicTo(
      size.width * 0.3142875,
      size.height * 0.5150000,
      size.width * 0.2970125,
      size.height * 0.4805500,
      size.width * 0.3057000,
      size.height * 0.4479875,
    );
    path_0.cubicTo(
      size.width * 0.3141250,
      size.height * 0.4164375,
      size.width * 0.3457000,
      size.height * 0.3952375,
      size.width * 0.3704250,
      size.height * 0.3704875,
    );
    path_0.cubicTo(
      size.width * 0.3951500,
      size.height * 0.3457375,
      size.width * 0.4163875,
      size.height * 0.3142375,
      size.width * 0.4479250,
      size.height * 0.3057625,
    );
    path_0.cubicTo(
      size.width * 0.4804250,
      size.height * 0.2970750,
      size.width * 0.5148750,
      size.height * 0.3143500,
      size.width * 0.5474375,
      size.height * 0.3230375,
    );
    path_0.cubicTo(
      size.width * 0.5790000,
      size.height * 0.3314000,
      size.width * 0.6175000,
      size.height * 0.3330375,
      size.width * 0.6422125,
      size.height * 0.3577875,
    );
    path_0.close();

    final Paint paint0Stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.04111250;
    paint0Stroke.color = const Color(0xff2128bd).withOpacity(1.0);
    canvas.drawPath(path_0, paint0Stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
