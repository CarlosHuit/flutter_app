import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:   EdgeInsets.only(top: 10.0),
      alignment: Alignment.topCenter,
      child:     CircularProgressIndicator(),
    );
  }
}