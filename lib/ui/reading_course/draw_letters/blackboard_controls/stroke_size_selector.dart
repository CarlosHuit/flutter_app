import 'package:app19022019/core/src/redux/reading_course/rc_draw_letters/rc_draw_letters_state.dart';
import 'package:flutter/material.dart';

class StrokeSizeSelector extends StatefulWidget {

  final double value;
  final Function(double val) onChange;
  final double min;
  final double max;
  final RCDrawLetterPreferences prefs;


  const StrokeSizeSelector({
    Key key,
    @required this.value,
    @required this.onChange,
    @required this.min,
    @required this.max,
    @required this.prefs
  }) : super(key: key);

  @override
  _StrokeSizeSelectorState createState() => _StrokeSizeSelectorState();
}



class _StrokeSizeSelectorState extends State<StrokeSizeSelector> {

  Function(double val) get cb => widget.onChange;
  double get value => widget.value;
  double get min => widget.min;
  double get max => widget.max;
  RCDrawLetterPreferences get prefs => widget.prefs;

  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 0,
      margin: EdgeInsets.all(0),
      
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.0),
          boxShadow: <BoxShadow> [
            BoxShadow(color: Colors.black45, blurRadius: 10)
          ]
        ),
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
        child: Column(
          children: <Widget>[


            Container(
              height: 40.0,
              width: 220.0,
              child: Slider(
                value: value,
                min:   min,
                max:   max,
                label: value.toString(),
                onChanged: cb,
                divisions: 12,
                inactiveColor: prefs.lineColor[200],
                activeColor:   prefs.lineColor,
              ),
            ),

            Container(
              height: 60.0,
              width: 200.0,
              child: CustomPaint(
                painter: StrokeSizeItem( prefs: prefs ),
              ),
            ),

          ],
        ),
      ),
    );

  }
}


class StrokeSizeItem extends CustomPainter {

  final RCDrawLetterPreferences prefs;

  StrokeSizeItem({ @required this.prefs });

  @override
  void paint(Canvas canvas, Size size) {

    print('${prefs.lineWidth}');
    Paint paint = Paint()
    ..strokeCap = prefs.styleLine
    ..color     = prefs.lineColor
    ..style     = PaintingStyle.stroke
    ..strokeWidth = prefs.lineWidth;

    Path path = Path();
    path.moveTo(prefs.lineWidth, size.height / 2);

    final firstCP = Offset(size.width * 0.25, size.height * 0.80);
    final firstEP = Offset(size.width * 0.50, size.height * 0.50);

    path.quadraticBezierTo(firstCP.dx, firstCP.dy, firstEP.dx, firstEP.dy);

    final secondCP = Offset(size.width * 0.75, size.height * 0.20);
    final secondEP = Offset(size.width - prefs.lineWidth, size.height - 20);
    path.quadraticBezierTo(secondCP.dx, secondCP.dy, secondEP.dx, secondEP.dy);

    canvas.drawPath(path, paint);

  }

  @override
  bool shouldRepaint(StrokeSizeItem oldDelegate) => false;

}
