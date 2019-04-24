import 'package:app19022019/core/src/redux/app/app_state.dart';
import 'package:app19022019/core/src/redux/reading_course/rc_data/rc_data_actions.dart';
import 'package:app19022019/core/src/services/speech_synthesis_service.dart';
import 'package:app19022019/core/src/viewmodels/reading_course/reading_course_view_model.dart';
import 'package:app19022019/ui/reading_course/reading_course_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ReadingCourseScreen extends StatelessWidget {

  Future<bool> cancelTts() async {
    SpeechSynthesisService.stop();
    return true;
  }

  @override
  Widget build(BuildContext context) {

    return StoreConnector<AppState, ReadingCourseViewModel>(
      distinct: true,
      onInit:    (store) => store.dispatch( RCFetchInitialData() ),
      converter: (store) => ReadingCourseViewModel.fromStore(store: store),
      builder:   (_, viewModel) {
        return WillPopScope(
          onWillPop: cancelTts,
          child: ReadingCourseContent(viewModel: viewModel),
        );
      }
    );

  }

}

