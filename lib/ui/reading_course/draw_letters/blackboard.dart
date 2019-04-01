import 'package:app19022019/core/src/redux/reading_course/rc_draw_letters/rc_draw_letters_state.dart';
import 'package:flutter/material.dart';

class Blackboard extends CustomPainter {

  List<Offset> points;
  final RCDrawLetterPreferences prefs;

  Blackboard({ @required this.points, @required this.prefs });

  @override
  void paint(Canvas canvas, Size size) {

    Paint paint = Paint()
      ..color = prefs.lineColor
      ..strokeCap = prefs.styleLine
      ..strokeWidth = prefs.lineWidth;

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
