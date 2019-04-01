import 'package:app19022019/core/src/viewmodels/reading_course/draw_letters_view_model.dart';
import 'package:app19022019/ui/components/custom_icon_button.dart';
import 'package:flutter/material.dart';
import './blackboard_controls/custom_pop_up_menu.dart';
import './blackboard_controls/stroke_color_selector.dart';
import './blackboard_controls/stroke_size_selector.dart';
import './handwriting.dart';
import './blackboard.dart';


class DrawLettersBody extends StatefulWidget {

  final DrawLettersViewModel vm;

  const DrawLettersBody({
    Key key,
    @required this.vm
  }) : super(key: key);

  @override
  _DrawLettersBodyState createState() => _DrawLettersBodyState();

}


class _DrawLettersBodyState extends State<DrawLettersBody> {

  List<Offset> _points = <Offset>[];
  double val;
  bool showStrokeSizeSelector;
  bool showStrokeColorSelector;
  bool showGuideLines;

  DrawLettersViewModel get vm => widget.vm;

  void showMenuI() {

    showMenu(
      context: context,
      items: [PopupMenuItem(child: Text('data'),)],
    );

  }


  @override
  void initState() {
    super.initState();
    val = 12.0;
    showStrokeSizeSelector = false;
    showStrokeColorSelector = false;
    showGuideLines = true;
  }


  void changeValue(double v) {
    setState(() {
      val = v;
    });
  }


  void toggleGuideLines() {
    setState(() {
      showGuideLines = !showGuideLines;
    });
  }


  void toggleStrokeSizeSelector() => setState(() {
    showStrokeSizeSelector = !showStrokeSizeSelector;
  });


  void toggleStrokeColorSelector() => setState(() {
    showStrokeColorSelector =!showStrokeColorSelector;
  });


  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(

      body: Stack(
        children: <Widget>[


          /// Background + Handwriting + Blackboard
          Container(
            child: Stack(
              children: <Widget>[


                /// Background
                Container(
                  color: Colors.grey[100],
                ),


                /// HandWrinting
                Container(
                  alignment: Alignment.center,
                  // color: Colors.red,
                  child: Container(
                    width: 300.0,
                    height: 300.0,
                    color: Colors.white,
                    child: CustomPaint(
                      painter: Handwriting(
                        vm.currrentData.coordinates,
                        vm.preferences
                      ),
                    ),
                  ),
                ),


                /// Blackboard
                Container(
                  // color: Colors.grey[100],
                  child: GestureDetector(
                    onPanUpdate: (DragUpdateDetails details) {
                      setState(() {
                        RenderBox object = context.findRenderObject();
                        Offset _localPosition = object.globalToLocal(details.globalPosition);
                        _points = List.from(_points)..add(_localPosition);
                      });
                    },
                    onPanEnd: (DragEndDetails details) => _points.add(null),
                    onPanCancel: () => _points.add(null),
                    child: CustomPaint(
                      painter: Blackboard(points: _points),
                      size:    Size.infinite,
                    ),
                  ),
                ),


              ],
            ),
          ),




          /// TopControlBar
          PositionedDirectional(
            start: 0,
            end:   0,
            top:   0,
            child: Container(
              height: 60.0,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: <BoxShadow> [
                  BoxShadow(color: Colors.black45, blurRadius: 3.0)
                ]
              ),
              child: Row(
                children: <Widget>[


                  /// FontSizeIcon
                  CustomIconButton(
                    icon: Icon(Icons.create, size: 28.0),
                    height: 50,
                    width: 50,
                    onTap: toggleStrokeSizeSelector,
                  ),


                  /// ColorsSelectorIcon
                  CustomIconButton(
                    icon: Icon(Icons.format_color_fill, size: 28.0,),
                    height: 50,
                    width: 50,
                    onTap: toggleStrokeColorSelector,
                  ),


                    /// ShowGuideLinesIcon
                  CustomIconButton(
                    height: 50.0,
                    width: 50.0,
                    icon: Icon(
                      showGuideLines == true
                        ? Icons.visibility
                        : Icons.visibility_off,
                        size: 28.0,
                    ),
                    onTap: toggleGuideLines,
                  ),


                ],
              ),
            ),
            
          ),


          /// BottomControls
          Positioned(
            bottom: 15.0,
            left: (size.width / 2) - 60,
            child: Container(
              width: 120.0,
              height: 45.0,
              decoration: BoxDecoration(
                color:        Colors.white,
                border:       Border.all(width: 0.8, color: Colors.black26),
                borderRadius: BorderRadius.circular(100.0),
                boxShadow: <BoxShadow>[
                  BoxShadow( color: Colors.black26, blurRadius: 6.0, offset: Offset(0, 3) )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[


                  CustomIconButton(
                    width: 45.0,
                    height: 45.0,
                    icon: Icon(Icons.replay, color: Colors.red),
                    onTap: () => print('icon replay onTap'),
                    splashColor: Colors.red[50],
                  ),


                  CustomIconButton(
                    width: 45.0,
                    height: 45.0,
                    icon: Icon(Icons.clear, color: Colors.red),
                    onTap: () => _points.clear(),
                    splashColor: Colors.red[50],
                  ),


                ],
              ),
            ), 
          ),


          /// Stroke Size Selector
          showStrokeSizeSelector == true 
            ? CustomPopUpMenu(
              onTapOutside: toggleStrokeSizeSelector,
              position: Offset(10.0, 70.0),
              item: StrokeSizeSelector(
                min:      6.0,
                max:      18.0,
                value:    val,
                onChange: changeValue,
              ),
            )
            : SizedBox(),


          /// Stroke Color Selector
          showStrokeColorSelector == true
            ? CustomPopUpMenu(
              onTapOutside: toggleStrokeColorSelector,
              position: Offset(50.0, 65.0),
              item: StrokeColorSelector(
                currentColor: Colors.blue,
                colors: [
                  Colors.red,
                  Colors.blue,
                  Colors.deepOrange,
                  Colors.pink,
                  Colors.yellow,
                  Colors.green,
                  Colors.orange,
                  Colors.purple,
                  Colors.indigo,
                  Colors.black
                ],
                onSelect: (Color color) => print('Color selected is ${color.value}'),
              ),
            )
            : SizedBox(),


        ],
      ),

    );

  }




}
