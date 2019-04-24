import 'dart:async';

import 'package:app19022019/core/src/viewmodels/reading_course/letter_detail_view_model.dart';
import 'package:app19022019/ui/reading_course/letter_detail/letter_detail_modal.dart';
import 'package:flutter/material.dart';

import './option_card.dart';
import './try_again_dialog.dart';
import './well_done_dialog.dart';

class LetterDetailContent extends StatefulWidget {

  final LetterDetailViewModel vm;

  const LetterDetailContent({ Key key, @required this.vm }) : super(key: key);

  @override
  _LetterDetailContentState createState() => _LetterDetailContentState();
}

class _LetterDetailContentState extends State<LetterDetailContent> {


  LetterDetailViewModel get vm => widget.vm;
  bool useAnimation;

  @override
  void initState() {
    super.initState();
    useAnimation = false;
    // showModalSheet(vm, context);
    Timer(Duration.zero, changeUseAnimationStatus );

  }

  changeUseAnimationStatus() {
    setState(() {
      useAnimation = true;
    });
  }

  void hideModalAndSpeakInstructions() {
    vm.hideLetterDetailModal();
    vm.modalSheetFMsg();
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



    return Scaffold(

      body: Stack(
        fit: StackFit.expand,
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

          vm.showModal
          ? LetterDetailModal(
            ctx:    context,
            letter: vm.letter,
            onEnd:  hideModalAndSpeakInstructions,
            onInit: vm.modalSheetIMsg,
            onPressIcon:  vm.modalSheetFMsg,
            useAnimation: useAnimation,
          )
          : Offstage(),

        ]
      ),

    );

  }


}

