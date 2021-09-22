import 'package:flutter/material.dart';

class TicketIcon extends CustomPainter {
  TicketIcon({required this.color});
  final Color color;
  @override
  void paint(Canvas canvas, Size size) {
    final Path path_0 = Path();
    path_0.moveTo(size.width * 0.5840727, size.height * 0.09211789);
    path_0.lineTo(size.width * 0.5840727, size.height * 0.2194863);

    final Paint paint0Stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.06818182;
    paint0Stroke.color = color;
    paint0Stroke.strokeCap = StrokeCap.round;
    paint0Stroke.strokeJoin = StrokeJoin.round;
    canvas.drawPath(path_0, paint0Stroke);

    final Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = color;
    canvas.drawPath(path_0, paint0Fill);

    final Path path_1 = Path();
    path_1.moveTo(size.width * 0.5840727, size.height * 0.8031579);
    path_1.lineTo(size.width * 0.5840727, size.height * 0.9096842);

    final Paint paint1Stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.06818182;
    paint1Stroke.color = color;
    paint1Stroke.strokeCap = StrokeCap.round;
    paint1Stroke.strokeJoin = StrokeJoin.round;
    canvas.drawPath(path_1, paint1Stroke);

    final Paint paint1Fill = Paint()..style = PaintingStyle.fill;
    paint1Fill.color = color;
    canvas.drawPath(path_1, paint1Fill);

    final Path path_2 = Path();
    path_2.moveTo(size.width * 0.5840727, size.height * 0.6223526);
    path_2.lineTo(size.width * 0.5840727, size.height * 0.3686137);

    final Paint paint2Stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.06818182;
    paint2Stroke.color = color;
    paint2Stroke.strokeCap = StrokeCap.round;
    paint2Stroke.strokeJoin = StrokeJoin.round;
    canvas.drawPath(path_2, paint2Stroke);

    final Paint paint2Fill = Paint()..style = PaintingStyle.fill;
    paint2Fill.color = color;
    canvas.drawPath(path_2, paint2Fill);

    final Path path_3 = Path();
    path_3.moveTo(size.width * 0.8046409, size.height * 0.9210526);
    path_3.cubicTo(
      size.width * 0.8874636,
      size.height * 0.9210526,
      size.width * 0.9545455,
      size.height * 0.8443474,
      size.width * 0.9545455,
      size.height * 0.7496368,
    );
    path_3.lineTo(size.width * 0.9545455, size.height * 0.6131895);
    path_3.cubicTo(
      size.width * 0.8997409,
      size.height * 0.6131895,
      size.width * 0.8556045,
      size.height * 0.5627211,
      size.width * 0.8556045,
      size.height * 0.5000542,
    );
    path_3.cubicTo(
      size.width * 0.8556045,
      size.height * 0.4373868,
      size.width * 0.8997409,
      size.height * 0.3868626,
      size.width * 0.9545455,
      size.height * 0.3868626,
    );
    path_3.lineTo(size.width * 0.9545000, size.height * 0.2503611);
    path_3.cubicTo(
      size.width * 0.9545000,
      size.height * 0.1556553,
      size.width * 0.8873682,
      size.height * 0.07894737,
      size.width * 0.8045955,
      size.height * 0.07894737,
    );
    path_3.lineTo(size.width * 0.1954055, size.height * 0.07894737);
    path_3.cubicTo(
      size.width * 0.1126314,
      size.height * 0.07894737,
      size.width * 0.04550182,
      size.height * 0.1556553,
      size.width * 0.04550182,
      size.height * 0.2503611,
    );
    path_3.lineTo(size.width * 0.04545455, size.height * 0.3913079);
    path_3.cubicTo(
      size.width * 0.1002577,
      size.height * 0.3913079,
      size.width * 0.1443945,
      size.height * 0.4373868,
      size.width * 0.1443945,
      size.height * 0.5000542,
    );
    path_3.cubicTo(
      size.width * 0.1443945,
      size.height * 0.5627211,
      size.width * 0.1002577,
      size.height * 0.6131895,
      size.width * 0.04545455,
      size.height * 0.6131895,
    );
    path_3.lineTo(size.width * 0.04545455, size.height * 0.7496368);
    path_3.cubicTo(
      size.width * 0.04545455,
      size.height * 0.8443474,
      size.width * 0.1125364,
      size.height * 0.9210526,
      size.width * 0.1953577,
      size.height * 0.9210526,
    );
    path_3.lineTo(size.width * 0.8046409, size.height * 0.9210526);
    path_3.close();

    final Paint paint3Stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.06818182;
    paint3Stroke.color = color;
    paint3Stroke.strokeCap = StrokeCap.round;
    paint3Stroke.strokeJoin = StrokeJoin.round;
    canvas.drawPath(path_3, paint3Stroke);

    final Paint paint3Fill = Paint()..style = PaintingStyle.fill;
    paint3Fill.color = const Color(0xffffffff).withOpacity(1.0);
    canvas.drawPath(path_3, paint3Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
