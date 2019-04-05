import 'dart:async';

import 'package:app19022019/ui/components/custom_icon_button.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import './guide_lines.dart';

class Handwriting extends StatefulWidget {

  final BuildContext context;

  const Handwriting({Key key, @required this.context}) : super(key: key);

  @override
  _HandwritingState createState() => _HandwritingState();
}

class _HandwritingState extends State<Handwriting> {

  BuildContext get context => widget.context;

  FlareControls flareControl;
  Duration animationDuration;
  String animationName;
  double positionY;
  Timer futureSub;
  bool pause;

  Duration animatedContainerDuration;

  @override
  void initState() {

    super.initState();
    animatedContainerDuration =Duration(milliseconds: 500);
    animationDuration = Duration(seconds: 6);
    flareControl  =  FlareControls();
    animationName = 'draw';
    positionY = MediaQuery.of(context).size.height;
    pause     = true;

    Future.delayed(Duration(milliseconds: 200), showModalH);
    Future.delayed(animatedContainerDuration, playAnimation);

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


  replayAnimation() {

    if (futureSub != null) {

      print('cancelFuture');
      futureSub.cancel();
      pauseAnimation();

    }

    playAnimation();
    flareControl.play(animationName);
    setState(() => futureSub = Timer(animationDuration, pauseAnimation) );


  }


  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    print(MediaQuery.of(context).size.height);

    return AnimatedContainer(
      curve: Curves.easeOutCubic,
      duration: animatedContainerDuration,
      transform: Matrix4.translationValues(0, positionY, 0),
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
                margin: EdgeInsets.only(top: 60),
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
                          'assets/alphabet/letter_h.flr',
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
                      splashColor: Colors.red[50],
                      height: 60.0,
                      width:  60.0,
                      icon:   Icon(Icons.replay, color: Colors.red),
                      onTap:  replayAnimation,
                    ),
                  ),

                  Container(
                    alignment: Alignment.center,
                    child: RaisedButton(
                      child: Text( 'Siguiente', style: TextStyle( fontSize: 16.0 ),
                      ),
                      color:     Colors.red,
                      padding:   EdgeInsets.symmetric(horizontal: 35),
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


