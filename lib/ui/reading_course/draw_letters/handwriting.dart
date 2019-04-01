
import 'package:app19022019/core/src/redux/reading_course/rc_draw_letters/rc_draw_letters_state.dart';
import 'package:flutter/material.dart';

class Handwriting extends CustomPainter {

  final List<List<Offset>> coordinates;
  final RCDrawLetterPreferences prefs;

  Handwriting(this.coordinates, this.prefs);

  Offset calcControlPoint(List<Offset> el, int currentIndex, int nextIndex) {

    final currentEP = el[currentIndex];
    final nextEP = el[nextIndex];

    final cpX = (currentEP.dx + nextEP.dx) / 2;
    final cpY = (currentEP.dy + nextEP.dy) / 2;

    return Offset(cpX, cpY);

  }


  @override
  void paint(Canvas canvas, Size size) {


    Paint paint   = Paint()
    ..strokeWidth = 16.0
    ..color     = Colors.red[200]
    ..style     = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;

    Path path = Path();
    for (var n = 0; n < coordinates.length; n++) {

      final pointsGroup = coordinates[n];
      double prevX = pointsGroup[0].dx;
      double prevY = pointsGroup[0].dy;

      for (var i = 0; i < pointsGroup.length - 1; i++) {

        final pc = calcControlPoint(pointsGroup, i, i + 1);

        path.moveTo(prevX, prevY);
        path.quadraticBezierTo(
          pointsGroup[i].dx,
          pointsGroup[i].dy,
          pc.dx,
          pc.dy,
        );
        canvas.drawPath(path, paint);
        prevX = pc.dx;
        prevY = pc.dy;

      }

    }

  }


  @override
  bool shouldRepaint(CustomPainter oldDelegate) {

    return false;
  }


}