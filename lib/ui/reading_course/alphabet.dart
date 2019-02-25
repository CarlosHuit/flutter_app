import 'package:flutter/material.dart';

Widget alphabet(BuildContext context) {

  final size = MediaQuery.of(context).size;

  return Container(

    alignment: Alignment.center,

    child: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[

          SizedBox(height: 15.0),          
          itemLetter(size: size, letter: 'a'),
          itemLetter(size: size, letter: 'b'),
          itemLetter(size: size, letter: 'c'),
          itemLetter(size: size, letter: 'd'),
          itemLetter(size: size, letter: 'e'),
          itemLetter(size: size, letter: 'f'),
          itemLetter(size: size, letter: 'g'),
          itemLetter(size: size, letter: 'h'),
          itemLetter(size: size, letter: 'i'),
          itemLetter(size: size, letter: 'j'),
          itemLetter(size: size, letter: 'k'),
          itemLetter(size: size, letter: 'l'),
          itemLetter(size: size, letter: 'm'),
          itemLetter(size: size, letter: 'n'),
          itemLetter(size: size, letter: 'ñ'),
          itemLetter(size: size, letter: 'o'),
          itemLetter(size: size, letter: 'p'),
          itemLetter(size: size, letter: 'q'),
          itemLetter(size: size, letter: 'r'),
          itemLetter(size: size, letter: 's'),
          itemLetter(size: size, letter: 't'),
          itemLetter(size: size, letter: 'u'),
          itemLetter(size: size, letter: 'v'),
          itemLetter(size: size, letter: 'w'),
          itemLetter(size: size, letter: 'x'),
          itemLetter(size: size, letter: 'y'),
          itemLetter(size: size, letter: 'z'),
          SizedBox(height: 15.0)

        ],
      )
    ),

  );

}

Widget itemLetter({@required Size size, @required String letter}) {
  return Container(

    height: 100.0,
    child: Card(
      child: Row(
        children: <Widget>[
          Container(
            // color: Colors.lime,
            height: size.height,
            width: 60.0,
            alignment: Alignment.center,

            child: Container(
              width: 40.0,
              height: 40.0,
              margin: EdgeInsets.all(0),
              child: RaisedButton(
                
                color: Colors.green,
                child: Icon(Icons.volume_up, color: Colors.white, size: 36.0,),
                onPressed: () {},
              ),
            ),

          ),
          Expanded(
            child: Container(
              height: 100.0,
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              // color: Colors.pink,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(letter.toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 64.0)),
                  SizedBox(width: 20.0),
                  Text(letter.toLowerCase(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 64.0)),
                ],
              ),
            ),
          ),
          Container(
            width:  98.0,
            height: 98.0,
            color:  Colors.black87,
            child: Icon(Icons.image, color: Colors.white,),
          )
        ],
      ),
    ),

  );
}

Widget tabAlphabet() {
  return Tab(

    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.font_download, color: Colors.yellow,),
        SizedBox(width: 5.0,),
        Text(
          'Abecedario',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0
          ),
        )
      ],

    )

  );
}