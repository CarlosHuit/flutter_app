import 'package:flutter/material.dart';

class WellDoneDialog extends StatefulWidget {
  @override
  _WellDoneDialogState createState() => _WellDoneDialogState();
}

class _WellDoneDialogState extends State<WellDoneDialog> {

  double translated;
  double translateY;
  int millisecondsTime;

  @override
  void initState() {
    super.initState();
    translateY = 0.0;
    translated = 0.0;
    millisecondsTime = 500;
  }

  void hideRight() {
    setState(() {
      millisecondsTime = 200;
      translateY = MediaQuery.of(context).size.width;
    });
  }

  void hideLeft() {
    setState(() {
      millisecondsTime = 200;
      translateY = -MediaQuery.of(context).size.width;
    });
  }

  void translateTo(double amount) {
    setState(() {
      millisecondsTime = 10;
      translated = translated + amount;
      translateY = translateY + amount;
    });
  }

  void handleDragUpdate(DragUpdateDetails s) {

    translateTo(s.primaryDelta);

    final maxTranslated = MediaQuery.of(context).size.width / 4;
    final t = translated > 0 ? translated : - translated;


    if ( t > maxTranslated) {

      if (s.primaryDelta > 0)
        hideRight();
      else if (s.primaryDelta < 0) 
        hideLeft();

    }

  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onHorizontalDragUpdate: handleDragUpdate,
      child: Container(
        height: size.height,
        width:  size.width,
        decoration: BoxDecoration(
          color: Colors.black26,
          backgroundBlendMode: BlendMode.darken
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[

            AnimatedContainer(
              height:     120.0,
              width:      size.width,
              transform:  Matrix4.translationValues(translateY, -350, 0),
              duration:   Duration(milliseconds: millisecondsTime),
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
            )
          ],
        ),
      )
    );


  }

}
