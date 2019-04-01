import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {

  final double width;
  final double height;
  final Icon icon;
  final Color splashColor;
  final Color highlightColor;
  final Color color;
  final Function() onTap;

  const CustomIconButton({
    Key key,
    @required this.width,
    @required this.height,
    @required this.onTap,
    @required this.icon,
    this.color = Colors.transparent,
    this.splashColor = Colors.black12,
    this.highlightColor = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Material(
      color: color,
      borderRadius: BorderRadius.circular(100.0),
      child: InkWell(
        splashColor: splashColor,
        borderRadius: BorderRadius.circular(100.0),
        splashFactory: InkRipple.splashFactory,
        onTap: onTap,
        highlightColor: highlightColor,
        child: Container(
          width: width,
          height: height,
          child: icon,
        ),
      ),
    );

  }
}

