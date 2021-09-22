import 'package:flutter/material.dart';

class ProfileTabIcon extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0_stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.06250000;
    paint_0_stroke.color = Color(0xff200E32).withOpacity(1.0);
    paint_0_stroke.strokeCap = StrokeCap.round;
    paint_0_stroke.strokeJoin = StrokeJoin.round;
    canvas.drawCircle(Offset(size.width * 0.4824542, size.height * 0.3032513),
        size.width * 0.1990846, paint_0_stroke);

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Color(0xffffffff).withOpacity(1.0);
    canvas.drawCircle(Offset(size.width * 0.4824542, size.height * 0.3032513),
        size.width * 0.1990846, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.1666675, size.height * 0.7792208);
    path_1.cubicTo(
        size.width * 0.1666138,
        size.height * 0.7652250,
        size.width * 0.1697437,
        size.height * 0.7514000,
        size.width * 0.1758208,
        size.height * 0.7387958);
    path_1.cubicTo(
        size.width * 0.1948900,
        size.height * 0.7006542,
        size.width * 0.2486658,
        size.height * 0.6804417,
        size.width * 0.2932883,
        size.height * 0.6712875);
    path_1.cubicTo(
        size.width * 0.3254700,
        size.height * 0.6644208,
        size.width * 0.3580963,
        size.height * 0.6598333,
        size.width * 0.3909238,
        size.height * 0.6575583);
    path_1.cubicTo(
        size.width * 0.4517000,
        size.height * 0.6522208,
        size.width * 0.5128292,
        size.height * 0.6522208,
        size.width * 0.5736083,
        size.height * 0.6575583);
    path_1.cubicTo(
        size.width * 0.6064333,
        size.height * 0.6598583,
        size.width * 0.6390583,
        size.height * 0.6644458,
        size.width * 0.6712458,
        size.height * 0.6712875);
    path_1.cubicTo(
        size.width * 0.7158667,
        size.height * 0.6804417,
        size.width * 0.7696417,
        size.height * 0.6987500,
        size.width * 0.7887125,
        size.height * 0.7387958);
    path_1.cubicTo(
        size.width * 0.8009333,
        size.height * 0.7644958,
        size.width * 0.8009333,
        size.height * 0.7943292,
        size.width * 0.7887125,
        size.height * 0.8200292);
    path_1.cubicTo(
        size.width * 0.7696417,
        size.height * 0.8600750,
        size.width * 0.7158667,
        size.height * 0.8783833,
        size.width * 0.6712458,
        size.height * 0.8871542);
    path_1.cubicTo(
        size.width * 0.6391000,
        size.height * 0.8943042,
        size.width * 0.6064625,
        size.height * 0.8990250,
        size.width * 0.5736083,
        size.height * 0.9012667);
    path_1.cubicTo(
        size.width * 0.5241417,
        size.height * 0.9054583,
        size.width * 0.4744417,
        size.height * 0.9062250,
        size.width * 0.4248667,
        size.height * 0.9035542);
    path_1.cubicTo(
        size.width * 0.4134254,
        size.height * 0.9035542,
        size.width * 0.4023654,
        size.height * 0.9035542,
        size.width * 0.3909238,
        size.height * 0.9012667);
    path_1.cubicTo(
        size.width * 0.3581929,
        size.height * 0.8990500,
        size.width * 0.3256800,
        size.height * 0.8943333,
        size.width * 0.2936696,
        size.height * 0.8871542);
    path_1.cubicTo(
        size.width * 0.2486658,
        size.height * 0.8783833,
        size.width * 0.1952717,
        size.height * 0.8600750,
        size.width * 0.1758208,
        size.height * 0.8200292);
    path_1.cubicTo(
        size.width * 0.1697750,
        size.height * 0.8072750,
        size.width * 0.1666479,
        size.height * 0.7933333,
        size.width * 0.1666675,
        size.height * 0.7792208);
    path_1.close();

    Paint paint_1_stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.06250000;
    paint_1_stroke.color = Color(0xff200E32).withOpacity(1.0);
    paint_1_stroke.strokeCap = StrokeCap.round;
    paint_1_stroke.strokeJoin = StrokeJoin.round;
    canvas.drawPath(path_1, paint_1_stroke);

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = Color(0xffffffff).withOpacity(1.0);
    canvas.drawPath(path_1, paint_1_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
