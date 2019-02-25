import 'package:flutter/material.dart';

Widget learnedLetters() {

  return Container(
    alignment: Alignment.center,
    // color: Colors.lime,
    child: Text(
      'learnedLetters'
    ),
  );

}

Widget tabLearnedLetters() {
  return Tab(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.favorite, color: Colors.red,),
        SizedBox(width: 5.0,),
        Text(
          'Aprendidas',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0
          ),
        ),
      ],
    ),
  );
}