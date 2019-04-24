import 'package:app19022019/core/src/viewmodels/reading_course/letter_detail_view_model.dart';
import 'package:app19022019/utils/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class OptionCard extends StatelessWidget {

  final String letterId;
  final bool   showAllCards;
  final bool   hideAllCars;
  final LetterDetailViewModel vm;

  const OptionCard({
    Key key,
    @required this.letterId,
    @required this.hideAllCars,
    @required this.showAllCards,
    @required this.vm
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.all(3.0),
      child: FlipCard(
        callBack:     () => vm.selectOption(letterId),
        direction:    FlipDirection.VERTICAL,
        // back:         OptionCardBack(letter: letterId[0],),
        // front:        OptionCardFront(),
        back:         cardBack(letterId[0]),
        front:        cardFront(),
        hideAllCards: hideAllCars,
        showAllCards: showAllCards,
        showCard:     letterId == vm.selection1 || letterId == vm.selection2,
        canPlayGame:  vm.canPlayGame,
      ),

    );
  }

  Widget cardBack(String letter) {
        const TextStyle letterStyle = TextStyle(
      fontSize:   60.0,
      color:      Colors.white,
      fontWeight: FontWeight.bold,
    );

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border:       Border.all(width: 3.0, color: Colors.white),
        gradient:     LinearGradient(

          end:    Alignment.bottomRight,
          begin:  Alignment.topLeft,
          stops:  [0.1, 0.5, 0.9],
          colors: [ Colors.orange, Colors.orange[600], Colors.orange[700] ],

        ),
      ),
      alignment: Alignment.center,
      child:     Text( letter, style: letterStyle ),
    );
  }

  Widget cardFront() {

    return Container(

      alignment: Alignment.center,
      child:     Icon( Icons.filter_vintage, color: Colors.white, size: 36.0 ),
      
      decoration: BoxDecoration(
        border: Border.all(width: 3.0, color: Colors.white),
        borderRadius: BorderRadius.circular(5.0),
        gradient: LinearGradient(
          begin:  Alignment.topRight,
          end:    Alignment.bottomLeft,
          stops: [0.1, 0.9],
          colors: [
            Color.fromARGB(255, 0, 155, 77),
            Color.fromARGB(255, 0, 172, 90),
          ],
        ),
      ),
 
    );

  }

}