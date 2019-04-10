
import 'dart:async';

import 'package:flutter/material.dart';

class WellDoneDialogApp extends StatefulWidget {

  final Duration durationToShow;

  final Duration duration;
  final Function() onEnd;
  final Function() onStart;
  final Curve curve;

  WellDoneDialogApp({
    Key key,
    @required this.onEnd,
    @required this.onStart,

    this.durationToShow = const Duration(seconds: 2),
    this.curve = Curves.fastLinearToSlowEaseIn,
    this.duration = const Duration(milliseconds: 600)
  }) : super(key: key);

  @override
  _WellDoneDialogApp createState() => _WellDoneDialogApp();
}

class _WellDoneDialogApp extends State<WellDoneDialogApp> with SingleTickerProviderStateMixin {

  Curve      get curve   => widget.curve;
  Function() get onEnd   => widget.onEnd;
  Function() get onStart => widget.onStart;
  Duration get duration  => widget.duration;
  Duration get durationToShow => widget.durationToShow;

  AnimationController controller;
  Animation<double> animation;
  double iconSize;

  Timer futureSub;

  @override
  void initState() {

    super.initState();
    iconSize = 60.0;
    Future.delayed(Duration(milliseconds: 0), show);

    controller = AnimationController(duration: duration, vsync: this);

    animation = Tween<double>( begin: -100, end: 10.0 )
      .chain( CurveTween( curve: curve ) )
      .animate( controller );

    controller.forward();
    Future.delayed(Duration(milliseconds: 200), onStart);

    futureSub = Timer(durationToShow, hide);

  }


  @override
  void dispose() {
    print('Ocultado');
    controller.dispose();
    super.dispose();
  }


  void show() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => buildWellDoneDialog(context)
    );
  }

  void hide() async {
    futureSub.cancel();
    await controller.reverse();
    Navigator.pop(context);
    await Future.delayed(Duration(milliseconds: 500));
    onEnd();
  }


  Widget buildWellDoneDialog(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    return AnimatedBuilder(
      animation: animation,
      builder: (_, child) => Container(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[


            Positioned(
              height: 100.0,
              width:  width * 0.90,
              bottom: animation.value,
              child:  GestureDetector(
                onTap: hide,
                child: Container(
                  decoration: BoxDecoration(

                    boxShadow: <BoxShadow>[
                      BoxShadow( color: Colors.black54, blurRadius: 10.0 )
                    ],


                    color: Colors.greenAccent[100],
                    borderRadius: BorderRadius.only(
                      bottomLeft:  Radius.circular(100.0),
                      topLeft:     Radius.circular(100.0),
                      bottomRight: Radius.circular(10.0),
                      topRight:    Radius.circular(10.0)
                    )

                  ),
                  child: Row(

                    children: <Widget>[


                      Container(

                        width:     100.0,
                        height:    100.0,
                        alignment: Alignment.center,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0)
                        ),

                        child: Container(

                          width:  iconSize + 2.0,
                          height: iconSize + 2.0,
                          decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(100.0)
                          ),
                          child: Icon(
                            Icons.check_circle_outline,
                            color: Colors.greenAccent[700],
                            size: iconSize,
                          ),

                        ),

                      ),


                      Expanded(
                        child: Container(
                          margin:    EdgeInsets.only(right: (100 - iconSize) /2 ),
                          alignment: Alignment.center,
                          child: Text(
                            'Bien Hecho',
                            maxLines:  1,
                            textAlign: TextAlign.center,
                            overflow:  TextOverflow.ellipsis,
                            style: TextStyle(

                              color:      Colors.greenAccent[700],
                              fontSize:   32.0,
                              fontFamily: 'Roboto',
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.bold,

                            ),
                          ),
                        ),
                      )


                    ],

                  ),
                ),
              ),
            )


          ],
        ),
      ),
      child: SizedBox(),
    );


  }


  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }


}