import 'package:flutter/material.dart';

import 'package:app19022019/core/src/viewmodels/reading_course/letter_detail_view_model.dart';
import './bottom_sheet_letter_detail.dart';
import './option_card.dart';
import './try_again_dialog.dart';
import './well_done_dialog.dart';

class LetterDetailBody extends StatefulWidget {

  final LetterDetailViewModel vm;

  const LetterDetailBody({ Key key, @required this.vm }) : super(key: key);

  @override
  _LetterDetailBodyState createState() => _LetterDetailBodyState();
}

class _LetterDetailBodyState extends State<LetterDetailBody> {


  LetterDetailViewModel get vm => widget.vm;

  @override
  void initState() {

    super.initState();
    showModalSheet(vm, context);

  }

  @override
  Widget build(BuildContext context) {

    final size    = MediaQuery.of(context).size;
    final width90 = size.width * 0.90;
    final options = List.generate(
      widget.vm.options.length,
      (i) => OptionCard(
        vm: widget.vm,
        letterId: '${widget.vm.options[i]}$i',
        hideAllCars: widget.vm.hideAllCards,
        showAllCards: widget.vm.showAllCards,
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
              viewModel:  vm,
              speak:      vm.listenCorrectMsg,
              hideDialog: vm.hideWellDoneDialog,
              canShowModalSheet: vm.currentIndex < vm.dataLength -1 ? true : false,
              callBack: () => print('Change Current Data'),
            )
            : SizedBox()
        ),

        Positioned(
          child: vm.showTryAgainDialog
            ? TryAgainDialog(
              speak:      vm.listenIncorrectMsg,
              hideDialog: vm.hideTryAgainDialog,
              callBack: () => print('CallBack executed'),
            )
            : SizedBox(),
        ),

      ]
    );

  }


}
