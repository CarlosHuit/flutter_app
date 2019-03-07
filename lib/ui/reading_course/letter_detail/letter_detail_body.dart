
import 'package:app19022019/core/src/viewmodels/reading_course/letter_detail_view_model.dart';
import 'package:app19022019/ui/reading_course/letter_detail/option_card.dart';
import 'package:flutter/material.dart';

class LetterDetailBody extends StatelessWidget {

  final LetterDetailViewModel vm;

  const LetterDetailBody({ Key key, @required this.vm }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;

    return Container(
      child: Container(
        alignment:  Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit:   BoxFit.fitHeight,
            image: AssetImage("assets/star-pattern.png"),
          ),
          gradient: LinearGradient(
            tileMode: TileMode.mirror,
            stops:    [0.0, 1],
            begin:    Alignment.bottomCenter,
            end:      Alignment.topCenter,
            colors: [
              Color.fromARGB(255, 11, 62, 113),
              Color.fromARGB(255, 13, 100, 176)
            ]
          )
        ),

        child: Container(
          width:  size.width * .90,
          height: ((size.width * 0.90) / 3) * 4,
          child: GridView.count(
            crossAxisCount: 3,
            shrinkWrap:     true,
            physics:        NeverScrollableScrollPhysics(),
            padding:        EdgeInsets.all(1.0),
            children:       List.generate(
              vm.options.length,
              (i) => OptionCard(
                vm: vm,
                letterId:    '${vm.options[i]}$i',
                hideAllCars:  vm.hideAllCards,
                showAllCards: vm.showAllCards,
              )
            ),
          ),
        ),

      )

    );

  }

}

