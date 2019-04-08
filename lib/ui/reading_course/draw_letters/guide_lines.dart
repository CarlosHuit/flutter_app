
import 'package:flutter/material.dart';

class GuideLines extends CustomPainter {


  @override
  void paint(Canvas canvas, Size size) {

    Paint paint = Paint()
      ..color = Colors.blueAccent[700]
      ..style   = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1.5;
    
    final w = size.width;
    final h = size.height;

    Path path = Path();

    path.moveTo( 0, h * 0.05);
    path.lineTo( w, h * 0.05);

    path.moveTo( 0, h * 0.35);
    path.lineTo( w, h * 0.35);

    path.moveTo( 0, h * 0.65);
    path.lineTo( w, h * 0.65);

    path.moveTo( 0, h * 0.95);
    path.lineTo( w, h * 0.95);

    canvas.drawPath(path, paint);

  }

  @override
  bool shouldRepaint(GuideLines oldDelegate) => false;

}

