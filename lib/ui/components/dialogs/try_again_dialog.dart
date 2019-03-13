import 'package:flutter/material.dart';

class TryAgainDialog extends StatefulWidget {
  @override
  _TryAgainDialogState createState() => _TryAgainDialogState();
}

class _TryAgainDialogState extends State<TryAgainDialog> {

  double translated;
  double translateY;
  int    millisecondsTime;
  bool   isVisible;

  @override
  void initState() {
    super.initState();
    translateY = 0.0;
    translated = 0.0;
    isVisible  = true;
    millisecondsTime = 500;
  }

  void hideRight() {
    setState(() {
      millisecondsTime = 200;
      translateY = MediaQuery.of(context).size.width;
      isVisible = false;
    });
  }

  void hideLeft() {
    setState(() {
      millisecondsTime = 200;
      translateY = -MediaQuery.of(context).size.width;
      isVisible = false;
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
      onHorizontalDragUpdate: handleDragUpdate,
      child: Container(
        height: size.height,
        width:  size.width,
        decoration: BoxDecoration(
          // color: Colors.black38,
          // backgroundBlendMode: BlendMode.darken
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            AnimatedContainer(
              height:     120.0,
              width:      size.width,
              duration:   Duration(milliseconds: millisecondsTime),
              transform:  Matrix4.translationValues(translateY, -10, 0),
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
            )
          ],
        ),
      ),
    );
  }

}

