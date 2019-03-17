
import 'package:app19022019/core/src/viewmodels/reading_course/letter_detail_view_model.dart';
import 'package:app19022019/ui/components/dialogs/try_again_dialog.dart';
import 'package:app19022019/ui/components/dialogs/well_done_dialog.dart';
import 'package:app19022019/ui/reading_course/letter_detail/option_card.dart';
import 'package:flutter/material.dart';

class LetterDetailBody extends StatelessWidget {

  final LetterDetailViewModel vm;

  const LetterDetailBody({
    Key key,
    @required this.vm
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size    = MediaQuery.of(context).size;
    final width90 = size.width * 0.90;

    final options = List.generate(
      vm.options.length,
      (i) => OptionCard(
        vm: vm,
        letterId: '${vm.options[i]}$i',
        hideAllCars: vm.hideAllCards,
        showAllCards: vm.showAllCards,
      )
    );


    return Stack(

      children: <Widget>[

        Container(
          child: Container(
            alignment:  Alignment.center,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit:   BoxFit.fitHeight,
                image: AssetImage("assets/star-pattern.png"),
              ),
              gradient: LinearGradient(
                stops:    [0.0, 0.8],
                begin: Alignment.bottomLeft,
                end:   Alignment.topRight,
                colors: [
                  Color.fromARGB(255, 11, 62, 113),
                  Color.fromARGB(255, 13, 100, 176)
                ]
              )
            ),

            child: Container(
              width:  width90,
              height: (width90 / 3) * 4,
              child:  GridView.count(

                crossAxisCount: 3,
                shrinkWrap: true,
                physics:    NeverScrollableScrollPhysics(),
                padding:    EdgeInsets.all(1.0),
                children:   options,

              ),
            ),

          )

        ),

        Positioned(
          child: vm.showWellDoneDialog
            ? WellDoneDialog(
              vm: vm,
              callBack: () => print('CallBack executed'),
            )
            : SizedBox()
        ),

        Positioned(
          child: vm.showTryAgainDialog
            ? TryAgainDialog(
              vm: vm,
              callBack: () => print('CallBack executed'),
            )
            : SizedBox(),
        ),

      ]
    );

  }

}
