import 'package:flutter/material.dart';

class OnBoardingBackgroundZero extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.3431151);
    path_0.lineTo(0, size.height * 0.07491925);
    path_0.lineTo(size.width * 0.2786107, 0);
    path_0.cubicTo(
      size.width * 0.3944891,
      size.height * 0.2867302,
      size.width * 0.6601144,
      size.height * 0.5179742,
      size.width,
      size.height * 0.6321746,
    );
    path_0.lineTo(size.width, size.height * 0.9996567);
    path_0.cubicTo(
      size.width * 0.8194672,
      size.height * 0.9558909,
      size.width * 0.6480389,
      size.height * 0.8875952,
      size.width * 0.4932993,
      size.height * 0.7967540,
    );
    path_0.cubicTo(
      size.width * 0.2886253,
      size.height * 0.6765992,
      size.width * 0.1205608,
      size.height * 0.5213472,
      0,
      size.height * 0.3431151,
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
