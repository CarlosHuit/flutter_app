
import 'package:flutter/material.dart';

class LetterModal extends StatelessWidget {

  final String letter;

  const LetterModal({Key key, this.letter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
      color:   Colors.grey[100],
      child:   Card(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              letter,
              style: TextStyle(
                // color:      Color.fromARGB(255, 255, 215, 0),
                color:      Colors.yellowAccent[700],
                fontSize:   200.0,
                fontWeight: FontWeight.bold,
                shadows: <Shadow> [
                  Shadow(
                    color: Colors.black.withOpacity(0.65),
                    blurRadius: 6.0,
                    offset: Offset(-2, 2)
                  ),
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