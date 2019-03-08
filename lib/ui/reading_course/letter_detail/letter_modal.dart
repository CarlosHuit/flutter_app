
import 'package:flutter/material.dart';

class LetterModal extends StatelessWidget {

  final String letter;

  const LetterModal({Key key, this.letter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color:   Colors.grey[100],
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
      child:   Card(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              letter,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color:      Color.fromARGB(255, 255, 215, 0),
                fontSize:   200.0,
                shadows: <Shadow> [
                  Shadow(color: Colors.black,   offset: Offset(-1.2, 1.2)),
                  Shadow(color: Colors.black,   offset: Offset(1.2, -1.2)),
                  Shadow(color: Colors.black,   offset: Offset(1.2, 1.2)),
                  Shadow(color: Colors.black,   offset: Offset(-1.2, -1.2)),
                  Shadow(color: Colors.black45, blurRadius: 12.0),
                ]
              ),
            ),
            Container(
              width:  200.0,
              height: 40.0,
              margin: EdgeInsets.only(top: 10.0),
              child:  RaisedButton(

                onPressed: () => Navigator.pop(context),
                color:     Colors.red,
                child:     Text(
                  'Continuar',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:      Colors.white,
                    fontSize:   18.0
                  ),
                ),

              )
            ),

          ],
        )

      )
    );
  }
}