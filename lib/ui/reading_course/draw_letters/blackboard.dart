import 'package:app19022019/core/src/redux/reading_course/rc_draw_letters/rc_draw_letters_state.dart';
import 'package:flutter/material.dart';

class Blackboard extends CustomPainter {

  List<Offset> points;
  final RCDrawLetterPreferences prefs;
  List<StrokeData> data;

  Blackboard({
    @required this.points,
    @required this.prefs,
    @required this.data,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
    ..strokeCap = prefs.styleLine;

    for (var item in data) {

      paint.color = item.color;
      paint.strokeWidth = item.width;

      for (var i = 0; i < item.points.length - 1; i++) {
        if (item.points[i] != null && item.points[i + 1] != null) {
          canvas.drawLine(item.points[i], item.points[i + 1], paint);
        }
      }

    }

  }

  @override
  bool shouldRepaint(Blackboard oldDelegate) {
    // return oldDelegate.points != points;
    return oldDelegate.data != data;
  }

}
