import 'package:app19022019/core/src/redux/reading_course/rc_select_words/rc_select_words_state.dart';
import 'package:app19022019/core/src/viewmodels/reading_course/select_words_view_model.dart';
import 'package:app19022019/ui/components/progress_bar_indicator.dart';
import 'package:app19022019/ui/components/well_done_dialog_app.dart';
import 'package:flutter/material.dart';

class SelectWordsContent extends StatefulWidget {

  final SelectWordsViewModel viewModel;

  const SelectWordsContent({
    Key key,
    @required this.viewModel
  }) : super(key: key);

  @override
  _SelectWordsContentState createState() => _SelectWordsContentState();
}

class _SelectWordsContentState extends State<SelectWordsContent> {

  PageController controller;
  SelectWordsViewModel get viewModel => widget.viewModel;

  @override
  void initState() {

    super.initState();
    controller = PageController();
    Future.delayed(
      Duration(milliseconds: 500),
      viewModel.speakInstructions
    );

  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  void didUpdateWidget(SelectWordsContent oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (viewModel.currentData.totalOfPending == 0) {
      Future.delayed(Duration(milliseconds: 800), viewModel.showWellDoneDialogApp);
    }

  }


  void next() {

    viewModel.hideWellDoneDialog();

    if (viewModel.currentIndex < viewModel.data.length - 1) {

      viewModel.changeCurrentData();

      controller.nextPage(
        duration: Duration(milliseconds: 750),
        curve: Curves.ease
      ).whenComplete(() {
        print(viewModel.currentData.type);
        viewModel.speakInstructions();
      });


    } else {
      viewModel.redirection();
    }


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: <Widget>[
          PageView(
            controller: controller,
            physics: NeverScrollableScrollPhysics(),
            children: List.generate(
              viewModel.data.length,
              (i) => SelectWordsPage(
                data: viewModel.data[i],
                vm: viewModel,
              )
            )
          ),
          

          viewModel.showWellDoneDialog
          ? WellDoneDialogApp(
            onEnd: next,
            onStart: viewModel.speakWellDone,
            durationToShow: Duration(seconds: 2),
          )
          : SizedBox()

        ],
      ),
    );


  }
}


class SelectWordsPage extends StatelessWidget {

  final RCSelectWordsData data;
  final SelectWordsViewModel vm;
  SelectWordsPage({
    Key key,
    @required this.data,
    @required this.vm
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: <Widget>[

        Positioned(
          height: 10.0,
          right:  00.0,
          left:   00.0,
          top:    25.0,
          child: ProgressBarIndicator(
            p:      vm.percentPendings,
            h:      10.0,
            w:      size.width * 0.90,
            radius: 50.0,
          ),
        ),

        Container(
          // color: Colors.red
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          alignment: Alignment.center,
          child: Wrap(
            alignment: WrapAlignment.center,
            children:  List.generate(
              data.words.length,
              (i) => SelectWordsButton(
                word:      data.words[i],
                letter:    data.letter,
                context:   context,
                onPressed: vm.onSelectWord,
              )
            ),
          ),
        ),
      ],
    );

  }

}


class SelectWordsButton extends StatefulWidget {

  final String word;
  final String letter;
  final BuildContext context;
  final Function(String word) onPressed;

  SelectWordsButton({
    Key key,
    @required this.word,
    @required this.letter,
    @required this.context,
    @required this.onPressed,
  }) : super(key: key);


  @override
  _SelectWordsButtonState createState() => _SelectWordsButtonState();

}

class _SelectWordsButtonState extends State<SelectWordsButton> {


  String get word => widget.word;
  String get letter => widget.letter;
  BuildContext get ctx => widget.context;
  Function(String word) get onPressed => widget.onPressed;

  MaterialColor color;
  MaterialColor successColor;
  MaterialColor wrongColor;
  bool hasBeenPressed;


  @override
  void initState() {

    super.initState();
    color = Theme.of(ctx).primaryColor;
    successColor = Colors.green;
    wrongColor = Colors.red;
    hasBeenPressed = false;

  }


  void onTap() {

    final bool isCorrect = word.contains(letter);

    if (isCorrect) {

      setState(() => color = successColor );

    } else {

      setState(() => color = wrongColor );

    }

    setState(() => hasBeenPressed = true );
    onPressed(word);

  }


  @override
  Widget build(BuildContext context) {

    final BorderRadius _radius = BorderRadius.circular(4.0);

    return Container(

      margin: EdgeInsets.only(

        top:    2.0,
        left:   3.0,
        right:  3.0,
        bottom: 10.0

      ),
      decoration: BoxDecoration(

        borderRadius: _radius,
        boxShadow: [
          BoxShadow( color: color[700], offset: Offset(0, 7) ),
          BoxShadow( color: color ),
        ]

      ),
      child: Material(

        color: color,
        borderRadius: _radius,
        child: InkWell(
          onTap:          !hasBeenPressed ? onTap : null,
          splashColor:    Colors.black12,
          borderRadius:   _radius,
          splashFactory:  InkRipple.splashFactory,
          highlightColor: Colors.transparent,
          child: Container(

            decoration: BoxDecoration(
              borderRadius: _radius,
            ),

            padding: EdgeInsets.symmetric(
              vertical:   7.0,
              horizontal: 20.0
            ),

            child: Text(
              word,
              style: TextStyle(
                color: Colors.white,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.80,
              ),
            ),

          ),

        ),

      ),
    );

  }


}