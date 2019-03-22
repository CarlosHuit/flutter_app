
import 'package:app19022019/core/src/redux/reading_course/rc_game/rc_game_state.dart';
import 'package:app19022019/core/src/redux/reading_course/reading_course_state.dart';
import './rc_game_actions.dart';

RCGameState readingCourseGameReducer(ReadingCourseState state, dynamic action) {


  if (action is RCSetInitialDataG) {
    return RCGameState.fromStore(state);
  }

  if (action is RCRegisterCorrectSelectionG) {
    return state.game.copyWith(
      currentData: state.game.currentData.copyWith(
        countCorrects: state.game.currentData.countCorrects + 1,
        correctsValidation: state.game.currentData.correctsValidation - 1,
      )
    );
  }

  if (action is RCRegisterWrongSelectionG) {
    return state.game.copyWith(
      currentData: state.game.currentData.copyWith(
        countIncorrects: state.game.currentData.countIncorrects + 1
      )
    );
  }

  if (action is RCShowWellDoneDialog) {
    return state.game.copyWith(
      showWellDoneDialog: true
    );
  }

  return state.game;


}