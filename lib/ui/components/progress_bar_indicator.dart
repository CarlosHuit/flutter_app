
import 'package:flutter/material.dart';

class ProgressBarIndicator extends StatelessWidget {

  /// [double] width of progress bar indicator
  final double w;

  /// [double] height of progress bar indicator
  final double h;

  /// [double] percente advantave - 0.0 to 1.0
  final double p;

  /// [double] border radius of progress bar indicator. Default: 0.0
  final double radius;

  /// [Alignment] alignment of progress bar in parent container
  final Alignment alignment;

  /// [MaterialColor] color to set principal and secondary color. Default: Red
  final MaterialColor color;

  const ProgressBarIndicator({
    Key key,
    @required this.w,
    @required this.h,
    @required this.p,
    this.radius = 0.0, 
    this.alignment = Alignment.bottomCenter,
    this.color = Colors.red
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Container(
      width: w,
      alignment: alignment,
      child: Container(
        height: h,
        width:  w,
        decoration: BoxDecoration(
          color: color[100],
          borderRadius: BorderRadius.circular( radius )
        ),
        child: Row(
          children: <Widget>[
            AnimatedContainer(
              width:    w * p,
              curve:    Curves.easeOut,
              duration: Duration(milliseconds: 400),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(radius)
              ),
            )
          ],
        ),
      ),
    );

  }

}

