import 'package:flutter/material.dart';

class SelectWordsScreen extends StatefulWidget {
  @override
  _SelectWordsScreenState createState() => _SelectWordsScreenState();
}

class _SelectWordsScreenState extends State<SelectWordsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
          child: Text('Select Words'),
      ),
    );
  }
}