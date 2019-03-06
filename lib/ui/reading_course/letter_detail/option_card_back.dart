import 'package:flutter/material.dart';

class OptionCardBack extends StatelessWidget {

  final String letter;

  const OptionCardBack({Key key, this.letter}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    const TextStyle letterStyle = TextStyle(
      fontSize:   60.0,
      color:      Colors.white,
      fontWeight: FontWeight.bold,
    );

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border:       Border.all(width: 3.0, color: Colors.white),
        gradient:     LinearGradient(

          end:    Alignment.bottomRight,
          begin:  Alignment.topLeft,
          stops:  [0.1, 0.5, 0.9],
          colors: [ Colors.orange, Colors.orange[600], Colors.orange[700] ],

        ),
      ),
      alignment: Alignment.center,
      child:     Text( letter, style: letterStyle ),
    );
  }
}