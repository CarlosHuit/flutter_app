import 'dart:async';

import 'package:app19022019/core/src/viewmodels/reading_course/letter_detail_view_model.dart';
import 'package:flutter/material.dart';

class TryAgainDialog extends StatefulWidget {

  final Function() callBack;
  final LetterDetailViewModel vm;

  TryAgainDialog({Key key, @required this.callBack, @required this.vm}) : super(key: key);

  @override
  _TryAgainDialogState createState() => _TryAgainDialogState();

}

class _TryAgainDialogState extends State<TryAgainDialog> with SingleTickerProviderStateMixin {

  double translated;
  double translateX;
  double translateY;
  bool   isVisible;
  Color  color;
  int    time;

  Function() get callBack => widget.callBack;
  LetterDetailViewModel get vm => widget.vm;

  @override
  void initState() {
    
    super.initState();

    translateY = 150.0;
    translateX = 0.0;
    translated = 0.0;
    isVisible  = true;
    time       = 200;
    color      = Colors.transparent;

    Future.delayed( Duration(milliseconds: 200), showBottom);
    Future.delayed( Duration(seconds: 3), hideBottom );

  }

  void showBottom() {
    setState(() {
      translateY = 0;
      color = Colors.black38;
    });
    Future.delayed(Duration(milliseconds: 50), () {
      vm.listenIncorrectMsg();
    });
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
      time  = 200;
      color = Colors.transparent;
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

  void executeCallBack() {
    callBack();
    Future.delayed(
      Duration(milliseconds: 200),
      () => vm.hideTryAgainDialog()
    );
  }

  void translateTo(double amount) {

    setState(() {
      time = 10;
      translated = translated + amount;
      translateX = translateX + amount;
    });

  }

  void handleDragUpdate(DragUpdateDetails s) {

    if (isVisible) {

      translateTo(s.primaryDelta);

      final maxTranslated = MediaQuery.of(context).size.width / 4;
      final t = translated > 0 ? translated : - translated;


      if ( t > maxTranslated ) {

        if (s.primaryDelta > 0)
          hideRight();
        else if (s.primaryDelta < 0) 
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
        color:  color,
        width:  size.width,
        height: size.height,

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

                  color:        Colors.redAccent[100],
                  border:       Border.all(width: 4.0, color: Colors.red[600]),
                  borderRadius: BorderRadius.circular(3.0),
                  boxShadow:    <BoxShadow> [
                    BoxShadow(color: Colors.black45, blurRadius: 10.0, spreadRadius: 5.0 ),
                    BoxShadow(color: Colors.white, spreadRadius: 2.0 )
                  ]
                ),
                child: Row(
                  children: <Widget>[

                    Icon(
                      Icons.error_outline,
                      color: Colors.red[600],
                      size:  64.0,
                    ),

                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          Text(
                            '¡Uppss!',
                            textAlign: TextAlign.center,
                            style:     TextStyle(
                              color:      Colors.red[600],
                              fontWeight: FontWeight.bold,
                              fontSize:   36.0
                            ),
                          ),

                          Text(
                            'Vuelve a intentarlo',
                            style: TextStyle(
                              color:      Colors.red[600],
                              fontSize:   16.0,
                              fontWeight: FontWeight.bold
                            ),
                          )

                        ],
                      ),
                    )

                  ],
                ),
              ),
            )


          ],
        ),
      ),
    );
  }

}

