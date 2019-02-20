import 'package:flutter/material.dart';

Widget homeAppBar() {

  return AppBar(

    elevation: 3.0,
    title:     Text(
      'Weduc',
      style: TextStyle(
        fontFamily: 'Pacifico',
        fontSize:   26.0
      ),
    ),
    actions:   <Widget>[

      IconButton(
        icon:       Icon(Icons.account_circle),
        onPressed:  () => print('Hello world'),
      ),

    ],

  );

}