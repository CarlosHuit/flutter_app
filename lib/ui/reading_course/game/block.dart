import 'package:flutter/material.dart';
class Block extends StatefulWidget {

  final String letter;
  final String correctLetter;
  final double columnWidth;
  final bool   highlight;

  final Function() callBack;

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

  String get letter => widget.letter;
  double get columnWidth => widget.columnWidth;
  String get correctLetter => widget.correctLetter;
  Function() get callBack => widget.callBack;
  bool get highlight => widget.highlight;

  double height;
  bool showLetter;


  @override
  void initState() {

    super.initState();
    height = columnWidth;
    showLetter = true;

  }

  void onSelect() {

    callBack();

    if (letter == correctLetter) {
      print('you have pressed a correct letter');
      hide();
    } else {
      print('you have pressed a incorrect letter');
    }

  }

  void hide() {

    setState(() {
      showLetter = false;
      height     = 0;
    });

  }

  @override
  Widget build(BuildContext context) {

    final normalGradient = [ Colors.deepOrange[500], Colors.deepOrange[400] ];
    final hightligthGradient = [ Colors.green, Colors.green ];

    return GestureDetector(
      onTap: onSelect,
      child: AnimatedContainer(

        width:    columnWidth,
        curve:    Curves.bounceOut,
        height:   height,
        padding:  EdgeInsets.all(3.0),
        duration: Duration(milliseconds: 920),
        child:    !showLetter ? SizedBox() : Container(

          width:      columnWidth,
          height:     columnWidth,
          alignment:  Alignment.center,
          decoration: BoxDecoration(
             
            borderRadius: BorderRadius.circular(6.0),
            color: Colors.red,
            gradient: LinearGradient(
              end:    Alignment.topLeft,
              begin:  Alignment.bottomRight,
              colors: highlight && letter == correctLetter
                ? hightligthGradient
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
