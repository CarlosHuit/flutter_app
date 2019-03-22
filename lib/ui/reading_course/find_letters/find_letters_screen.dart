import 'package:flutter/material.dart';

class FindLettersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Text(
          'Find Letters',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.0
          ),
        ),
      ),
    );
  }
}