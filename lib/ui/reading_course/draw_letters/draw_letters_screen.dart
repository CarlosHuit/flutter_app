import 'package:flutter/material.dart';

class DrawLettersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.yellow[100],
        alignment: Alignment.center,
        child: Text('Hello From DrawLetter'),
      ),
    );
  }
}