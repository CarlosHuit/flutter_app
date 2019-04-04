import 'dart:async';

import 'package:app19022019/ui/components/custom_icon_button.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import './guide_lines.dart';

class Handwriting extends StatefulWidget {

  @override
  _HandwritingState createState() => _HandwritingState();
}

class _HandwritingState extends State<Handwriting> {

  FlareControls flareControl;
  double positionY;
  bool pause;
  Duration animationDuration;

  Timer futureSub;
  String animationName;

  @override
  void initState() {
    super.initState();
    animationDuration = Duration(seconds: 6);
    animationName = 'Untitled';
    flareControl  =  FlareControls();
    positionY = 0;
    pause = false;
  }

  showModalH() {
    setState(() => positionY = 0 );
  }

  pauseAnimation() {
    setState(() => pause = true );
  }

  playAnimation() {
    setState(() => pause = false);
  }

  

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      // duration: Duration(milliseconds: 300),
      // transform: Matrix4.translationValues(0, positionY, 0),
      alignment: Alignment.center,
      child:     Container(
        constraints: BoxConstraints(

          minWidth:  300.0,
          maxWidth:  380.0,
          minHeight: 400.0,
          maxHeight: 480.0

        ),
        decoration: BoxDecoration(

          color:        Colors.white,
          borderRadius: BorderRadius.circular(4.0),
          boxShadow: [  BoxShadow(color: Colors.black54, blurRadius: 5.0)]

        ),
        width:  size.width  - 20.0,
        height: size.height - 20.0,
        child:  Column(
          children: <Widget>[

            Expanded(
              
              child:Container(
                alignment: Alignment.center,
                child: Container(
                  width:  size.width > 340.0 ? 300.0 : 280.0,
                  height: size.width > 340.0 ? 300.0 : 280.0,
                  child:  Stack(
                    fit:  StackFit.expand,
                    children: <Widget>[

                      Container(
                        child: CustomPaint(
                          painter: GuideLines(),
                        ),
                      ),

                      Container(
                        alignment: Alignment.center,
                        child: FlareActor(
                          'assets/alphabet/letter_R.flr',
                          fit:        BoxFit.fitWidth,
                          color:      Colors.blue,
                          callback:   (s) => pauseAnimation(),
                          isPaused:   pause,
                          alignment:  Alignment.center,
                          animation:  animationName,
                          controller: flareControl,
                        ),
                      )


                    ],
                  ),
                ),
              ),

            ),

            Container(
              height: 80,
              alignment: Alignment.center,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[

                  Positioned(
                    top: 10.0,
                    right: 10.0,
                    child: CustomIconButton(
                      height: 60.0,
                      width: 60.0,
                      splashColor: Colors.red[50],
                      icon: Icon(Icons.replay, color: Colors.red),
                      onTap: () {

                        if (futureSub != null) {

                          print('cancelFuture');
                          futureSub.cancel();
                          pauseAnimation();

                        }


                        playAnimation();
                        flareControl.play(animationName);
                        setState(() => futureSub = Timer(animationDuration, pauseAnimation) );

                      },
                    ),
                  ),

                  Container(
                    alignment: Alignment.center,
                    child: RaisedButton(
                      child: Text(
                        'Siguiente',
                        style: TextStyle(
                          fontSize: 16.0
                        ),
                      ),
                      color: Colors.red,
                      padding: EdgeInsets.symmetric(horizontal: 35),
                      textColor: Colors.white,
                      onPressed: () => Navigator.pop(context),
                    ),

                  )


                ],
              ),
            )


          ],
        ),
      ),
    );

  }
}


