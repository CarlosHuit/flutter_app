import 'dart:async';

import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {


  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {


  @override
  Widget build(BuildContext context) {

    final size  = MediaQuery.of(context).size;
    final width = size.width;
    final els   = '0123456789'.split('');
    final data  = List.generate(4, (i) => els);

    final columnWidth = 90.0;
    final surplus = width % columnWidth;
    final columns = surplus > 0 ? (width - surplus) ~/ columnWidth : width ~/ columnWidth;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 2.0,
        actions: <Widget>[
          
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            child: Row(
              children: <Widget>[

                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  width: 30.0,
                  height: 30.0,
                  decoration:BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(3.0),
                    color: Colors.red
                  ),
                  child: Text(
                    '0',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0
                    ),
                  ),
                ),

                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  width: 30.0,
                  height: 30.0,
                  decoration:BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(3.0),
                    color: Colors.green
                  ),
                  child: Text(
                    '0',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0
                    ),
                  ),
                ),

              ],
            ),
          ),

        ],
      ),
      body: Container(
        alignment: Alignment.topCenter,
        color: Colors.black87,
        child: Container(
          padding: EdgeInsets.only(top: 5.0),
          child:  SingleChildScrollView(

            physics: BouncingScrollPhysics(),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                columns, (i) => Column(
                  children: List.generate(
                    data[i].length,
                    (el) => BlocExample(
                      letter: data[i][el],
                      columnWidth: columnWidth
                    )
                  ),
                )
              )
            ),

          )
        ),
      ),




    );

  }
}

class BlocExample extends StatefulWidget {

  final String letter;
  final double columnWidth;

  const BlocExample({Key key, @required this.letter, @required this.columnWidth}) : super(key: key);

  @override
  _BlocExampleState createState() => _BlocExampleState();
}

class _BlocExampleState extends State<BlocExample> with SingleTickerProviderStateMixin {

  String get letter => widget.letter;
  double get columnWidth => widget.columnWidth;
  double height;
  bool showLetter;

  @override
  void initState() {

    super.initState();
    height = columnWidth;
    showLetter = true;

  }

  void hide() => setState(() {
    height = 0;
  });

  @override
  Widget build(BuildContext context) {


    return GestureDetector(
      onTap: hide,
      child: AnimatedContainer(
        width:    columnWidth,
        curve:    Curves.easeInCubic,
        height:   height,
        padding:  EdgeInsets.all(3.0),
        duration: Duration(milliseconds: 360),
        child: Container(
          width:  columnWidth,
          height: columnWidth,
          alignment:  Alignment.center,
          decoration: BoxDecoration(
             
            borderRadius: BorderRadius.circular(6.0),
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end:   Alignment.topLeft,
              colors: <Color> [
                Colors.deepOrange[500],
                Colors.deepOrange[400]
              ]
            )

          ),
          child: !showLetter ? SizedBox() : Text(
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
