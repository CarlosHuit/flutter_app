
import 'package:flutter/material.dart';

class GuideLines extends CustomPainter {


  @override
  void paint(Canvas canvas, Size size) {
    print('repaiting');
    // print('s');
    // print('W: ${size.width} - H: ${size.height} - VW ${MediaQuery.of(context).size.width}');
    Paint paint = Paint()
      ..color = Colors.red[200]
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1.0;

    Path path = Path();
    path.moveTo(0, size.height * 0.05);
    path.lineTo(size.width, size.height * 0.05);

    path.moveTo(0, size.height* .35);
    path.lineTo(size.width, size.height * 0.35);

    path.moveTo(0, size.height * .65);
    path.lineTo(size.width, size.height * 0.65);

    path.moveTo(0, size.height * 0.95);
    path.lineTo(size.width, size.height * 0.95);

    canvas.drawPath(path, paint);

  }

  @override
  bool shouldRepaint(GuideLines oldDelegate) {
    return false;
  }

}

