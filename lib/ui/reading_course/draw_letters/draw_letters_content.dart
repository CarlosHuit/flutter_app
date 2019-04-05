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

import 'dart:async';


class DrawLettersContent extends StatefulWidget {

  final DrawLettersViewModel vm;

  DrawLettersContent({ Key key, @required this.vm }) : super(key: key);

  @override
  _DrawLettersContentState createState() => _DrawLettersContentState();

}


class _DrawLettersContentState extends State<DrawLettersContent> {

  DrawLettersViewModel get vm => widget.vm;

  StrokeData strokeData;
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
        onTap: () => print('validate stroke'),
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



