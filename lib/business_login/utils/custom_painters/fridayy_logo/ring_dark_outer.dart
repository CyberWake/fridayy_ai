import 'package:flutter/material.dart';

class LogoRingDarkOuter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    final Path path_0 = Path();
    path_0.moveTo(size.width*0.7423875,size.height*0.7423875);
    path_0.cubicTo(size.width*0.7001875,size.height*0.7845750,size.width*0.6346500,size.height*0.7873875,size.width*0.5808625,size.height*0.8017125);
    path_0.cubicTo(size.width*0.5253750,size.height*0.8165250,size.width*0.4667625,size.height*0.8459625,size.width*0.4112750,size.height*0.8311500);
    path_0.cubicTo(size.width*0.3575250,size.height*0.8168000,size.width*0.3213500,size.height*0.7630250,size.width*0.2791625,size.height*0.7208375);
    path_0.cubicTo(size.width*0.2369750,size.height*0.6786500,size.width*0.1832000,size.height*0.6425000,size.width*0.1688500,size.height*0.5887500);
    path_0.cubicTo(size.width*0.1540375,size.height*0.5332625,size.width*0.1834750,size.height*0.4746500,size.width*0.1982875,size.height*0.4191625);
    path_0.cubicTo(size.width*0.2126375,size.height*0.3654125,size.width*0.2154250,size.height*0.2998375,size.width*0.2576125,size.height*0.2576375);
    path_0.cubicTo(size.width*0.2998000,size.height*0.2154375,size.width*0.3653500,size.height*0.2126375,size.width*0.4191375,size.height*0.1983125);
    path_0.cubicTo(size.width*0.4746250,size.height*0.1835000,size.width*0.5332375,size.height*0.1540625,size.width*0.5887250,size.height*0.1688750);
    path_0.cubicTo(size.width*0.6424750,size.height*0.1832250,size.width*0.6786500,size.height*0.2370000,size.width*0.7208375,size.height*0.2791875);
    path_0.cubicTo(size.width*0.7630250,size.height*0.3213750,size.width*0.8168000,size.height*0.3575000,size.width*0.8311500,size.height*0.4112500);
    path_0.cubicTo(size.width*0.8459625,size.height*0.4667375,size.width*0.8165250,size.height*0.5253500,size.width*0.8017125,size.height*0.5808375);
    path_0.cubicTo(size.width*0.7873625,size.height*0.6346500,size.width*0.7845750,size.height*0.7001875,size.width*0.7423875,size.height*0.7423875);
    path_0.close();

    final Paint paint0Stroke = Paint()..style=PaintingStyle.stroke..strokeWidth=size.width*0.07851250;
    paint0Stroke.color=const Color(0xff2128bd).withOpacity(1.0);
    canvas.drawPath(path_0,paint0Stroke);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
