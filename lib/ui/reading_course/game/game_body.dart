import 'package:app19022019/core/src/viewmodels/reading_course/game_view_model.dart';
import './block.dart';
import './progress_bar_indicator.dart';
import './counter.dart';
import 'package:flutter/material.dart';

class GameBody extends StatelessWidget {

  final GameViewModel viewModel;

  const GameBody({Key key, this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final columnWidth = 90.0;

    return Scaffold(
      body: Container(
        color: Colors.black87,
        child: Column(
          children: <Widget>[

            /*----- Game Bar -----*/

            Container(
              color: Colors.blue,
              height: 65,
              child: Column(
                children: <Widget>[


                  Expanded(
                    child: Container(
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
                  ),


                  Container(
                    height: 5.0,
                    alignment: Alignment.bottomLeft,
                    child: ProgressBarIndicator(
                      w: width,
                      h: 5.0,
                      p: 0.10,
                    ),

                  )


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
                    mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      viewModel.currentData.data.length,
                      (i) => Column(
                        children: List.generate(
                          viewModel.currentData.data[i].length,
                          (el) => Block(
                            letter: viewModel.currentData.data[i][el],
                            columnWidth: columnWidth,
                            correctLetter: viewModel.currentData.letter,
                            callBack:  viewModel.selectOption,
                            highlight: viewModel.showCorrectLetters,
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
  }
}