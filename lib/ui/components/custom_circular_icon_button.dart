import 'package:flutter/material.dart';

class CustomCircularIconButton extends StatelessWidget {

  /// [ double ] define the with of the icon button. Width is @required
  final double width;

  /// [ double ] define the height of the icon button. Height is @required
  final double height;

  /// [ Icon ] set the icon of the buttons, you can add icon custimatization
  final Icon icon;

  /// [ MaterialColor ] Define the color of the splach efect. By Default is Colors.black12
  final Color splashColor;

  /// [ Color ] Define the color of the highlight effect. By default is Colors.transparent 
  final Color highlightColor;

  /// [ Color ] define the background color of the icon button, by default is Colors.transparent
  final Color color;

  /// [ Function() ] CallBack that is called when the button is pressed. Callback is @required
  final Function() onTap;

  /// [ double ] Define the elevation 'BoxShadow' of the button, by default is 0.0
  final double elevation;

  const CustomCircularIconButton({
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

