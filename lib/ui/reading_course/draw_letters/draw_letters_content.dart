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

  List<Offset> _points = <Offset>[];

  DrawLettersViewModel get vm => widget.vm;



  @override
  void initState() {

    super.initState();
    Future.delayed( Duration.zero, showHandwritingModal );

  }

  void showHandwritingModal() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Handwriting()
    );

  }

  handlePanUpdate(DragUpdateDetails details) {

    setState(() {
      RenderBox object = context.findRenderObject();
      Offset _localPosition = object.globalToLocal(details.globalPosition);
      _points = List.from(_points)..add(_localPosition);
    });

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[100],
      floatingActionButton: FloatingActionButton(
        mini: true,
        child: Icon(Icons.check, color: Colors.white,),
        onPressed: () {},
        backgroundColor: Colors.green[600],
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      body: Stack(
        children: <Widget>[


          /// Blackboard
          GestureDetector(
            onPanUpdate: handlePanUpdate,
            onPanEnd: (DragEndDetails details) => _points.add(null),
            onPanCancel: () => _points.add(null),
            child: CustomPaint(
              painter: Blackboard(points: _points, prefs: vm.preferences),
              size:    Size.infinite,
            ),
          ),

          /// TopControlBar
          BlackboardTopControlBar( vm ),


          /// BottomControls
          BlackboardBottomControlBar(
            onTapIconClear: () => _points.clear(),
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
                onChange: vm.changeStrokeSize
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

