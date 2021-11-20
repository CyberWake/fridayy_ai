import 'package:flutter/material.dart';

class OnBoardingBackgroundTwo extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.9996791);
    path_0.lineTo(0, size.height * 0.6392446);
    path_0.cubicTo(
      size.width * 0.3540876,
      size.height * 0.5282838,
      size.width * 0.6308613,
      size.height * 0.2929609,
      size.width * 0.7473601,
      0,
    );
    path_0.lineTo(size.width, size.height * 0.06504521);
    path_0.lineTo(size.width, size.height * 0.3787417);
    path_0.cubicTo(
      size.width * 0.8839027,
      size.height * 0.5377417,
      size.width * 0.7281849,
      size.height * 0.6770489,
      size.width * 0.5412068,
      size.height * 0.7873170,
    );
    path_0.cubicTo(
      size.width * 0.3770341,
      size.height * 0.8841350,
      size.width * 0.1935652,
      size.height * 0.9557358,
      0,
      size.height * 0.9996791,
    );
    path_0.close();

    final Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = const Color(0xffCEF9F2).withOpacity(1.0);
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
