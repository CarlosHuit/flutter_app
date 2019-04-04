import 'package:app19022019/core/src/viewmodels/reading_course/draw_letters_view_model.dart';
import 'package:app19022019/ui/components/custom_icon_button.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';

import './blackboard.dart';
import './blackboard_controls/blackboard_bottom_control_bar.dart';
import './blackboard_controls/blackboard_top_control_bar.dart';
import './blackboard_controls/custom_pop_up_menu.dart';
import './blackboard_controls/stroke_color_selector.dart';
import './blackboard_controls/stroke_size_selector.dart';

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
      floatingActionButton: FloatingActionButton(
        mini: true,
        child: Icon(Icons.check, color: Colors.white,),
        onPressed: () {},
        backgroundColor: Colors.green[600],
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      body: Stack(
        children: <Widget>[


          Container(
            color: Colors.grey[100],
            child: Stack(
              children: <Widget>[


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

class Handwriting extends StatefulWidget {

  @override
  _HandwritingState createState() => _HandwritingState();
}

class _HandwritingState extends State<Handwriting> {

  FlareControls flareControl;
  double positionY;
  bool pause;
  Duration animationDuration;

  Timer futureSub;

  @override
  void initState() {
    super.initState();
    animationDuration = Duration(seconds: 6);
    flareControl  =  FlareControls();
    positionY = 0;
    pause = false;
  }

  showModalH() {
    setState(() => positionY = 0 );
  }

  pauseAnimation() {
    setState(() => pause = true );
  }

  playAnimation() {
    setState(() => pause = false);
  }

  

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      // duration: Duration(milliseconds: 300),
      // transform: Matrix4.translationValues(0, positionY, 0),
      alignment: Alignment.center,
      child:    Container(
        constraints: BoxConstraints(

          minWidth:  300.0,
          maxWidth:  380.0,
          minHeight: 400.0,
          maxHeight: 480.0

        ),
        decoration: BoxDecoration(

          color:        Colors.white,
          borderRadius: BorderRadius.circular(4.0),
          boxShadow: [  BoxShadow(color: Colors.black54, blurRadius: 5.0)]

        ),
        width:  size.width  - 20.0,
        height: size.height - 20.0,
        child:  Column(
          children: <Widget>[

            Expanded(
              
              child:Container(
                alignment: Alignment.center,
                child: Container(
                  width:  300.0,
                  height: 300.0,
                  color:  Colors.black12,
                  child:  Stack(
                    fit:  StackFit.expand,
                    children: <Widget>[

                      Container(
                        child: CustomPaint(
                          painter: GuideLines(context),
                        ),
                      ),

                      Container(
                        alignment: Alignment.center,
                        child: FlareActor(
                          'assets/alphabet/letter_R.flr',
                          fit:       BoxFit.fitWidth,
                          color:     Colors.blue,
                          callback:  (s) => pauseAnimation(),
                          isPaused:  pause,
                          alignment: Alignment.center,
                          animation: 'Untitled',
                          controller: flareControl,
                        ),
                      )


                    ],
                  ),
                ),
              ),

            ),

            Container(
              height: 80,
              alignment: Alignment.center,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[

                  Positioned(
                    top: 10.0,
                    right: 10.0,
                    child: CustomIconButton(
                      height: 60.0,
                      width: 60.0,
                      splashColor: Colors.red[50],
                      icon: Icon(Icons.replay, color: Colors.red),
                      onTap: () {

                        if (futureSub != null) {

                          print('cancelFuture');
                          futureSub.cancel();
                          pauseAnimation();

                        }


                        playAnimation();
                        flareControl.play('Untitled');
                        setState(() => futureSub = Timer(animationDuration, pauseAnimation) );

                      },
                    ),
                  ),

                  Container(
                    alignment: Alignment.center,
                    child: RaisedButton(
                      child: Text(
                        'Siguiente',
                        style: TextStyle(
                          fontSize: 16.0
                        ),
                      ),
                      color: Colors.red,
                      padding: EdgeInsets.symmetric(horizontal: 35),
                      textColor: Colors.white,
                      onPressed: () => Navigator.pop(context),
                    ),

                  )


                ],
              ),
            )


          ],
        ),
      ),
    );

  }
}



class GuideLines extends CustomPainter {

  final BuildContext context;

  GuideLines(this.context);

  @override
  void paint(Canvas canvas, Size size) {
    print('repaiting');
    // print('s');
    // print('W: ${size.width} - H: ${size.height} - VW ${MediaQuery.of(context).size.width}');
    Paint paint = Paint()
      ..color = Colors.red[200]
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1.0;

    Path path = Path();
    path.moveTo(0, size.height * 0.05);
    path.lineTo(size.width, size.height * 0.05);

    path.moveTo(0, size.height* .35);
    path.lineTo(size.width, size.height * 0.35);

    path.moveTo(0, size.height * .65);
    path.lineTo(size.width, size.height * 0.65);

    path.moveTo(0, size.height * 0.95);
    path.lineTo(size.width, size.height * 0.95);

    canvas.drawPath(path, paint);

  }

  @override
  bool shouldRepaint(GuideLines oldDelegate) {
    return false;
  }

}

