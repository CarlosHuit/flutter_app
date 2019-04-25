import 'dart:async';

import 'package:app19022019/core/src/viewmodels/reading_course/letter_detail_view_model.dart';
import 'package:app19022019/ui/components/custom_circular_icon_button.dart';
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
    Timer(Duration.zero, changeUseAnimationStatus );

  }



  void changeUseAnimationStatus() {
    setState(() {
      useAnimation = true;
    });
  }



  void hideModalAndSpeakInstructions() {

    vm.hideLetterDetailModal();
    vm.modalSheetFMsg();

    vm.dispatchShowAllCards();

    Future.delayed(
      Duration(milliseconds: 3000),
      vm.dispatchHideAllCards
    );

  }



  @override
  Widget build(BuildContext context) {

    final size    = MediaQuery.of(context).size;
    final width90 = size.width * 0.90;
    // final options = 


    return Scaffold(

      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[

          Container(

            child: Container(
              alignment:  Alignment.center,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit:   BoxFit.cover,
                  image: AssetImage("assets/star-pattern.png"),
                ),
                gradient: LinearGradient(
                  // begin: Alignment.bottomCenter,
                  // end: Alignment.topCenter,
                  begin:  Alignment.topLeft,
                  end:    Alignment.bottomRight,
                  stops:  [ 0.0, 0.8 ],
                  colors: [ Color.fromARGB(255, 11, 62, 113), Color.fromARGB(255, 13, 100, 176) ]
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
                  children:   buildOptions(),

                ),
              ),

            )

          ),

          /// Button Help
          vm.data.helpCounter < 2
          ? Positioned(
            bottom: 10.0,
            left: 10.0,
            child: CustomCircularIconButton(
              height: 48.0,
              width:  48.0,
              onTap:  vm.showLetterDetailModal,
              splashColor: Colors.white12,
              icon: Icon(
                Icons.help_outline,
                color: Colors.white,
                size: 32.0,
              ),
            ),
          )
          : Offstage(),

          vm.showWellDoneDialog
            ? WellDoneDialog(
              viewModel:  vm,
              speak:      vm.listenCorrectMsg,
              hideDialog: vm.hideWellDoneDialog,
              canShowModalSheet: vm.currentIndex < vm.dataLength -1 ? true : false,
              callBack: () {},
            )
            : SizedBox(),


          vm.showTryAgainDialog
            ? TryAgainDialog(
              speak:      vm.listenIncorrectMsg,
              callBack:   () {},
              hideDialog: vm.hideTryAgainDialog,
            )
            : SizedBox(),

          vm.showModal
          ? LetterDetailModal(
            ctx:    context,
            letter: vm.letter,
            onEnd:  hideModalAndSpeakInstructions,
            onInit: vm.modalSheetIMsg,
            onPressIcon:  vm.modalSheetIMsg,
            useAnimation: useAnimation,
          )
          : SizedBox(),

        ]
      ),

    );

  }


  List<Widget> buildOptions() {

    return List.generate(
      vm.options.length,
      (int i) {

        final letterId = '${vm.options[i]}$i';

        return OptionCard(
          vm:           vm,
          letterId:     letterId,
          hideAllCars:  vm.hideAllCards,
          showAllCards: vm.showAllCards,
        );

      }
    );

  }


}

