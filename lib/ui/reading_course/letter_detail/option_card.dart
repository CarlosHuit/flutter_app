import 'package:app19022019/core/src/viewmodels/reading_course/letter_detail_view_model.dart';
import 'package:app19022019/ui/reading_course/letter_detail/option_card_back.dart';
import 'package:app19022019/ui/reading_course/letter_detail/option_card_front.dart';
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
        callBack:     () => vm.selectOpt(letterId),
        direction:    FlipDirection.VERTICAL,
        back:         OptionCardBack(letter: letterId[0],),
        front:        OptionCardFront(),
        hideAllCards: hideAllCars,
        showAllCards: showAllCards,
        showCard:     letterId == vm.selection1 || letterId == vm.selection2,
      ),

    );
  }


}