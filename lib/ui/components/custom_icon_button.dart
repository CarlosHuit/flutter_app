import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {

  final double width;
  final double height;
  final Icon icon;
  final Color splashColor;
  final Color highlightColor;
  final Color color;
  final Function() onTap;
  final double elevation;

  const CustomIconButton({
    Key key,
    @required this.width,
    @required this.height,
    @required this.onTap,
    @required this.icon,
    this.color = Colors.transparent,
    this.splashColor = Colors.black12,
    this.highlightColor = Colors.transparent,
    this.elevation = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Material(

      color:        color,
      elevation:    elevation,
      shadowColor:  Colors.black,
      borderRadius: BorderRadius.circular(100.0),

      child: InkWell(

        onTap:          onTap,
        splashColor:    splashColor,
        borderRadius:   BorderRadius.circular(100.0),
        splashFactory:  InkRipple.splashFactory,
        highlightColor: highlightColor,

        child: Container(
          width:  width,
          height: height,
          child:  icon,
        ),

      ),

    );

  }
}

