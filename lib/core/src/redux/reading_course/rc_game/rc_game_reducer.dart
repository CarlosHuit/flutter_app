
import 'package:app19022019/core/src/redux/app/app_state.dart';
import 'package:app19022019/core/src/redux/reading_course/rc_game/rc_game_state.dart';
import './rc_game_actions.dart';

RCGameState readingCourseGameReducer(AppState store, dynamic action) {

  final state = store.readingCourseState;

  if (action is RCSetInitialDataG) {
    return RCGameState.fromStore(store.readingCourseState, store.deviceState);
  }

  if (action is RCResetDataG) {
    return RCGameState.initialState();
  }

  if (action is RCRegisterCorrectSelectionG) {
    return state.game.copyWith(
      currentData: state.game.currentData.copyWith(
        countCorrects:      state.game.currentData.countCorrects + 1,
        correctsValidation: state.game.currentData.correctsValidation - 1,
      )
    );
  }

  if (action is RCRegisterWrongSelectionG) {

    return state.game.copyWith(
      currentData:       state.game.currentData.copyWith(
        countIncorrects: state.game.currentData.countIncorrects + 1
      )
    );

  }

  if (action is RCShowWellDoneDialogG) {
    return state.game.copyWith(
      showWellDoneDialog: true
    );
  }

  if (action is RCHideWellDoneDialogG) {
    return state.game.copyWith(
      showWellDoneDialog: false
    );
  }

  if (action is RCChangeCurrentDataG) {
    final nextIndex = state.game.currentIndex + 1;
    return state.game.copyWith(
      currentData: state.game.data[nextIndex],
      currentIndex: nextIndex
    );
  }

  if (action is RCShowCoincidencesG) {
    return state.game.copyWith(
      showCoincidences: true,
      showCorrectLetters: true
    );
  }

  if (action is RCHideCoincidencesG) {
    return state.game.copyWith(
      showCoincidences: false,
      showCorrectLetters: false,
    );
  }

  return state.game;


}