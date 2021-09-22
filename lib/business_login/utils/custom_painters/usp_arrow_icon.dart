import 'package:flutter/material.dart';

class ArrowIcon extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Path path_0 = Path();
    path_0.moveTo(size.width * 0.5000000, size.height * 0.9404667);
    path_0.cubicTo(
      size.width * 0.7554000,
      size.height * 0.9404667,
      size.width * 0.9625000,
      size.height * 0.7432762,
      size.width * 0.9625000,
      size.height * 0.4999905,
    );
    path_0.cubicTo(
      size.width * 0.9625000,
      size.height * 0.2567505,
      size.width * 0.7554000,
      size.height * 0.05951238,
      size.width * 0.5000000,
      size.height * 0.05951238,
    );
    path_0.cubicTo(
      size.width * 0.2446000,
      size.height * 0.05951238,
      size.width * 0.03750000,
      size.height * 0.2567505,
      size.width * 0.03750000,
      size.height * 0.4999905,
    );
    path_0.cubicTo(
      size.width * 0.03750000,
      size.height * 0.7432762,
      size.width * 0.2446000,
      size.height * 0.9404667,
      size.width * 0.5000000,
      size.height * 0.9404667,
    );
    path_0.close();

    final Paint paint0Stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.07500000;
    paint0Stroke.color = const Color(0xff262627).withOpacity(1.0);
    paint0Stroke.strokeCap = StrokeCap.round;
    paint0Stroke.strokeJoin = StrokeJoin.round;
    canvas.drawPath(path_0, paint0Stroke);

    final Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = Colors.transparent;
    canvas.drawPath(path_0, paint0Fill);

    final Path path_1 = Path();
    path_1.moveTo(size.width * 0.4278810, size.height * 0.6652810);
    path_1.lineTo(size.width * 0.6021800, size.height * 0.4999952);
    path_1.lineTo(size.width * 0.4278810, size.height * 0.3347119);

    final Paint paint1Stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.07500000;
    paint1Stroke.color = const Color(0xff262627).withOpacity(1.0);
    paint1Stroke.strokeCap = StrokeCap.round;
    paint1Stroke.strokeJoin = StrokeJoin.round;
    canvas.drawPath(path_1, paint1Stroke);

    final Paint paint1Fill = Paint()..style = PaintingStyle.fill;
    paint1Fill.color = const Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_1, paint1Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
