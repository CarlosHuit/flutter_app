
import 'package:flutter/material.dart';

class CustomPopUpMenu extends StatefulWidget {

  final Offset position;
  final Widget item;
  final Function() onTapOutside;

  const CustomPopUpMenu({
    Key key,
    @required this.item,
    @required this.position,
    @required this.onTapOutside
  }) : super(key: key);

  @override
  _CustomPopUpMenuState createState() => _CustomPopUpMenuState();

}



class _CustomPopUpMenuState extends State<CustomPopUpMenu> with SingleTickerProviderStateMixin {

  Widget get item => widget.item;
  Offset get pos => widget.position;
  Function() get onTapOutside => widget.onTapOutside;

  bool show = false;
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration( milliseconds: 200 )
    );

    animation = Tween<double>(begin: 0.0, end: 1.0)
    .animate(controller)
    ..addListener(() => setState(() { }) );

    controller.forward();

  }

  @override
  void dispose() {

    super.dispose();
    controller.dispose();

  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(

      onTap: () {

        controller.reverse();
        Future.delayed(
          Duration(milliseconds: 250),
          onTapOutside
        );

      },

      child: Opacity(
        opacity: animation.value,
        child: Container(

          color: Colors.transparent,
          child: Stack(
            children: <Widget>[

              Positioned(
                top:  pos.dy,
                left: pos.dx,
                child: GestureDetector(
                  onTap: () {},
                  child: item
                ),
              )

            ],
          ),

        ),
      ),

    );

  }


}




