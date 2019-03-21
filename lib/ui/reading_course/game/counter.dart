
import 'package:flutter/material.dart';

class Counter extends StatelessWidget {

  final Color color;
  final int count;

  const Counter({
    Key key,
    @required this.color,
    @required this.count
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 3.0),
      height: 40.0,
      width: 40.0,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(width: 2.0, color: Colors.white),
        borderRadius: BorderRadius.circular(50)
      ),
      child: Text(
        '$count',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18.0
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
