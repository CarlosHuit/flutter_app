
import 'package:app19022019/core/src/redux/app/app_state.dart';
import 'package:app19022019/core/src/redux/reading_course/rc_draw_letters/rc_draw_letters_actions.dart';
import 'package:app19022019/core/src/redux/reading_course/rc_draw_letters/rc_draw_letters_state.dart';
import 'package:app19022019/core/src/viewmodels/reading_course/draw_letters_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';


class DrawLettersScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, DrawLettersViewModel>(

      distinct:  true,
      onInit:    (store) => store.dispatch(RCSetInitialDataDL()),
      onDispose: (store) => store.dispatch(RCResetStateDL()),
      converter: (store) => DrawLettersViewModel.fromStore(store),
      builder:   (_, vm) => DrawLettersBody(vm: vm),

    );
  }


}




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


          Container(
            child: Stack(
              children: <Widget>[

                /* BackGround */
                Container(
                  color: Colors.grey[100],
                ),

                /// handWriting
                Container(
                  // color: Colors.red,
                  child: CustomPaint(
                    size: Size.infinite,
                    painter: Handwriting(
                      vm.currrentData.coordinates,
                      vm.preferences
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
                      painter: Signature(points: _points),
                      size:    Size.infinite,
                    ),
                  ),
                ),

              ],
            ),
          ),

          /// Blackboard



          /// TopControls
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



class MyCurve extends CustomPainter {


  final points = [
    [
      Offset(90.0, 20.0),
      Offset(10.0, 20.0),
      Offset(90.0, 20.0),
    ],

  ];


  Offset calcControlPoint(List<Offset> el, int a, int b) {

    Offset pc = Offset(
      (el[a].dx + el[b].dx) / 2,
      (el[a].dy + el[b].dy) / 2,
    );
    return pc;

  }



  @override
  void paint(Canvas canvas, Size size) {

    Paint paint   = Paint()
    ..strokeWidth = 3.0
    ..color     = Colors.red
    ..style     = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;

    Path path = Path();

    for (var n = 0; n < points.length; n++) {

      final pointsGroup = points[n];

      var prevX = pointsGroup[0].dx;
      var prevY = pointsGroup[0].dy;

      for (var i = 0; i < pointsGroup.length - 1; i++) {

        final pc = calcControlPoint(pointsGroup, i, i + 1);

        // path.moveTo(prevX, prevY);
        // path.addOval(Rect.fromCircle(radius: 10, center: Offset(50, 120)));
        // path.quadraticBezierTo(
        //   pointsGroup[i].dx,
        //   pointsGroup[i].dy,
        //   pc.dx,
        //   pc.dy
        // );

        // path.close();

        canvas.drawPath(path, paint);
        prevX = pc.dx;
        prevY = pc.dy;

      }

    }


  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
  
}


class Handwriting extends CustomPainter {

  final List<List<Offset>> coordinates;
  final RCDrawLetterPreferences prefs;

  Handwriting(this.coordinates, this.prefs);

  Offset calcControlPoint(List<Offset> el, int a, int b) {

    Offset pc = Offset(
      (el[a].dx + el[b].dx / 2),
      (el[a].dy + el[b].dy / 2)
    );
    return pc;

  }

  @override
  void paint(Canvas canvas, Size size) {

    Paint paint   = Paint()
    ..strokeWidth = 3.0
    ..color     = Colors.red
    ..style     = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;

    Path path = Path();
    for (var n = 0; n < coordinates.length; n++) {

      final pointsGroup = coordinates[n];
      double prevX = pointsGroup[0].dx;
      double prevY = pointsGroup[0].dy;

      for (var i = 0; i < pointsGroup.length - 1; i++) {
        final pc = calcControlPoint(pointsGroup, i, i + 1);
        // path.moveTo(prevX, prevY);
        // path.quadraticBezierTo(
        //   pointsGroup[i].dx,
        //   pointsGroup[i].dy,
        //   pc.dx,
        //   pc.dy
        // );
        // canvas.drawPath(path, paint);
        canvas.drawLine(pointsGroup[i], pointsGroup[i + 1], paint);
        prevX = pc.dx;
        prevY = pc.dy;
      }

    }

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {

    return false;
  }


}

class Signature extends CustomPainter {
  List<Offset> points;

  Signature({this.points});

  @override
  void paint(Canvas canvas, Size size) {

    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }

  }

  @override
  bool shouldRepaint(Signature oldDelegate) {
    return oldDelegate.points != points;
  }
}



class CustomIconButton extends StatelessWidget {

  final double width;
  final double height;
  final Icon icon;
  final Color splashColor;
  final Color highlightColor;
  final Color color;
  final Function() onTap;

  const CustomIconButton({
    Key key,
    @required this.width,
    @required this.height,
    @required this.onTap,
    @required this.icon,
    this.color = Colors.transparent,
    this.splashColor = Colors.black12,
    this.highlightColor = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Material(
      color: color,
      borderRadius: BorderRadius.circular(100.0),
      child: InkWell(
        splashColor: splashColor,
        borderRadius: BorderRadius.circular(100.0),
        splashFactory: InkRipple.splashFactory,
        onTap: onTap,
        highlightColor: highlightColor,
        child: Container(
          width: width,
          height: height,
          child: icon,
        ),
      ),
    );

  }
}



class CustomPopUpMenu extends StatefulWidget {

  final Offset position;
  final Widget item;
  final Function() onTapOutside;

  const CustomPopUpMenu({
    Key key,
    @required this.item,
    @required this.position,
    @required this.onTapOutside
  }) : super(key: key);

  @override
  _CustomPopUpMenuState createState() => _CustomPopUpMenuState();

}



class _CustomPopUpMenuState extends State<CustomPopUpMenu> with SingleTickerProviderStateMixin {

  Widget get item => widget.item;
  Offset get pos => widget.position;
  Function() get onTapOutside => widget.onTapOutside;

  bool show = false;
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration( milliseconds: 200 )
    );

    animation = Tween<double>(begin: 0.0, end: 1.0)
    .animate(controller)
    ..addListener(() => setState(() { }) );

    controller.forward();

  }

  @override
  void dispose() {

    super.dispose();
    controller.dispose();

  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(

      onTap: () {

        controller.reverse();
        Future.delayed(
          Duration(milliseconds: 250),
          onTapOutside
        );

      },

      child: Opacity(
        opacity: animation.value,
        child: Container(

          color: Colors.transparent,
          child: Stack(
            children: <Widget>[

              Positioned(
                top:  pos.dy,
                left: pos.dx,
                child: GestureDetector(
                  onTap: () {},
                  child: item
                ),
              )

            ],
          ),

        ),
      ),

    );

  }


}



class StrokeSizeSelector extends StatefulWidget {

  final double value;
  final Function(double val) onChange;
  final double min;
  final double max;

  const StrokeSizeSelector({
    Key key,
    @required this.value,
    @required this.onChange,
    @required this.min,
    @required this.max
  }) : super(key: key);

  @override
  _StrokeSizeSelectorState createState() => _StrokeSizeSelectorState();
}



class _StrokeSizeSelectorState extends State<StrokeSizeSelector> {

  double get value => widget.value;
  Function(double val) get cb => widget.onChange;
  double get min => widget.min;
  double get max => widget.max;

  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 0,
      margin: EdgeInsets.all(0),
      child: Container(
        height: 100.0,
        width: 220.0,
        decoration: BoxDecoration(
          color: Colors.white,
          // border: Border.all(width: 1.3, color: Colors.grey[300]),
          borderRadius: BorderRadius.circular(4.0),
          boxShadow: <BoxShadow> [
            BoxShadow(color: Colors.black45, blurRadius: 10)
          ]
        ),
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
        child: Column(
          children: <Widget>[


            Container(
              height: 40.0,
              child: Slider(
                value: value,
                min: min,

                max: max,
                inactiveColor: Colors.blue[200],
                onChanged: cb,
                label: value.toString(),
                divisions: 12,
              ),
            ),


            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Container(
                  height: value,
                  margin: EdgeInsets.symmetric(horizontal: 15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              )
            )


          ],
        ),
      ),
    );

  }
}



class StrokeColorSelector extends StatelessWidget {

  final List<Color> colors;
  final Color currentColor;
  final Function(Color color) onSelect;

  const StrokeColorSelector({
    Key key,
    @required this.colors,
    @required this.currentColor,
    @required this.onSelect
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size =MediaQuery.of(context).size;

    return Card(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: size.width - 80.0
        ),
        margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
        child: Wrap(
          children: List.generate(colors.length, (i) => GestureDetector(
            onTap: () => onSelect(colors[i]),
            child: Container(
              width: 35.0,
              height: 35.0,
              margin: EdgeInsets.symmetric(horizontal: 3.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: colors[i],
                borderRadius: BorderRadius.circular(50.0),
                border: Border.all(width: 0.8, color: Colors.grey[300])
              ),
              child: colors[i] == currentColor
                ? Icon(Icons.done, color: Colors.white)
                : SizedBox(),
            ),

          )),

        ),
      ),
    );
  }

}

