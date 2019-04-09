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

    this.curve = Curves.elasticOut,
    this.duration = const Duration(milliseconds: 1500),
    this.animationName = 'draw',
  }) : super(key: key);

  @override
  _ModalHandwritingState createState() => _ModalHandwritingState();
}



class _ModalHandwritingState extends State<ModalHandwriting> with SingleTickerProviderStateMixin {

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

  Animation<double> animation;
  AnimationController animationController;

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

    final width = MediaQuery.of(_context).size.width;

    animationController = AnimationController( duration: _duration, vsync: this );

    animation = Tween<double>( begin: width, end: 0 )
      .chain( CurveTween( curve: _curve ) )
      .animate(animationController);

    pause = true;
    flareControl = FlareControls();
    animationDuration = Duration(seconds: 6);


    print('ShowMe');

    final delayToShowDialog = 300;

    Future.delayed(Duration(milliseconds: delayToShowDialog), show);
    Future.delayed(
      Duration(milliseconds: delayToShowDialog + 200),
      () => animationController.forward()
    ).whenComplete(playAnimation);


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


  /// Build content dialog
  Widget buildHandwrinting() {


    final size = MediaQuery.of(_context).size;


    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform(
          transform: Matrix4.translationValues(animation.value, 0, 0),
          child: Container(

            alignment: Alignment.center,
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

            )

          ),
        );
      },
    );


  }


  /// Build container that contain: guide lines component and animation component
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


  /// Build guide lines of letter animation
  Widget guideLines() {

    return Container(
      child: CustomPaint(
        painter: GuideLines(),
      ),
    );

  }


  /// Build handwriting animation of the current letter
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


  /// Build bottom bar than contain: Button to hide Dialog - Button to retry animation
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


  /// Buil button "Next" that hide the current dialog
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


  /// Build custom button that restart animation
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
    speechAtTheEnd();
    animationController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }


}

