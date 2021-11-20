import 'package:flutter/material.dart';

class OnBoardingBackgroundOne extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Path path_0 = Path();
    path_0.moveTo(size.width, size.height * 0.8591835);
    path_0.lineTo(size.width, size.height * 0.006616560);
    path_0.cubicTo(
      size.width * 0.8476813,
      size.height * 0.1288518,
      size.width * 0.6800730,
      size.height * 0.1964867,
      size.width * 0.5040827,
      size.height * 0.1964867,
    );
    path_0.cubicTo(
      size.width * 0.3249416,
      size.height * 0.1964867,
      size.width * 0.1544847,
      size.height * 0.1264087,
      0,
      0,
    );
    path_0.lineTo(0, size.height * 0.8544266);
    path_0.cubicTo(
      size.width * 0.1645455,
      size.height * 0.9511789,
      size.width * 0.3369732,
      size.height * 1.000592,
      size.width * 0.5114672,
      size.height * 0.9991606,
    );
    path_0.cubicTo(
      size.width * 0.6780949,
      size.height * 0.9977890,
      size.width * 0.8426204,
      size.height * 0.9500826,
      size.width,
      size.height * 0.8591835,
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
