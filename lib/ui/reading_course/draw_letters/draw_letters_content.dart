import 'package:app19022019/core/src/redux/reading_course/rc_draw_letters/rc_draw_letters_state.dart';
import 'package:app19022019/core/src/viewmodels/reading_course/draw_letters_view_model.dart';
import 'package:app19022019/ui/components/well_done_dialog_app.dart';
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

  DrawLettersContent({
    Key key,
    @required this.vm
  }) : super(key: key);

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


  void validateTraces() {
    vm.validateTraces();
    strokes.clear();
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(

      backgroundColor: Colors.grey[100],

      floatingActionButton: ButtonValidation( onTap: validateTraces ),

      body: Stack(

        alignment: Alignment.center,
        children: <Widget>[


          /// Blackboard
          GestureDetector(
            onPanStart:  handlePanStart,
            onPanUpdate: handlePanUpdate,
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
            onTapIconClear:  () => strokes.clear(),
            onTapIconReplay: vm.showHandwriting,
          ),


          /// Stroke Size Selector
          vm.topControlBar.showStrokeSizeSelector == true 
            ? CustomPopUpMenu(
              onTapOutside: vm.toggleStrokeSizeSelector,
              position:     Offset(10.0, 70.0),
              item:         StrokeSizeSelector(
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


          /// Handwriting
          vm.showHandWriting == true
            ? ModalHandwriting(
              context:          context,
              direction:        Axis.horizontal,
              onHide:           vm.hideHandwriting,
              speechAtTheStart: vm.handWrintingMessage,
              speechAtTheEnd:   vm.blackboardInstructions,
              curve: Curves.linearToEaseOut,
              useAnimation: false,
            )
            : SizedBox(),


          /// WellDoneDialog
          vm.showWellDoneDialog == true
            ? WellDoneDialogApp(
              onStart: vm.speakOnWellDone,
              onEnd:   vm.onHideWellDoneDialog,
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
      mini:                  true,
      onPressed:             onTap,
      backgroundColor:       Colors.green[600],
      child:                 Icon(Icons.check, color: Colors.white),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );

  }


}


