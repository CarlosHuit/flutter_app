import 'package:flutter/material.dart';

class NotFoundScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text('Not Found')),
      body:   Container(

        alignment: Alignment.center,
        child:     Text('Not Found 404'),

      )

    );
  }
}