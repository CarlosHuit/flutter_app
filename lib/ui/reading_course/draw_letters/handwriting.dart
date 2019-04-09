import 'dart:async';

import 'package:app19022019/ui/components/custom_icon_button.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import './guide_lines.dart';



class ModalHandwriting extends StatefulWidget {

  final Duration duration;
  final BuildContext context;
  final String animationName;
  final Curve curve;

  final Function() speechAtTheStart;
  final Function() speechAtTheEnd;
  final Function() onHide;

  ModalHandwriting({
    Key key,
    @required this.context,

    @required this.onHide,
    @required this.speechAtTheEnd,
    @required this.speechAtTheStart,

    this.curve = Curves.fastLinearToSlowEaseIn,
    this.duration = const Duration(milliseconds: 1300),
    this.animationName = 'draw',
  }) : super(key: key);

  @override
  _ModalHandwritingState createState() => _ModalHandwritingState();
}



class _ModalHandwritingState extends State<ModalHandwriting> {

  Duration get _duration  =>   widget.duration;
  Curve get _curve => widget.curve;

  BuildContext get _context => widget.context;

  String     get animationName => widget.animationName;
  Function() get speechAtTheStart => widget.speechAtTheStart;
  Function() get speechAtTheEnd => widget.speechAtTheEnd;
  Function() get onHide => widget.onHide;
  
  Duration animationDuration;
  FlareControls flareControl;
  Timer futureSub;
  bool pause;


  BoxConstraints _constraints = BoxConstraints(

    minWidth:  300.0,
    maxWidth:  380.0,
    minHeight: 400.0,
    maxHeight: 480.0

  );


  BoxDecoration _decoration = BoxDecoration(

    color:        Colors.white,
    borderRadius: BorderRadius.circular(4.0),
    boxShadow: [  BoxShadow(color: Colors.black54, blurRadius: 5.0)]

  );


  @override
  void initState() {

    super.initState();

    pause = false;
    flareControl = FlareControls();
    animationDuration = Duration(seconds: 6);

    final width = MediaQuery.of(_context).size.width;


    print('ShowMe');
    Future.delayed(Duration.zero, show);
    Future.delayed(Duration(milliseconds: 200), playAnimation);


  }


  /// Show hanwriting dialog
  void show() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => WillPopScope(
        child: buildHandwrinting(),
        onWillPop: () async{
          onHide();
          return true;
        },
      )
    );
  }

  /// Remove dialog in the stack of routes and execte the onHide callBack before dispose componente
  void hide() {
    Navigator.pop(context);
    onHide();
  }

  /// Set the state to pause the current state
  void pauseAnimation() {
    setState(() => pause = true );
  }

  /// Execute [speechAtTheStart] and set the state to play the current state 
  void playAnimation() {
    speechAtTheStart();
    setState(() => pause = false);
  }

  /// Cancel previous animation and restart the animation
  void replayAnimation() {

    if (futureSub != null) {

      futureSub.cancel();
      pauseAnimation();

    }

    playAnimation();
    flareControl.play(animationName);
    setState(() => futureSub = Timer(animationDuration, pauseAnimation) );


  }


  /// Build dialog content
  Widget buildHandwrinting() {


    final size = MediaQuery.of(_context).size;


    return AnimatedContainer(

      curve:     _curve,
      duration:  _duration,
      alignment: Alignment.center,
      transform: Matrix4.translationValues(size.width * 0, 0, 0),
      child: Container(

        width:       size.width  - 20,
        height:      size.height - 20,
        constraints: _constraints,
        decoration:  _decoration,
        child: Column(
          children: [
            handwriting(size),
            bottomBar()
          ],
        ),

      ),

    );


  }


  Widget handwriting(Size size) {

    return Expanded(
      
      child:Container(
        alignment: Alignment.center,
        margin:    EdgeInsets.only(top: 60),

        child:  Container(
          width:  size.width > 340.0 ? 300.0 : 280.0,
          height: size.width > 340.0 ? 300.0 : 280.0,

          child:  Stack(
            fit:      StackFit.expand,
            children: [
              guideLines(),
              letterAnimation()
            ],
          ),

        ),

      ),

    );

  }


  Widget guideLines() {

    return Container(
      child: CustomPaint(
        painter: GuideLines(),
      ),
    );

  }


  Widget letterAnimation() {

    return Container(
      alignment: Alignment.center,
      child: FlareActor(
        'assets/alphabet/letter_h.flr',
        callback:   (s) => pauseAnimation(),
        isPaused:   pause,
        color:      Colors.blue,
        controller: flareControl,
        animation:  animationName,
        fit:        BoxFit.fitWidth,
        alignment:  Alignment.center,
      ),
    );

  }


  Widget bottomBar() {

    return Container(
      height: 80,
      alignment: Alignment.center,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[

          buttonNext(),
          buttonReplayAnimation(),

        ],
      ),
    );

  }


  Widget buttonNext() {

    return Container(
      alignment: Alignment.center,
      child: RaisedButton(
        child: Text(
          'Siguiente',
          style: TextStyle(
            fontSize: 16.0
          ),
        ),
        color:     Colors.red,
        padding:   EdgeInsets.symmetric(horizontal: 35),
        textColor: Colors.white,
        onPressed: hide,
      ),

    );

  }


  Widget buttonReplayAnimation() {
    
    return Positioned(
      top: 10.0,
      right: 10.0,
      child: CustomIconButton(
        splashColor: Colors.red[50],
        height: 60.0,
        width:  60.0,
        icon:   Icon(Icons.replay, color: Colors.red),
        onTap:  replayAnimation,
      ),
    );

  }


  @override
  void dispose() {
    print('closed');
    // onHide();
    speechAtTheEnd();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }


}

