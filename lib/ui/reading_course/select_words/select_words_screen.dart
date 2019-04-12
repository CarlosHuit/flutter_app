import 'package:app19022019/core/src/redux/app/app_state.dart';
import 'package:app19022019/core/src/redux/reading_course/rc_select_words/rc_select_words_actions.dart';
import 'package:app19022019/core/src/services/speech_synthesis_service.dart';
import 'package:app19022019/core/src/viewmodels/reading_course/select_words_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import './select_words_content.dart';

class SelectWordsScreen extends StatefulWidget {
  @override
  _SelectWordsScreenState createState() => _SelectWordsScreenState();
}

class _SelectWordsScreenState extends State<SelectWordsScreen> {
  @override
  Widget build(BuildContext context) {

    return StoreConnector<AppState, SelectWordsViewModel>(
      distinct:  true,
      converter: (store) => SelectWordsViewModel.fromStore(store),
      onInit:    (store) => store.dispatch(RCSetInitialDataSW()),
      onDispose: (store) {
        store.dispatch(RCResetDataSW());
        SpeechSynthesisService.stop();
      },
      builder:   (_, vm) => SelectWordsContent(viewModel: vm)

    );

  }
}