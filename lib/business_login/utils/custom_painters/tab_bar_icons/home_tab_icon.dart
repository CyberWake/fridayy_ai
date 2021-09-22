import 'package:flutter/material.dart';

class HomeTabIcon extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.3815508, size.height * 0.8654750);
    path_0.lineTo(size.width * 0.3815508, size.height * 0.7376958);
    path_0.cubicTo(
        size.width * 0.3815500,
        size.height * 0.7051917,
        size.width * 0.4080467,
        size.height * 0.6787833,
        size.width * 0.4408750,
        size.height * 0.6785667);
    path_0.lineTo(size.width * 0.5611292, size.height * 0.6785667);
    path_0.cubicTo(
        size.width * 0.5941125,
        size.height * 0.6785667,
        size.width * 0.6208542,
        size.height * 0.7050375,
        size.width * 0.6208542,
        size.height * 0.7376958);
    path_0.lineTo(size.width * 0.6208542, size.height * 0.7376958);
    path_0.lineTo(size.width * 0.6208542, size.height * 0.8658708);
    path_0.cubicTo(
        size.width * 0.6208458,
        size.height * 0.8934667,
        size.width * 0.6430958,
        size.height * 0.9160208,
        size.width * 0.6709583,
        size.height * 0.9166667);
    path_0.lineTo(size.width * 0.7511292, size.height * 0.9166667);
    path_0.cubicTo(
        size.width * 0.8310458,
        size.height * 0.9166667,
        size.width * 0.8958333,
        size.height * 0.8525292,
        size.width * 0.8958333,
        size.height * 0.7734083);
    path_0.lineTo(size.width * 0.8958333, size.height * 0.7734083);
    path_0.lineTo(size.width * 0.8958333, size.height * 0.4099100);
    path_0.cubicTo(
        size.width * 0.8954083,
        size.height * 0.3787846,
        size.width * 0.8806458,
        size.height * 0.3495563,
        size.width * 0.8557500,
        size.height * 0.3305429);
    path_0.lineTo(size.width * 0.5815708, size.height * 0.1118875);
    path_0.cubicTo(
        size.width * 0.5335375,
        size.height * 0.07381542,
        size.width * 0.4652583,
        size.height * 0.07381542,
        size.width * 0.4172250,
        size.height * 0.1118875);
    path_0.lineTo(size.width * 0.1442512, size.height * 0.3309400);
    path_0.cubicTo(
        size.width * 0.1192608,
        size.height * 0.3498758,
        size.width * 0.1044746,
        size.height * 0.3791529,
        size.width * 0.1041667,
        size.height * 0.4103067);
    path_0.lineTo(size.width * 0.1041667, size.height * 0.7734083);
    path_0.cubicTo(
        size.width * 0.1041667,
        size.height * 0.8525292,
        size.width * 0.1689533,
        size.height * 0.9166667,
        size.width * 0.2488712,
        size.height * 0.9166667);
    path_0.lineTo(size.width * 0.3290400, size.height * 0.9166667);
    path_0.cubicTo(
        size.width * 0.3575979,
        size.height * 0.9166667,
        size.width * 0.3807487,
        size.height * 0.8937458,
        size.width * 0.3807487,
        size.height * 0.8654750);
    path_0.lineTo(size.width * 0.3807487, size.height * 0.8654750);

    Paint paint_0_stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.06250000;
    paint_0_stroke.color = Color(0xff200E32).withOpacity(1.0);
    paint_0_stroke.strokeCap = StrokeCap.round;
    paint_0_stroke.strokeJoin = StrokeJoin.round;
    canvas.drawPath(path_0, paint_0_stroke);

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Color(0xffffffff).withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
