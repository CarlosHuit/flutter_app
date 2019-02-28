import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LetterDetailScreen extends StatefulWidget {
  @override
  _LetterDetailScreenState createState() => _LetterDetailScreenState();
}

class _LetterDetailScreenState extends State<LetterDetailScreen> {

  @override
  void initState() {
    // SystemChrome.setEnabledSystemUIOverlays([]);
    // SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle( statusBarColor: Colors.transparent ));
    super.initState();
  }

  @override
  void dispose() {
    // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    // SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle( statusBarColor: Colors.black12 ));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle( statusBarColor: Colors.green ),
        sized: false,
        child: SafeArea(
          child: Container(
            color: Colors.green,
            alignment: Alignment.center,
            child: Text('sss'),
          )
        ),
      ),
    );
  }
}

class LetterDetailBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: TextLetterdetail(),
    );
  }
}

class TextLetterdetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: Column(
        children: <Widget>[Text('data')],
      )

    );
  }
}