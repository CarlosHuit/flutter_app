
import 'dart:async';

import 'package:app19022019/ui/components/custom_circular_icon_button.dart';
import 'package:flutter/material.dart';

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
      Timer(Duration.zero, showBackground );
      Timer(Duration(milliseconds: 400), showCard);
      Timer(translateDuration, onInit);
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
    setState(() => positionX = 0 );
  }


  void showBackground() {
    setState(() => opacity = Colors.black38 );
  }


  void setValuesTohideCard() {
    setState(() {
      positionX = MediaQuery.of(context).size.width;
      opacity = Colors.transparent;
    });
  }

  void hideCard() async{

    setValuesTohideCard();
    await Future.delayed(translateDuration - Duration(milliseconds: 200));
    onEnd();

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