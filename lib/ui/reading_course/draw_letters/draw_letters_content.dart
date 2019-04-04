import 'package:app19022019/core/src/viewmodels/reading_course/draw_letters_view_model.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';

import './blackboard.dart';
import './blackboard_controls/blackboard_bottom_control_bar.dart';
import './blackboard_controls/blackboard_top_control_bar.dart';
import './blackboard_controls/custom_pop_up_menu.dart';
import './blackboard_controls/stroke_color_selector.dart';
import './blackboard_controls/stroke_size_selector.dart';


class DrawLettersContent extends StatefulWidget {

  final DrawLettersViewModel vm;

  const DrawLettersContent({
    Key key,
    @required this.vm
  }) : super(key: key);

  @override
  _DrawLettersContentState createState() => _DrawLettersContentState();

}


class _DrawLettersContentState extends State<DrawLettersContent> {

  List<Offset> _points = <Offset>[];

  DrawLettersViewModel get vm => widget.vm;
  FlareControls flareControl;

  bool showHandWriting;

  @override
  void initState() {
    super.initState();
    flareControl = FlareControls();
    showHandWriting = true;

  }

  restart() {
    showHandwriting();
    flareControl.play('Untitled');
  }

  handlePanUpdate(DragUpdateDetails details) {
    setState(() {
      RenderBox object = context.findRenderObject();
      Offset _localPosition = object.globalToLocal(details.globalPosition);
      _points = List.from(_points)..add(_localPosition);
    });
  }

  hideHandWriting() {
    setState(() {
      showHandWriting = false;
    });
  }

  showHandwriting() {
    setState(() {
      showHandWriting = true;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: restart,
        backgroundColor: Colors.green[600],
        child: Icon(Icons.check, color: Colors.white,),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      body: Stack(
        children: <Widget>[


          Container(
            color: Colors.grey[100],
            child: Stack(
              children: <Widget>[


                /// HandWrinting animation
                // showHandWriting == true
                // ? Container(
                //   alignment: Alignment.center,
                //   child: FlareActor(
                //     'assets/alphabet/letter_R.flr',
                //     alignment: Alignment.center,
                //     // animation: 'draw',
                //     animation: 'Untitled',
                //     fit: BoxFit.fitWidth,
                //     color: Colors.blue,
                //     callback: (d) => hideHandWriting(),
                //     controller: flareControl,
                //   ),
                // ) : SizedBox(),


                Container(
                  alignment: Alignment.center,
                  child: FlareActor(
                    'assets/alphabet/letter_R.flr',
                    alignment: Alignment.center,
                    animation: 'Untitled',
                    fit: BoxFit.fitWidth,
                    color: Colors.blue,
                    callback: (d) => hideHandWriting(),
                    controller: flareControl,
                  ),
                ),

                /// Blackboard
                Container(
                  child: GestureDetector(
                    onPanUpdate: handlePanUpdate,
                    onPanEnd: (DragEndDetails details) => _points.add(null),
                    onPanCancel: () => _points.add(null),
                    child: CustomPaint(
                      painter: Blackboard(points: _points, prefs: vm.preferences),
                      size:    Size.infinite,
                    ),
                  ),
                ),


              ],
            ),
          ),


          /// TopControlBar
          BlackboardTopControlBar( vm ),


          /// BottomControls
          BlackboardBottomControlBar(
            onTapIconClear: () => _points.clear(),
            onTapIconReplay: () => print('replay'),
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
