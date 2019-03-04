import 'dart:async';

import 'package:app19022019/utils/flip_card.dart';
import 'package:flutter/material.dart';

class LetterDetailScreen extends StatefulWidget {

  @override
  _LetterDetailScreenState createState() => _LetterDetailScreenState();
}

class _LetterDetailScreenState extends State<LetterDetailScreen> {

  bool showAllCards;
  bool hideAllCards;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 0), _showModalSheet);
    showAllCards = false;
    hideAllCards = true;
  }


  @override
  void dispose() {
    super.dispose();
  }

  void _toggleShowAllCard() {
    setState(() {
      showAllCards = !showAllCards;
      hideAllCards = !hideAllCards;
    });
  }

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: Icon(Icons.arrow_upward, size: 28.0,),
        onPressed: _toggleShowAllCard,
      ),
      body: Container(
        child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit:          BoxFit.fitHeight,
            image:        AssetImage("assets/star-pattern.png"),
          ),
          gradient: LinearGradient(
            tileMode: TileMode.mirror,
            stops: [0.0, 1],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Color.fromARGB(255, 11, 62, 113),
              Color.fromARGB(255, 13, 100, 176)
            ]
          )
        ),
              

          alignment: Alignment.center,
          child: Container(
            width:  size.width * .90,
            height: ((size.width * 0.90) / 3) * 4,
            child: GridView.count(
              shrinkWrap:     true,
              crossAxisCount: 3,
              physics:  NeverScrollableScrollPhysics(),
              padding:  EdgeInsets.all(1.0),
              children: List.generate(12, (i) => OptionCard(
                letter: i.toString(),
                hideAllCars: hideAllCards,
                showAllCards: showAllCards,
              )),
            ),
          ),
        )

      )
    );

  }


  void _showModalSheet() {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Container(
          color:   Colors.grey[100],
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
          child:   Card(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'P',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.yellowAccent,
                    fontSize: 200.0,
                    shadows: <Shadow> [
                      Shadow(color: Colors.black, offset: Offset(-1.2, 1.2)),
                      Shadow(color: Colors.black, offset: Offset(1.2, -1.2)),
                      Shadow(color: Colors.black, offset: Offset(1.2, 1.2)),
                      Shadow(color: Colors.black, offset: Offset(-1.2, -1.2)),
                      Shadow(color: Colors.black, blurRadius: 15.0),
                    ]
                  ),
                ),
                Container(
                  width: 200.0,
                  height: 40.0,
                  child: RaisedButton(

                    onPressed: () => Navigator.pop(context),
                    color:     Colors.red,
                    child:     Text(
                      'Continuar',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color:      Colors.white,
                        fontSize:   18.0
                      ),
                    ),

                  )
                ),

              ],
            )

            )
        );
      }
    ).whenComplete(() => print('closed ${DateTime.now()}'));
  }



}


class OptionCard extends StatelessWidget {

  final String letter;
  final bool showAllCards;
  final bool hideAllCars;

  const OptionCard({Key key, this.letter, this.showAllCards, this.hideAllCars}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      
      padding: EdgeInsets.all(3.0),
      child: FlipCard(
        direction:    FlipDirection.VERTICAL,
        back:         OptionCardBack(letter: letter,),
        front:        OptionCardFront(),
        hideAllCards: hideAllCars,
        showAllCards: showAllCards,
        
      )

    );
  }
}


class OptionCardBack extends StatelessWidget {

  final String letter;

  const OptionCardBack({Key key, this.letter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(width: 3.0, color: Colors.white),
        gradient: LinearGradient(
          end:  Alignment.bottomRight,
          begin:    Alignment.topLeft,
          stops: [0.1, 0.5, 0.9],
          colors: [
            Colors.orange,
            Colors.orange[600],
            Colors.orange[700],
          ],
        ),
      ),
      alignment: Alignment.center,
      child:     Text(
        '$letter',
        style: TextStyle(
          color:      Colors.white,
          fontWeight: FontWeight.bold,
          fontSize:   60.0,
        ),
      ),
    );
  }
}



class OptionCardFront extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment:  Alignment.center,
      child:      Icon(
        Icons.filter_vintage,
        color: Colors.white,
        size:  36.0,
      ),
      
      decoration: BoxDecoration(
        border: Border.all(width: 3.0, color: Colors.white),
        borderRadius: BorderRadius.circular(5.0),
        gradient: LinearGradient(
          begin:  Alignment.topRight,
          end:    Alignment.bottomLeft,
          stops: [0.1, 0.9],
          colors: [
            Color.fromARGB(255, 0, 155, 77),
            // Color.fromARGB(255, 0, 179, 95),
            Color.fromARGB(255, 0, 172, 90),
          ],
        ),
      ),
    );
  }
}