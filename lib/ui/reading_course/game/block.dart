import 'dart:async';

import 'package:flutter/material.dart';
class Block extends StatefulWidget {

  final String letter;
  final String correctLetter;
  final double columnWidth;
  final bool   highlight;

  final Function(String letter) callBack;

  const Block({
    Key key,
    @required this.letter,
    @required this.columnWidth,
    @required this.correctLetter,
    @required this.callBack,
    @required this.highlight,
  }) : super(key: key);

  @override
  _BlockState createState() => _BlockState();
}



class _BlockState extends State<Block> with SingleTickerProviderStateMixin {

  bool get highlight => widget.highlight;
  String get letter => widget.letter;

  double get columnWidth => widget.columnWidth;
  String get correctLetter => widget.correctLetter;

  Function(String letter) get callBack => widget.callBack;

  bool isWrongSelection;
  bool   showLetter;
  double height;
  double blockWidth;
  double blockHeight;

  @override
  void initState() {

    super.initState();
    height      = columnWidth;
    blockHeight = columnWidth;
    blockWidth  = columnWidth;
    showLetter  = true;
    isWrongSelection = false;

  }


  void onTap() {

    pressEffect();
    callBack(letter);

    final isCorrect = letter == correctLetter;

    isCorrect ? correctSelection() : wrongSelection();

  }


  void wrongSelection() {

    setState(() => isWrongSelection = true );

    Timer(
      Duration(milliseconds: 500),
      () => setState(() {
        isWrongSelection = false;
      })
    );

  }


  void pressEffect() async{

    setState(() {
      blockHeight = blockHeight - 10;
      blockWidth  = blockWidth - 10;
    });

    await Future.delayed( Duration( milliseconds: 300 ) );

    setState(() {
      blockHeight = blockHeight + 10;
      blockWidth = blockWidth + 10;
    });

  }


  void correctSelection() {

    setState(() {
      showLetter = false;
      height     = 0;
    });

  }

  @override
  Widget build(BuildContext context) {

    final normalGradient = [ Colors.deepOrange[500], Colors.deepOrange[400] ];
    final wrongGradient  = [ Colors.red, Colors.red ];
    final hightligthGradient = [ Colors.green, Colors.green ];

    return GestureDetector(
      onTap:       onTap,
      child: AnimatedContainer(

        width:    columnWidth,
        alignment: Alignment.center,
        curve:    Curves.bounceOut,
        height:   height,
        padding:  EdgeInsets.all(3.0),
        duration: Duration(milliseconds: 920),
        child:    !showLetter ? SizedBox() : AnimatedContainer(
          
          duration: Duration(milliseconds: 200),
          width:      blockWidth,
          height:     blockHeight,
          alignment:  Alignment.center,
          decoration: BoxDecoration(
             
            borderRadius: BorderRadius.circular(6.0),
            color: Colors.red,
            gradient: LinearGradient(
              end:    Alignment.topLeft,
              begin:  Alignment.bottomRight,
              colors: highlight && letter == correctLetter
                ? hightligthGradient
                : isWrongSelection == true
                  ? wrongGradient 
                  : normalGradient
            )

          ),

          child: Text(
            letter,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 36.0
            ),
          ),

        ),

      ),
    );
  }
}
