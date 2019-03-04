import 'dart:math';
import 'package:flutter/material.dart';

enum FlipDirection { VERTICAL, HORIZONTAL }



class FlipCard extends StatefulWidget {

  final Widget front;
  final Widget back;
  final int    speed = 500;
  final FlipDirection direction;

  final bool showAllCards;
  final bool hideAllCards;

  const FlipCard({
    Key key,
    @required this.front,
    @required this.back,
    @required this.showAllCards,
    @required this.hideAllCards,
    this.direction = FlipDirection.HORIZONTAL
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
  bool get _showAllCards => widget.showAllCards;
  bool get _hideAllCards => widget.hideAllCards;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: Duration(milliseconds: widget.speed),
      vsync:    this
    );

    _frontRotation = TweenSequence(
      <TweenSequenceItem<double>>[

        TweenSequenceItem<double>(
          weight: 50.0,
          tween: Tween(
            begin: 0.0,
            end: pi / 2
          ).chain(
            CurveTween(curve: Curves.linear)
          ),
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

/// [ Void ] a function to hide or show the current card
  _toggleCard() {

    if (isFront)
      controller.forward();
    else
      controller.reverse();

    isFront = !isFront;

  }

  void showAllCards() {
    isFront = false;
    controller.forward();
  }

  void hideAllCards() {
    isFront = true;
    controller.reverse();
  }


  @override
  Widget build(BuildContext context) {

    if (_showAllCards) {
      print('show all cards ${DateTime.now()}');
      showAllCards();
    }

    if (_hideAllCards) {
      print('hide all cards ${DateTime.now()}');
      hideAllCards();
    }

    return GestureDetector(
      onTap: _toggleCard,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[

          AnimationCard(
            animation: _frontRotation,
            child:     widget.front,
            direction: widget.direction,
          ),
          AnimationCard(
            animation: _backRotation,
            child:     widget.back,
            direction: widget.direction,
          ),

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

        if (direction == FlipDirection.VERTICAL)
          transform.rotateX(animation.value);
        else
          transform.rotateY(animation.value);

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