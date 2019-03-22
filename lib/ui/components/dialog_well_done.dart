import 'dart:async';

import 'package:flutter/material.dart';

class DialogWellDone extends StatefulWidget {

  final Function() speak;
  final Function() callBack;


    const DialogWellDone({
    Key key,
    @required this.speak,
    @required this.callBack,
  }) : super(key: key);

  @override
  _DialogWellDoneState createState() => _DialogWellDoneState();
}

class _DialogWellDoneState extends State<DialogWellDone> {


  double translated;
  double translateX;
  double translateY;
  bool   isVisible;
  Color  color;
  int    time;

  Function() get speak => widget.speak;
  Function() get callBack => widget.callBack;

  @override
  void initState() {

    super.initState();

    translateX = 0.0;
    translateY = 150.0;
    translated = 0.0;
    isVisible  = true;
    time       = 200;
    color      = Colors.transparent;

    Future.delayed( Duration(milliseconds: 200), showBottom );
    Future.delayed( Duration(seconds: 2), hideBottom );

  }


  void showBottom() {

    setState(() {
      translateY = 0;
      color = Colors.black45;
    });

    Future.delayed(Duration(milliseconds: 50), speak);

  }


  void hideRight() {

    setState(() {
      time = 200;
      color      = Colors.transparent;
      translateX = MediaQuery.of(context).size.width;
      isVisible  = false;
    });

    executeCallBack();

  }


  void hideLeft() {

    setState(() {
      time = 200;
      color      = Colors.transparent;
      translateX = -MediaQuery.of(context).size.width;
      isVisible  = false;
    });

    executeCallBack();

  }


  void hideBottom() {

    if (isVisible) {
      setState(() {
        time = 200;
        color      = Colors.transparent;
        translateY = 150;
        isVisible  = false;
      });

      executeCallBack();

    }

  }


  void executeCallBack() async{

    Future.delayed(
      Duration(milliseconds: 200) ,
      callBack
    );

  }


  void translateTo(double amount) {

    setState(() {
      time = 10;
      translated = translated + amount;
      translateX = translateX + amount;
    });

  }


  void handleDragUpdate(DragUpdateDetails el) {

    if (isVisible) {

      translateTo(el.primaryDelta);

      final maxTranslated = MediaQuery.of(context).size.width / 4;
      final t = translated > 0 ? translated : - translated;


      if ( t > maxTranslated ) {

        if (el.primaryDelta > 0)
          hideRight();
        else if (el.primaryDelta < 0) 
          hideLeft();

      }

    }

  }


  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => hideBottom(),
      child: AnimatedContainer(

        duration: Duration(milliseconds: 100),
        color:    color,
        height:   size.height,
        width:    size.width,

        child: Column(

          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[


            GestureDetector(
              onHorizontalDragUpdate: handleDragUpdate,
              child: AnimatedContainer(
                height:     120.0,
                width:      size.width,
                duration:   Duration(milliseconds: time),
                transform:  Matrix4.translationValues(translateX, translateY, 0),
                curve:      Curves.easeIn,
                margin:     EdgeInsets.all(20.0),
                padding:    EdgeInsets.all(10.0),
                decoration: BoxDecoration(

                  color:        Colors.greenAccent[100],
                  borderRadius: BorderRadius.circular(3.0),
                  border:       Border.all(width: 4.0, color: Colors.greenAccent[700]),

                  boxShadow: <BoxShadow>[
                    BoxShadow(color: Colors.black45, spreadRadius: 5.0, blurRadius: 10.0, ),
                    BoxShadow(color: Colors.white,   spreadRadius: 2)
                  ],

                ),
                child: Row(
                  children: <Widget>[


                    Icon(
                      Icons.check_circle_outline,
                      color: Colors.greenAccent[700],
                      size:  64.0,
                    ),


                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment:  MainAxisAlignment.center,
                        children: <Widget>[

                          Text(
                            '¡Bien Hecho!',
                            textAlign: TextAlign.center,
                            style:     TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.greenAccent[700],
                              fontSize: 36.0
                            ),
                          ),

                        ],
                      ),
                    )


                  ],
                ),
              ),
            )
          ],
        ),

      )
    );


  }


}
