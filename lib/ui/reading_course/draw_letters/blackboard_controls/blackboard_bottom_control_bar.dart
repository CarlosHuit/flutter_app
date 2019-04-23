import 'package:app19022019/ui/components/custom_circular_icon_button.dart';
import 'package:flutter/material.dart';


class BlackboardBottomControlBar extends StatelessWidget {

  final Function() onTapIconClear;
  final Function() onTapIconReplay;

  const BlackboardBottomControlBar({
    Key key,
    @required this.onTapIconClear,
    @required this.onTapIconReplay
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Positioned(
      bottom: 15.0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        height:  45.0,
        decoration: BoxDecoration(
          color:        Colors.white,
          border:       Border.all(width: 0.8, color: Colors.black26),
          borderRadius: BorderRadius.circular(100.0),
          boxShadow: <BoxShadow>[
            BoxShadow( color: Colors.black26, blurRadius: 6.0, offset: Offset(0, 3) )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[


            CustomCircularIconButton(
              width: 45.0,
              height: 45.0,
              icon: Icon(Icons.replay, color: Colors.red),
              onTap: onTapIconReplay,
              splashColor: Colors.red[50],
            ),


            CustomCircularIconButton(
              width: 45.0,
              height: 45.0,
              icon: Icon(Icons.clear, color: Colors.red),
              onTap: onTapIconClear,
              splashColor: Colors.red[50],
            ),

            Transform.rotate(
              angle: 45,
              child: CustomCircularIconButton(
                width: 45.0,
                height: 45.0,
                icon: Icon(Icons.smartphone, color: Colors.red),
                onTap: onTapIconClear,
                splashColor: Colors.red[50],
              ),
            ),


          ],
        ),
      ), 
    );


  }
}