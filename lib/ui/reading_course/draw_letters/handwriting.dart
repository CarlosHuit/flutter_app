import 'dart:async';

import 'package:app19022019/ui/components/custom_circular_icon_button.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';

import './guide_lines.dart';



class ModalHandwriting extends StatefulWidget {

  /// [ Duration ] duration to use in the animation of handwriting container. Default: Duration(milliseconds: 420)
  final Duration duration;

  /// [ BuildContext ] context to get size of screen
  final BuildContext context;

  /// [ String ] name of the animation to use. Default: 'draw'
  final String animationName;

  /// [ Curve ] curve to apply to the animation of handwriting  container. Default Curves.fastOutSlowIn
  final Curve curve;

  /// [ Function() ] Function to execute when the animation begins.
  final Function() speechAtTheStart;

  /// [ Function() ] Function to execute on dipose this component
  final Function() speechAtTheEnd;

  /// [ Function() ] Function to remove this component of the tree
  final Function() onHide;

  /// [ Axis ] Define animation direction
  final Axis direction;

  /// [ bool ] define if modal start with animation
  final useAnimation;

  ModalHandwriting({

    Key key,
    @required this.onHide,
    @required this.context,
    @required this.speechAtTheEnd,
    @required this.speechAtTheStart,

    this.curve =         Curves.fastOutSlowIn,
    this.duration =      const Duration(milliseconds: 420),
    this.direction =     Axis.vertical,
    this.useAnimation =  true,
    this.animationName = 'draw',

  }) : super(key: key);

  @override
  _ModalHandwritingState createState() => _ModalHandwritingState();
}



class _ModalHandwritingState extends State<ModalHandwriting> with SingleTickerProviderStateMixin {

  /// Getter of useAnimation property that control if show animation on start component
  bool get _useAnimation => widget.useAnimation;

  /// Getter of animation curve
  Curve get _curve => widget.curve;

  /// Getter of animation duration
  Duration get _duration => widget.duration;

  /// Getter of BuildContext
  BuildContext get _context => widget.context;

  /// Getter of animation name
  String     get animationName => widget.animationName;

  /// Getter of function speechAtTheStart
  Function() get speechAtTheStart => widget.speechAtTheStart;

  /// Getter of function speechAtTheEnd 
  Function() get speechAtTheEnd => widget.speechAtTheEnd;

  /// Getter of function onHide
  Function() get onHide => widget.onHide;

  /// Getter of animation direction
  Axis get _direction => widget.direction;
  
  /// Total of animation handwrinting duration
  Duration animationDuration;

  /// Controllers of current animation
  FlareControls flareControl;

  /// [Future] Timer to pause the animation. Is Cancelable
  Timer futureSub;

  /// Controller that handle animation pause
  bool pause;

  /// constraits of handwriting container
  BoxConstraints _constraints = BoxConstraints(

    maxHeight: 560.0,
    maxWidth:  380.0,

  );

  double positionX;
  double positionY;
  Duration translationDuration;

  /// decoration of handwriting container
  BoxDecoration _decoration = BoxDecoration(

    color:        Colors.white,
    borderRadius: BorderRadius.circular(4.0),
    boxShadow: [  BoxShadow(color: Colors.black54, blurRadius: 5.0)]

  );


  @override
  void initState() {

    super.initState();

    
    animationDuration = Duration(seconds: 6);
    flareControl = FlareControls();
    pause = true;

    final screenSize = MediaQuery.of(_context).size;
    translationDuration = Duration(milliseconds: 1200);
    positionX = setInitialPositionX(screenSize);
    positionY = setInitialPositionY(screenSize);


    if (_useAnimation) {

      Timer(Duration(milliseconds: 100), show);
      Timer(translationDuration, playAnimation);

    }


    if (!_useAnimation) {

      Timer(Duration.zero, () {
        show();
        playAnimation();
      });

    }



  }

  double setInitialPositionX(Size screenSize) {

    if ( _useAnimation && _direction == Axis.horizontal ) {
      return screenSize.width;
    }
    return 0.0;

  }

  double setInitialPositionY(Size screenSize) {

    if ( _useAnimation && _direction == Axis.vertical ) {
      return screenSize.height;
    }

    return 0.0;

  }

  /// Show hanwriting dialog
  void show() {

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {

         return WillPopScope(
          child: buildHandwrinting(),
          onWillPop: () async{
            onHide();
            return true;
          },
        );

      }
    );

  }


  /// Remove dialog in the stack of routes and execte the onHide callBack before dispose componente
  void hide() {

    Timer(_duration, () {
      Navigator.pop(context);
      onHide();
    });

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
    ///
    setState(() {
      futureSub = Timer(animationDuration, pauseAnimation);
    });


  }


  /// Build content dialog
  Widget buildHandwrinting() {

    return AnimatedContainer(
      curve: _curve,
      alignment: Alignment.center,
      duration: Duration(milliseconds: 1300),
      child: buildCard(),
    );

    // return AnimatedBuilder(
    //   animation: animation,
    //   builder: (context, child) {
    //     return Transform(
    //       transform: _useAnimation
    //         ? Matrix4.translationValues(
    //           _direction == Axis.horizontal ? animation.value : 0,
    //           _direction == Axis.vertical ? animation.value : 0,
    //           0
    //         )
    //         : Matrix4.translationValues(0, 0, 0),
    //       ),
    //     );
    //   },
    // );


  }

  Widget buildCard() {

    final size = MediaQuery.of(context).size;

    return Container(
      width:  size.width - 40.0,
      height: size.height- 80.0,
      constraints: _constraints,
      decoration:  _decoration,
        child: Column(
          children: [ handwriting(size), bottomBar() ],
        ),
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
      child: CustomCircularIconButton(
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
    speechAtTheEnd();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }


}

