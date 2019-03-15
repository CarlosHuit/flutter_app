import 'dart:math';
import 'package:flutter/material.dart';

enum FlipDirection { VERTICAL, HORIZONTAL }



class FlipCard extends StatefulWidget {

  final Widget front;
  final Widget back;
  // final int    speed = 500;
  final int    speed = 700;
  final FlipDirection direction;
  final Function() callBack;

  final bool showAllCards;
  final bool hideAllCards;
  final bool showCard;
  final bool canPlayGame;

  const FlipCard({
    Key key,
    this.direction = FlipDirection.HORIZONTAL,

    @required this.front,
    @required this.back,
    @required this.showAllCards,
    @required this.hideAllCards,
    @required this.callBack,
    @required this.showCard,
    @required this.canPlayGame,

  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FlipCardState();
  }
}

class _FlipCardState extends State<FlipCard> with SingleTickerProviderStateMixin {

  AnimationController controller;
  Animation<double> _frontRotation;
  Animation<double> _backRotation;

  bool isFront = true;

  FlipDirection get _direction => widget.direction;
  Function      get _callBack  => widget.callBack;

  bool get _showAllCards => widget.showAllCards;
  bool get _hideAllCards => widget.hideAllCards;
  bool get _canPlayGame  => widget.canPlayGame;
  bool get _showCard => widget.showCard;
  Widget get _front  => widget.front;
  Widget get _back   => widget.back;




  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync:    this,
      duration: Duration(milliseconds: widget.speed),
    );

    _frontRotation = TweenSequence(
      <TweenSequenceItem<double>>[

        TweenSequenceItem<double>(
          weight: 50.0,
          tween:  Tween(begin: 0.0, end: pi / 2 )
            .chain( CurveTween(curve: Curves.linear) ),
        ),
        TweenSequenceItem<double>(
          tween: ConstantTween<double>(pi / 2),
          weight: 50.0,
        ),

      ],
    ).animate(controller);

    _backRotation = TweenSequence(
      <TweenSequenceItem<double>>[

        TweenSequenceItem<double>(
          tween: ConstantTween<double>(pi / 2),
          weight: 50.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween(begin: -pi / 2, end: 0.0).chain(CurveTween(curve: Curves.linear)),
          weight: 50.0,
        ),

      ],
    ).animate(controller);

  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  void showCard() {
    isFront = false;
    controller.forward();
  }

  void hideCard() {
    isFront = true;
    controller.reverse();
  }


  @override
  Widget build(BuildContext context) {

    if ( _showAllCards || _showCard ) { showCard(); }
    if ( _hideAllCards && !_showCard ) { hideCard(); }

    return GestureDetector(
      onTap: _canPlayGame ? () => isFront ? _callBack() : null : null,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          AnimationCard( animation: _frontRotation, child: _front, direction: _direction ),
          AnimationCard( animation: _backRotation, child: _back, direction: _direction ),
        ],
      ),
    );

  }


}



class AnimationCard extends StatelessWidget {

  final Widget child;
  final Animation<double> animation;
  final FlipDirection direction;

  AnimationCard({this.child, this.animation, this.direction});



  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(

      animation: animation,
      builder:   (BuildContext context, Widget child) {

        final Matrix4 transform = Matrix4.identity();

        transform.setEntry(3, 2, 0.001);

        if (direction == FlipDirection.VERTICAL) {

          transform.rotateX(animation.value);

        } else {

          transform.rotateY(animation.value);

        }

        return Transform(
          transform: transform,
          alignment: Alignment.center,
          child:     child,
        );
      },
      child: child,
    );
  }


}