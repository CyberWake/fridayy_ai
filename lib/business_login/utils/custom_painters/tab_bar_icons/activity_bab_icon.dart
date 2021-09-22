import 'package:flutter/material.dart';

class ActivityTabIcon extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.3048580, size.height * 0.4250708);
    path_0.lineTo(size.width * 0.3048580, size.height * 0.7109083);

    Paint paint_0_stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.06000000;
    paint_0_stroke.color = Color(0xff200E32).withOpacity(1.0);
    paint_0_stroke.strokeCap = StrokeCap.round;
    paint_0_stroke.strokeJoin = StrokeJoin.round;
    canvas.drawPath(path_0, paint_0_stroke);

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.4915240, size.height * 0.2882996);
    path_1.lineTo(size.width * 0.4915240, size.height * 0.7109125);

    Paint paint_1_stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.06000000;
    paint_1_stroke.color = Color(0xff200E32).withOpacity(1.0);
    paint_1_stroke.strokeCap = StrokeCap.round;
    paint_1_stroke.strokeJoin = StrokeJoin.round;
    canvas.drawPath(path_1, paint_1_stroke);

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_1, paint_1_fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.6751400, size.height * 0.5761208);
    path_2.lineTo(size.width * 0.6751400, size.height * 0.7109125);

    Paint paint_2_stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.06000000;
    paint_2_stroke.color = Color(0xff200E32).withOpacity(1.0);
    paint_2_stroke.strokeCap = StrokeCap.round;
    paint_2_stroke.strokeJoin = StrokeJoin.round;
    canvas.drawPath(path_2, paint_2_stroke);

    Paint paint_2_fill = Paint()..style = PaintingStyle.fill;
    paint_2_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_2, paint_2_fill);

    Path path_3 = Path();
    path_3.moveTo(size.width * 0.6774280, size.height * 0.08333333);
    path_3.lineTo(size.width * 0.3025716, size.height * 0.08333333);
    path_3.cubicTo(
        size.width * 0.1719048,
        size.height * 0.08333333,
        size.width * 0.09000000,
        size.height * 0.1796700,
        size.width * 0.09000000,
        size.height * 0.3160483);
    path_3.lineTo(size.width * 0.09000000, size.height * 0.6839500);
    path_3.cubicTo(
        size.width * 0.09000000,
        size.height * 0.8203292,
        size.width * 0.1715240,
        size.height * 0.9166667,
        size.width * 0.3025716,
        size.height * 0.9166667);
    path_3.lineTo(size.width * 0.6774280, size.height * 0.9166667);
    path_3.cubicTo(
        size.width * 0.8084760,
        size.height * 0.9166667,
        size.width * 0.8900000,
        size.height * 0.8203292,
        size.width * 0.8900000,
        size.height * 0.6839500);
    path_3.lineTo(size.width * 0.8900000, size.height * 0.3160483);
    path_3.cubicTo(
        size.width * 0.8900000,
        size.height * 0.1796700,
        size.width * 0.8084760,
        size.height * 0.08333333,
        size.width * 0.6774280,
        size.height * 0.08333333);
    path_3.close();

    Paint paint_3_stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.06000000;
    paint_3_stroke.color = Color(0xff200E32).withOpacity(1.0);
    paint_3_stroke.strokeCap = StrokeCap.round;
    paint_3_stroke.strokeJoin = StrokeJoin.round;
    canvas.drawPath(path_3, paint_3_stroke);

    Paint paint_3_fill = Paint()..style = PaintingStyle.fill;
    paint_3_fill.color = Color(0xffffffff).withOpacity(1.0);
    canvas.drawPath(path_3, paint_3_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
