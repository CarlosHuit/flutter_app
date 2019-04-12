import 'package:app19022019/core/src/viewmodels/reading_course/pronounce_letters_view_model.dart';
import 'package:flutter/material.dart';

class PronounceLettersContent extends StatefulWidget {

  final PronounceLettersViewModel vm;

  const PronounceLettersContent({
    Key key,
    @required this.vm
  }) : super(key: key);

  @override
  _PronounceLettersContentState createState() => _PronounceLettersContentState();
}

class _PronounceLettersContentState extends State<PronounceLettersContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Text('Pronouce Letters'),
      ),
    );
  }
}