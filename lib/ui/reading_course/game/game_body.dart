import 'package:app19022019/core/src/redux/reading_course/rc_game/rc_game_state.dart';
import 'package:app19022019/core/src/viewmodels/reading_course/game_view_model.dart';
import 'package:app19022019/ui/components/dialog_well_done.dart';
import 'package:app19022019/ui/components/progress_bar_indicator.dart';
import 'package:app19022019/utils/my_behavior.dart';
import './block.dart';
import './counter.dart';
import 'package:flutter/material.dart';

class GameBody extends StatefulWidget {
  final GameViewModel viewModel;

  const GameBody({Key key, this.viewModel}) : super(key: key);

  @override
  _GameBodyState createState() => _GameBodyState();
}

class _GameBodyState extends State<GameBody> {
  PageController pageController;

  GameViewModel get viewModel => widget.viewModel;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    viewModel.showAllCoincidences();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void nextPage() async{
    if (pageController.page < 1) {

      await pageController.nextPage(
        duration: Duration(milliseconds: 800),
        curve: Curves.decelerate
      );
      viewModel.showAllCoincidences();
    }
  }

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.square(61),
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
      ),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: PageView.builder(
          controller: pageController,
          itemCount: viewModel.data.length,
          itemBuilder: (_, i) => PageGame(
            data: viewModel.data[i],
            viewModel: viewModel,
            cb: nextPage,
          )
        ),
      )
    );
  }
}

class PageGame extends StatelessWidget {

  final GameViewModel viewModel;
  final RCGameData data;
  final Function() cb;

  const PageGame({
    Key key,
    @required this.viewModel,
    @required this.data,
    @required this.cb
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final columnWidth = 90.0;

    return Container(
      color: Colors.black87,
      child: Stack(
        children: <Widget>[


          Container(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: Container(
              child: SingleChildScrollView(

                physics: BouncingScrollPhysics(),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    data.data.length,
                    (i) => Column(
                      children: List.generate(
                        data.data[i].length,
                        (el) => Block(
                          letter:  data.data[i][el],
                          callBack:  viewModel.selectOption,
                          highlight:   viewModel.showCorrectLetters,
                          columnWidth:   columnWidth,
                          correctLetter:   viewModel.currentData.letter
                        )
                      ),
                    )
                  ),

                ),
              )


            ),
          ),

          viewModel.showWellDoneDialog == false
            ? SizedBox()
            : DialogWellDone(
              speak: viewModel.speakWellDoneMsg,
              callBack: () {
                viewModel.hideDialogWD();
                Future.delayed(Duration(milliseconds: 100), cb );
              },
            )


        ],
      ),
    );
  }
}

