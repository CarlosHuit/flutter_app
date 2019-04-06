
import 'package:app19022019/core/src/redux/app/app_state.dart';
import 'package:app19022019/core/src/redux/reading_course/rc_draw_letters/rc_draw_letters_actions.dart';
import 'package:app19022019/core/src/services/speech_synthesis_service.dart';
import 'package:app19022019/core/src/viewmodels/reading_course/draw_letters_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import './draw_letters_content.dart';

class DrawLettersScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, DrawLettersViewModel>(

      distinct:  true,
      onInit:    (store) => store.dispatch(RCSetInitialDataDL()),
      converter: (store) => DrawLettersViewModel.fromStore(store),
      onDispose: (store) {
        store.dispatch(RCResetStateDL());
        SpeechSynthesisService.stop();
      },
      builder:   (_, vm) => DrawLettersContent(vm: vm),

    );
  }


}



