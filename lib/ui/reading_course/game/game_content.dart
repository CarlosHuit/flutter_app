import 'dart:async';

import 'package:app19022019/core/src/redux/reading_course/rc_game/rc_game_state.dart';
import 'package:app19022019/core/src/viewmodels/reading_course/game_view_model.dart';
import 'package:app19022019/ui/components/custom_circular_icon_button.dart';
import 'package:app19022019/ui/components/dialog_well_done.dart';
import 'package:app19022019/ui/components/progress_bar_indicator.dart';
import 'package:app19022019/utils/my_behavior.dart';
import './block.dart';
import './counter.dart';
import 'package:flutter/material.dart';

class GameContent extends StatefulWidget {
  final GameViewModel viewModel;

  const GameContent({Key key, this.viewModel}) : super(key: key);

  @override
  _GameContentState createState() => _GameContentState();
}

class _GameContentState extends State<GameContent> {

  PageController pageController;
  Timer timerHideConincidences;

  GameViewModel get viewModel => widget.viewModel;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    viewModel.showAllCoincidences();
    schedulehidingAllCoincidences();
    
  }


  @override
  void dispose() {
    cancelSchedulehidingAllCoincidences();
    pageController.dispose();
    super.dispose();
  }


  void nextPage() async{

    if (pageController.page < 1) {
      cancelSchedulehidingAllCoincidences();
      await pageController.nextPage(
        duration: Duration(milliseconds: 800),
        curve: Curves.decelerate
      );

      showAllCoincidences();

    }

  }


  /// [ void ] Dispatch action to show all matches for 3 seconds.
  /// This method Schedule the dispatching a action to hide all matches after three seconds
  void showAllCoincidences() {

    if (viewModel.currentData.opportunities >= 0) {

      cancelSchedulehidingAllCoincidences();
      viewModel.showAllCoincidences();
      schedulehidingAllCoincidences();      

    }

  }


  /// if exist `timerHideConincidences` promises -> cancel timer
  void cancelSchedulehidingAllCoincidences() {

    if (timerHideConincidences != null) {
      timerHideConincidences.cancel();
    }

  }


  /// schedule dispatching action to hide all matches
  void schedulehidingAllCoincidences() {

    setState(() {
      timerHideConincidences = Timer(
        Duration(milliseconds: 3000),
        viewModel.hideAllCoincidences
      );
    });

  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Stack(
        children: <Widget>[

          Container(
            child: Column(
              children: [
                gameBar(),
                gameContent()
              ],
            ),
          ),

          viewModel.showWellDoneDialog == false
            ? SizedBox()
            : DialogWellDone(
              speak: viewModel.speakWellDoneMsg,
              callBack: () {
                viewModel.hideDialogWD();
                Future.delayed(Duration(milliseconds: 100), nextPage );
              },
            )


        ],
      )
    );

  }


  Widget gameBar() {

    final width = MediaQuery.of(context).size.width;

    return Container(
      height: 60.0,

      child: Column(
        children: <Widget>[


          Expanded(
            child: Container(
              color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[


                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: <Widget>[
                        Counter(color: Colors.red, count: viewModel.countIncorrects),
                        Counter(color: Colors.green, count: viewModel.countCorrects),
                      ],
                    ),
                  ),


                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    child:  viewModel.currentData.opportunities >= 0
                    ? CustomCircularIconButton(
                      icon: Icon(
                        Icons.visibility,
                        color: Colors.white,
                        size: 28.0,
                      ),
                      onTap: showAllCoincidences,
                      splashColor: Colors.white24,
                      height: 48.0,
                      width: 48.0,
                    )
                    : Offstage(),
                  )


                ],
              ),
            )
          ),


          Container(
            height: 5.0,
            color: Colors.red,
            child: ProgressBarIndicator(
              w: width,
              h: 5.0,
              p: viewModel.percentPendings,
            ),
          )


        ],
      ),
    );

  }


  Widget gameContent() {

    return Expanded(
      child: ScrollConfiguration(
        behavior: MyBehavior(),
        child: PageView.builder(
          itemCount: viewModel.data.length,
          controller: pageController,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (_, i) => PageGame(
            data:      viewModel.data[i],
            viewModel: viewModel,
          ),
        ),
      ),
    );

  }


}

class PageGame extends StatelessWidget {

  final GameViewModel viewModel;
  final RCGameData data;
  final double columnWidth;

  const PageGame({
    Key key,
    @required this.viewModel,
    @required this.data,
    this.columnWidth = 90.0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Container(
      color: Colors.black87,
      child: Stack(
        children: <Widget>[


          Container(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child:   Container(
              child: SingleChildScrollView(

                physics: BouncingScrollPhysics(),
                child: Row(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
                  children: List.generate( data.data.length, generateColumns ),

                ),
              )


            ),
          ),

        ],
      ),
    );


  }

  Widget generateColumns(int i) {

    return Column(
      children: List.generate(
        data.data[i].length,
        (el) => Block(
          index:   el,
          letter:  data.data[i][el],
          callBack:  viewModel.selectOption,
          highlight:   viewModel.showCorrectLetters,
          columnWidth:   columnWidth,
          correctLetter:   viewModel.currentData.letter

        )
      ),
    );

  }


}

