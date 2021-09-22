import 'package:flutter/material.dart';

class ChartTabIcon extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.3097948, size.height * 0.6158958);
    path_0.lineTo(size.width * 0.4295200, size.height * 0.4538083);
    path_0.lineTo(size.width * 0.5660880, size.height * 0.5655542);
    path_0.lineTo(size.width * 0.6832520, size.height * 0.4080404);

    Paint paint_0_stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.06000000;
    paint_0_stroke.color = Color(0xff200E32).withOpacity(1.0);
    paint_0_stroke.strokeCap = StrokeCap.round;
    paint_0_stroke.strokeJoin = StrokeJoin.round;
    canvas.drawPath(path_0, paint_0_stroke);

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Color(0xffffffff).withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);

    Paint paint_1_stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.06000000;
    paint_1_stroke.color = Color(0xff200E32).withOpacity(1.0);
    paint_1_stroke.strokeCap = StrokeCap.round;
    paint_1_stroke.strokeJoin = StrokeJoin.round;
    canvas.drawCircle(Offset(size.width * 0.8198160, size.height * 0.1750112),
        size.width * 0.07688800, paint_1_stroke);

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = Color(0xffffffff).withOpacity(1.0);
    canvas.drawCircle(Offset(size.width * 0.8198160, size.height * 0.1750112),
        size.width * 0.07688800, paint_1_fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.6169800, size.height * 0.1300050);
    path_2.lineTo(size.width * 0.3262716, size.height * 0.1300050);
    path_2.cubicTo(
        size.width * 0.2058140,
        size.height * 0.1300050,
        size.width * 0.1311232,
        size.height * 0.2188683,
        size.width * 0.1311232,
        size.height * 0.3443450);
    path_2.lineTo(size.width * 0.1311232, size.height * 0.6811125);
    path_2.cubicTo(
        size.width * 0.1311232,
        size.height * 0.8065875,
        size.width * 0.2043496,
        size.height * 0.8950708,
        size.width * 0.3262716,
        size.height * 0.8950708);
    path_2.lineTo(size.width * 0.6704360, size.height * 0.8950708);
    path_2.cubicTo(
        size.width * 0.7908960,
        size.height * 0.8950708,
        size.width * 0.8655840,
        size.height * 0.8065875,
        size.width * 0.8655840,
        size.height * 0.6811125);
    path_2.lineTo(size.width * 0.8655840, size.height * 0.3878233);

    Paint paint_2_stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.06000000;
    paint_2_stroke.color = Color(0xff200E32).withOpacity(1.0);
    paint_2_stroke.strokeCap = StrokeCap.round;
    paint_2_stroke.strokeJoin = StrokeJoin.round;
    canvas.drawPath(path_2, paint_2_stroke);

    Paint paint_2_fill = Paint()..style = PaintingStyle.fill;
    paint_2_fill.color = Color(0xffffffff).withOpacity(1.0);
    canvas.drawPath(path_2, paint_2_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
