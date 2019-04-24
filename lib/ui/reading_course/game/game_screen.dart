import 'package:app19022019/core/src/services/speech_synthesis_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:app19022019/core/src/redux/app/app_state.dart';
import 'package:app19022019/core/src/redux/reading_course/rc_game/rc_game_actions.dart';
import 'package:app19022019/core/src/viewmodels/reading_course/game_view_model.dart';
import './game_content.dart';


class GameScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return StoreConnector<AppState, GameViewModel>(
      onDispose: (store) => store.dispatch(RCResetDataG()),
      onInit:    (store) => store.dispatch(RCSetInitialDataG()),
      converter: (store) => GameViewModel.fromStore(store),
      builder:   (_, viewModel) {

        return WillPopScope(
          onWillPop: cancelTts,
          child: GameContent(viewModel: viewModel)
        );

      }

    );

  }

  Future<bool> cancelTts() async{
    SpeechSynthesisService.stop();
    return true;
  }  

}








