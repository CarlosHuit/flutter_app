import 'package:app19022019/core/src/viewmodels/reading_course/select_words_view_model.dart';
import 'package:app19022019/ui/components/well_done_dialog_app.dart';
import 'package:app19022019/ui/reading_course/select_words/select_words_page.dart';
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
      Future.delayed(
        Duration(milliseconds: 800),
        viewModel.showWellDoneDialogApp
      );
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

