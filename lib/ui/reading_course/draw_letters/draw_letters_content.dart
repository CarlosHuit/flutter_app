import 'dart:async';

import 'package:app19022019/core/src/redux/reading_course/rc_draw_letters/rc_draw_letters_state.dart';
import 'package:app19022019/core/src/viewmodels/reading_course/draw_letters_view_model.dart';
import 'package:flutter/material.dart';

import './blackboard.dart';
import './blackboard_controls/blackboard_bottom_control_bar.dart';
import './blackboard_controls/blackboard_top_control_bar.dart';
import './blackboard_controls/custom_pop_up_menu.dart';
import './blackboard_controls/stroke_color_selector.dart';
import './blackboard_controls/stroke_size_selector.dart';
import './handwriting.dart';


class DrawLettersContent extends StatefulWidget {

  final DrawLettersViewModel vm;

  DrawLettersContent({ Key key, @required this.vm }) : super(key: key);

  @override
  _DrawLettersContentState createState() => _DrawLettersContentState();

}


class _DrawLettersContentState extends State<DrawLettersContent> {

  DrawLettersViewModel get vm => widget.vm;

  List<StrokeData> strokes;


  @override
  void initState() {

    super.initState();
    strokes = [];
    Future.delayed( Duration.zero, showHandwritingModal );

  }


  void showHandwritingModal() {

    showDialog(
      context: context,
      builder: (context) => Handwriting(
        context:   context,
        onInit:    vm.handWrintingMessage,
        onDispose: vm.blackboardInstructions,
      )
    );

  }


  void handlePanUpdate(DragUpdateDetails details) {

    RenderBox _object  = context.findRenderObject();
    Offset _localPoint = _object.globalToLocal(details.globalPosition);

    final i = strokes.length - 1;
    setState(() => strokes[i].points.add(_localPoint) );

  }


  void handlePanStart(DragStartDetails detail) {

    final el = StrokeData(
      vm.preferences.lineColor,
      vm.preferences.lineWidth,
      []
    );

    setState(() => strokes.add(el));

  }


  void handlePanEnd(DragEndDetails detail) {

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.grey[100],

      floatingActionButton: ButtonValidation(
        onTap: () { 
          vm.onCompleteTraces();
          strokes.clear();
        }
      ),

      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[


          /// Blackboard
          GestureDetector(
            onPanStart:  handlePanStart,
            onPanUpdate: handlePanUpdate,
            onPanEnd:    handlePanEnd,
            // onPanCancel: () => _points.add(null),
            child: CustomPaint(
              size:    Size.infinite,
              painter: Blackboard(
                points: [],
                prefs:  vm.preferences,
                data:   strokes
              ),
            ),
          ),


          /// TopControlBar
          BlackboardTopControlBar( vm ),


          /// BottomControls
          BlackboardBottomControlBar(
            onTapIconClear: () => strokes.clear(),
            onTapIconReplay: showHandwritingModal,
          ),


          /// Stroke Size Selector
          vm.topControlBar.showStrokeSizeSelector == true 
            ? CustomPopUpMenu(
              onTapOutside: vm.toggleStrokeSizeSelector,
              position: Offset(10.0, 70.0),
              item: StrokeSizeSelector(
                min:      vm.configData.minLineWidth,
                max:      vm.configData.maxLineWidth,
                value:    vm.preferences.lineWidth,
                onChange: vm.changeStrokeSize,
                prefs:    vm.preferences,
              ),
            )
            : SizedBox(),


          /// Stroke Color Selector
          vm.topControlBar.showStrokeColorSelector ==  true
            ? CustomPopUpMenu(
              onTapOutside: vm.toggleStrokeColorSelector,
              position: Offset(50.0, 65.0),
              item: StrokeColorSelector(
                currentColor: vm.preferences.lineColor,
                colors:       vm.configData.colors,
                onSelect: vm.changeStrokeColor,
              ),
            )
            : SizedBox(),

/*           vm.showWellDoneDialog == true
            ? DialogWellDone(
              callBack: () => print('callback'),
              speak: () => print('speak'),
            )
            : SizedBox(),

 */
          vm.showHandWriting == true
            ? WellDoneNotification()
            : SizedBox(),

        ],
      ),

    );

  }


}


class ButtonValidation extends StatelessWidget {


  final Function() onTap;

  ButtonValidation({ Key key, @required this.onTap }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return FloatingActionButton(
      mini:            true,
      child:           Icon(Icons.check, color: Colors.white,),
      onPressed:       onTap,
      backgroundColor: Colors.green[600],
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );

  }


}


class WellDoneNotification extends StatefulWidget {

  final Duration duration;

  WellDoneNotification({
    Key key,
    this.duration = const Duration(milliseconds: 600)
  }) : super(key: key);

  @override
  _WellDoneNotificationState createState() => _WellDoneNotificationState();
}

class _WellDoneNotificationState extends State<WellDoneNotification> with SingleTickerProviderStateMixin {

  Duration get _duration => widget.duration;
  AnimationController controller;
  Animation<double> animation;
  double iconSize;

  @override
  void initState() {
    super.initState();
    iconSize = 60.0;
    Future.delayed(Duration(milliseconds: 0), show);

    controller = AnimationController(duration: _duration, vsync: this)
      ..addListener(() {
        print(animation.value);
        setState(() {  });

      });

    animation = Tween<double>(begin: -100, end: 10).chain(CurveTween(curve: Curves.bounceInOut)).animate(controller);
    animation = Tween<double>(begin: -100, end: 10).animate(controller);

    controller.forward();

  }

  void show() {
    showDialog(
      context: context,
      builder: (context) => buildWellDoneDialog(context)
    );
  }

  Widget buildWellDoneDialog(BuildContext context) {


    return AnimatedBuilder(
      animation: animation,
      builder: (_, child) => Container(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[


            Positioned(
              bottom: animation.value,
              height: 100.0,
              width: MediaQuery.of(context).size.width * 0.90,
              child: Container(
                decoration: BoxDecoration(

                  boxShadow: <BoxShadow>[
                    BoxShadow( color: Colors.black54, blurRadius: 10.0 )
                  ],


                  color: Colors.greenAccent[100],
                  borderRadius: BorderRadius.only(
                    bottomLeft:  Radius.circular(100.0),
                    topLeft:     Radius.circular(100.0),
                    bottomRight: Radius.circular(10.0),
                    topRight:    Radius.circular(10.0)
                  )

                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 100.0,
                      height: 100.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0)
                      ),
                      child: Container(

                        width:  iconSize + 2.0,
                        height: iconSize + 2.0,
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(100.0)
                        ),
                        child: Icon(
                          Icons.check_circle_outline,
                          color: Colors.greenAccent[700],
                          size: iconSize,
                        ),

                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: (100 - iconSize) /2 ),
                        alignment: Alignment.center,
                        child: Text(
                          'Bien Hecho',
                          maxLines:  1,
                          textAlign: TextAlign.center,
                          overflow:  TextOverflow.ellipsis,
                          style: TextStyle(

                            // color:      Colors.teal,
                            color:      Colors.greenAccent[700],
                            fontSize:   32.0,
                            fontFamily: 'Roboto',
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.bold,
                            shadows: <Shadow> [
                              // Shadow(color: Colors.yellow, blurRadius: 1.0)
                            ]

                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )


          ],
        ),
      ),
      child: SizedBox(),
    );


  }

  buildWellDoneAnimation() {}

  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }
}
