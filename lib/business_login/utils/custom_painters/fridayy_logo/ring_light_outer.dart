import 'package:flutter/material.dart';

class LogoRingLightOuter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    final Path path_0 = Path();
    path_0.moveTo(size.width*0.7618750,size.height*0.2381250);
    path_0.cubicTo(size.width*0.8075000,size.height*0.2837500,size.width*0.8104625,size.height*0.3545250,size.width*0.8259750,size.height*0.4126250);
    path_0.cubicTo(size.width*0.8419875,size.height*0.4726250,size.width*0.8737875,size.height*0.5359125,size.width*0.8577875,size.height*0.5958625);
    path_0.cubicTo(size.width*0.8422750,size.height*0.6539625,size.width*0.7841875,size.height*0.6930125,size.width*0.7386000,size.height*0.7386000);
    path_0.cubicTo(size.width*0.6930125,size.height*0.7841875,size.width*0.6539625,size.height*0.8422750,size.width*0.5958625,size.height*0.8577875);
    path_0.cubicTo(size.width*0.5358625,size.height*0.8737875,size.width*0.4725750,size.height*0.8419875,size.width*0.4126250,size.height*0.8259750);
    path_0.cubicTo(size.width*0.3545250,size.height*0.8104625,size.width*0.2837500,size.height*0.8075000,size.width*0.2381250,size.height*0.7618750);
    path_0.cubicTo(size.width*0.1925000,size.height*0.7162500,size.width*0.1895375,size.height*0.6454750,size.width*0.1740250,size.height*0.5873750);
    path_0.cubicTo(size.width*0.1580125,size.height*0.5273750,size.width*0.1262125,size.height*0.4640875,size.width*0.1422125,size.height*0.4041375);
    path_0.cubicTo(size.width*0.1577250,size.height*0.3460375,size.width*0.2158125,size.height*0.3069875,size.width*0.2614000,size.height*0.2614000);
    path_0.cubicTo(size.width*0.3069875,size.height*0.2158125,size.width*0.3460375,size.height*0.1577250,size.width*0.4041375,size.height*0.1422125);
    path_0.cubicTo(size.width*0.4641375,size.height*0.1262125,size.width*0.5274250,size.height*0.1580125,size.width*0.5873750,size.height*0.1740250);
    path_0.cubicTo(size.width*0.6454750,size.height*0.1895375,size.width*0.7162500,size.height*0.1925000,size.width*0.7618750,size.height*0.2381250);
    path_0.close();

    final Paint paint0Stroke = Paint()..style=PaintingStyle.stroke..strokeWidth=size.width*0.07851250;
    paint0Stroke.color=const Color(0xffc7c9ee).withOpacity(1.0);
    canvas.drawPath(path_0,paint0Stroke);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
