
import 'package:flutter/material.dart';

class ProgressBarIndicator extends StatelessWidget {

  final double w;
  final double h;
  final double p;
  final double radius;
  const ProgressBarIndicator({
    Key key,
    @required this.w,
    @required this.h,
    @required this.p,
    this.radius,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Container(
      width: w,
      alignment: Alignment.bottomCenter,
      child: Container(
        height: h,
        width:  w,
        decoration: BoxDecoration(
          color: Colors.red[100],
          borderRadius: BorderRadius.circular( radius ?? 0.0 )
        ),
        child: Row(
          children: <Widget>[
            AnimatedContainer(
              duration: Duration(milliseconds: 800),
              width: w * p,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(radius ?? 0.0)
              ),
            )
          ],
        ),
      ),
    );

  }

}

