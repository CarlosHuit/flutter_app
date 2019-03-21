import 'package:app19022019/core/src/redux/app/app_state.dart';
import 'package:app19022019/core/src/redux/reading_course/rc_game/rc_game_actions.dart';
import 'package:app19022019/core/src/viewmodels/reading_course/game_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class GameScreen extends StatefulWidget {

  @override
  _GameScreenState createState() => _GameScreenState();

}

class _GameScreenState extends State<GameScreen> {


  @override
  Widget build(BuildContext context) {


    final columnWidth = 90.0;
    final width =MediaQuery.of(context).size.width;

    return StoreConnector<AppState, GameViewModel>(
      onInit: (store) => store.dispatch(RCSetInitialDataG()),
      converter: (store) => GameViewModel.fromStore(store),
      builder: (_, viewModel) {


        return Scaffold(
          body: Container(
            color: Colors.black87,
            child: Column(
              children: <Widget>[

                /*----- Game Bar -----*/
                Container(
                  color: Colors.blue,
                  height: 65.0,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
 
                      Positioned(
                        left:   0,
                        bottom: 0,
                        height: 5.0,
                        width:  width,
                        child:  ProgressBarIndicator( w: width, h: 5.0, p : 0 ),
                      ),
 
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                children: <Widget>[
                                  Counter(color: Colors.red, count: 1),
                                  Counter(color: Colors.green, count: 0),
                                ],
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Material(
                                type: MaterialType.transparency,
                                child: IconButton(
                                  tooltip: 'Ayuda',
                                  highlightColor: Colors.transparent,
                                  iconSize: 28.0,
                                  icon: Icon(Icons.visibility, color: Colors.white,),
                                  onPressed: () {},
                                ),
                              )
                            ),
                          ],
                        ),
                      ),
 
                    ],
                  ),
                ),

                /*----- Game Content -----*/
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          viewModel.currentData.data.length,
                          (i) => Column(
                            children: List.generate(
                              viewModel.currentData.data[i].length,
                              (el) => BlocExample(
                                letter: viewModel.currentData.data[i][el],
                                columnWidth: columnWidth,
                              )
                            ),
                          )
                        ),
                      ),

                    ),
                  ),
                )
              ],
            ),
          ),
        );

      },
    );


  }

}

class Counter extends StatelessWidget {

  final Color color;
  final int count;

  const Counter({
    Key key,
    @required this.color,
    @required this.count
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 3.0),
      height: 40.0,
      width: 40.0,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(width: 2.0, color: Colors.white),
        borderRadius: BorderRadius.circular(50)
      ),
      child: Text(
        '$count',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18.0
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}


class ProgressBarIndicator extends StatelessWidget {

  final double w;
  final double h;
  final double p;
  const ProgressBarIndicator({
    Key key,
    @required this.w,
    @required this.h,
    @required this.p,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 5.0),
      alignment: Alignment.bottomCenter,
      child: Container(
        height: h,
        width:  w,
        decoration: BoxDecoration(
          color: Colors.red[100],
          // borderRadius: BorderRadius.circular(10.0)
        ),
        child: Row(
          children: <Widget>[
            AnimatedContainer(
              duration: Duration(milliseconds: 800),
              width: w * p,
              decoration: BoxDecoration(
                color: Colors.red,
                // borderRadius: BorderRadius.circular(10.0)
              ),
            )
          ],
        ),
      ),
    );
  }

}





class BlocExample extends StatefulWidget {

  final String letter;
  final double columnWidth;

  const BlocExample({Key key, @required this.letter, @required this.columnWidth}) : super(key: key);

  @override
  _BlocExampleState createState() => _BlocExampleState();
}

class _BlocExampleState extends State<BlocExample> with SingleTickerProviderStateMixin {

  String get letter => widget.letter;
  double get columnWidth => widget.columnWidth;
  double height;
  bool showLetter;

  @override
  void initState() {

    super.initState();
    height = columnWidth;
    showLetter = true;

  }

  void hide() => setState(() {
    height = 0;
  });

  @override
  Widget build(BuildContext context) {


    return GestureDetector(
      onTap: hide,
      child: AnimatedContainer(
        width:    columnWidth,
        curve:    Curves.easeInCubic,
        height:   height,
        padding:  EdgeInsets.all(3.0),
        duration: Duration(milliseconds: 360),
        child: Container(
          width:  columnWidth,
          height: columnWidth,
          alignment:  Alignment.center,
          decoration: BoxDecoration(
             
            borderRadius: BorderRadius.circular(6.0),
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end:   Alignment.topLeft,
              colors: <Color> [
                Colors.deepOrange[500],
                Colors.deepOrange[400]
              ]
            )

          ),
          child: !showLetter ? SizedBox() : Text(
            letter,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 36.0
            ),
          ),
        ),
      ),
    );
  }
}



