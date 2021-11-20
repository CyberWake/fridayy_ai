import 'package:flutter/material.dart';

class LogoRingLightInner extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Path path_0 = Path();
    path_0.moveTo(size.width * 0.3463500, size.height * 0.3463500);
    path_0.cubicTo(
      size.width * 0.3731000,
      size.height * 0.3196000,
      size.width * 0.4146500,
      size.height * 0.3178375,
      size.width * 0.4487375,
      size.height * 0.3087375,
    );
    path_0.cubicTo(
      size.width * 0.4839125,
      size.height * 0.2993500,
      size.width * 0.5210750,
      size.height * 0.2806875,
      size.width * 0.5562375,
      size.height * 0.2900750,
    );
    path_0.cubicTo(
      size.width * 0.5903250,
      size.height * 0.2991750,
      size.width * 0.6132375,
      size.height * 0.3332625,
      size.width * 0.6399875,
      size.height * 0.3600125,
    );
    path_0.cubicTo(
      size.width * 0.6667375,
      size.height * 0.3867625,
      size.width * 0.7008250,
      size.height * 0.4096625,
      size.width * 0.7099875,
      size.height * 0.4437625,
    );
    path_0.cubicTo(
      size.width * 0.7193750,
      size.height * 0.4789375,
      size.width * 0.7007125,
      size.height * 0.5161000,
      size.width * 0.6913250,
      size.height * 0.5512625,
    );
    path_0.cubicTo(
      size.width * 0.6822250,
      size.height * 0.5853500,
      size.width * 0.6804625,
      size.height * 0.6269000,
      size.width * 0.6537125,
      size.height * 0.6536500,
    );
    path_0.cubicTo(
      size.width * 0.6269625,
      size.height * 0.6804000,
      size.width * 0.5853500,
      size.height * 0.6821625,
      size.width * 0.5512500,
      size.height * 0.6912500,
    );
    path_0.cubicTo(
      size.width * 0.5160750,
      size.height * 0.7006375,
      size.width * 0.4789125,
      size.height * 0.7193000,
      size.width * 0.4437500,
      size.height * 0.7099125,
    );
    path_0.cubicTo(
      size.width * 0.4096625,
      size.height * 0.7008125,
      size.width * 0.3867500,
      size.height * 0.6667250,
      size.width * 0.3600000,
      size.height * 0.6399125,
    );
    path_0.cubicTo(
      size.width * 0.3332500,
      size.height * 0.6131000,
      size.width * 0.2991625,
      size.height * 0.5902625,
      size.width * 0.2900625,
      size.height * 0.5561625,
    );
    path_0.cubicTo(
      size.width * 0.2806750,
      size.height * 0.5209875,
      size.width * 0.2993375,
      size.height * 0.4838250,
      size.width * 0.3087250,
      size.height * 0.4486625,
    );
    path_0.cubicTo(
      size.width * 0.3178375,
      size.height * 0.4146500,
      size.width * 0.3196000,
      size.height * 0.3731000,
      size.width * 0.3463500,
      size.height * 0.3463500,
    );
    path_0.close();

    final Paint paint0Stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.04111250;
    paint0Stroke.color = const Color(0xffc7c9ee).withOpacity(1.0);
    canvas.drawPath(path_0, paint0Stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
