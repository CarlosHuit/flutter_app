import 'dart:async';

import 'package:app19022019/core/src/viewmodels/reading_course/letter_detail_view_model.dart';
import 'package:app19022019/ui/components/custom_circular_icon_button.dart';
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

          LetterDetailModal(
            ctx:    context,
            letter: vm.letter,
            onEnd:  vm.modalSheetFMsg,
            onInit: vm.modalSheetIMsg,
            onPressIcon:  vm.modalSheetIMsg,
            useAnimation: useAnimation,
          ),

        ]
      ),

    );

  }


}


class LetterDetailModal extends StatefulWidget {

  final String letter;
  final Function() onInit;
  final Function() onPressIcon;
  final Function() onEnd;
  final bool useAnimation;
  final BuildContext ctx;

  LetterDetailModal({
    Key key,
    @required this.letter,
    @required this.onEnd,
    @required this.onInit,
    @required this.onPressIcon,
    @required this.useAnimation,
    @required this.ctx,
  }) : super(key: key);

  @override
  _LetterDetailModalState createState() => _LetterDetailModalState();

}

class _LetterDetailModalState extends State<LetterDetailModal> {


  bool get useAnimation => widget.useAnimation;
  String   get letter => widget.letter;
  Function get onInit => widget.onInit;
  Function get onEnd  => widget.onEnd;
  Function get onPressIcon => widget.onPressIcon;
  BuildContext get ctx => widget.ctx;

  double   positionX;
  Duration translateDuration;
  Duration opacityDuration;
  Color opacity;    

  @override
  void initState() {

    super.initState();

    final screenWidth = MediaQuery.of(ctx).size.width;
    translateDuration = Duration(milliseconds: 1200);
    opacityDuration = Duration(milliseconds: 200);
    positionX = useAnimation ? screenWidth : 0;

    if (useAnimation) {
      Future.delayed(Duration(milliseconds: 100), showCard);
    }

    if (!useAnimation) {
      
      opacity = Colors.black38;
      onInit();
      
    }

  }


  @override
  void dispose() {
    super.dispose();
  }


  void showCard() {
    setState(() {
      positionX = 0;
    });
  }


  void hideCard() {
    setState(() {
      positionX = MediaQuery.of(context).size.width;
      opacity = Colors.transparent;
    });
  }


  double calcFontSize() {

    final double screenWidth = MediaQuery.of(context).size.width;
    const double maxWidth  = 380.0;
    final double relWidth  = screenWidth - 40;
    final double cardWidth = relWidth > maxWidth ? maxWidth : relWidth;

    return cardWidth * 0.75;

  }


  @override
  Widget build(BuildContext context) {


    return AnimatedContainer(
      duration:  translateDuration - Duration(milliseconds: 400),
      color:     opacity,
      alignment: Alignment.center,

      child: AnimatedContainer(
        curve: Curves.fastLinearToSlowEaseIn,
        transform: Matrix4.translationValues(positionX, 0, 0),
        duration:  translateDuration,
        child:     buildCard(),
      ),

    );


  }


  Widget buildCard() {

    final size = MediaQuery.of(context).size;

    return Container(
      width:  size.width - 40.0,
      height: size.height - 80.0,
      constraints: BoxConstraints(
        maxHeight: 560.0,
        maxWidth:  380.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.65),
            blurRadius: 10.0
          )
        ]
      ),
      child: Stack(
        children: <Widget>[

          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 25.0),
            child: Text(
              letter,
              style: TextStyle(
                color:      Color.fromARGB(250, 255, 223, 0),
                fontSize:   calcFontSize(),
                fontWeight: FontWeight.bold,
                shadows: <Shadow> [

                  Shadow(
                    color: Colors.black45,
                    blurRadius: 2.0
                  ),

                  Shadow(
                    blurRadius: 6.0,
                    offset: Offset(-4, 7),
                    color:  Colors.black54,
                  ),
                ]
              ),
            ),
          ),


          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(bottom: 30.0),
            child: RaisedButton(
              highlightColor: Colors.transparent,
              color:     Colors.red,
              textColor: Colors.white,
              onPressed: hideCard,
              padding:   EdgeInsets.symmetric(
                horizontal: 50.0,
                vertical: 10.0
              ),
              child:     Text(
                'Siguiente',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  letterSpacing: 0.4
                ),
              ),
            ),
          ),

          Positioned(
            top: 10.0,
            right: 10.0,
            child: CustomCircularIconButton(
              splashColor: Colors.red[50],
              height: 72.0,
              width:  72.0,
              onTap:  onPressIcon,
              icon:   Icon(
                Icons.volume_up,
                color: Colors.red,
                size: 36.0,
              ),
            ),
          )


        ],
      ),
    );

  }


}