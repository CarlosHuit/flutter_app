import 'package:flutter/material.dart';

class Blackboard extends CustomPainter {

  List<Offset> points;

  Blackboard({this.points});

  @override
  void paint(Canvas canvas, Size size) {

    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }

  }

  @override
  bool shouldRepaint(Blackboard oldDelegate) {
    return oldDelegate.points != points;
  }

}
