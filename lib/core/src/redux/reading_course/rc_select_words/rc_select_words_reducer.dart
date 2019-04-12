import '../../reading_course/reading_course_state.dart';
import './rc_select_words_state.dart';
import './rc_select_words_actions.dart';

RCSelectWordsState readingCourseSelectWordsReducer(ReadingCourseState state, dynamic action) {

  if (action is RCSetInitialDataSW) {
    return RCSelectWordsState.fromStore(state);
  }

  if (action is RCResetDataSW) {
    return RCSelectWordsState.initialState();
  }

  if (action is RCChangeCurrentDataSW) {

    final nextIndex = state.selectWords.currentIndex + 1;
    return  state.selectWords.copyWith(
      currentData: state.selectWords.data[nextIndex],
      currentIndex: nextIndex
    );

  }

  if (action is RCCorrectSelectionSW) {

    return state.selectWords.copyWith(
      currentData: state.selectWords.currentData.copyWith(
        totalOfPending: state.selectWords.currentData.totalOfPending - 1
      )
    );

  }

  if (action is RCShowWellDoneDialogSW) {
    return state.selectWords.copyWith(
      showWellDoneDialog: true
    );
  }

  if (action is RCHideWellDoneDialogSW) {
    return state.selectWords.copyWith(
      showWellDoneDialog: false
    );
  }

  return state.selectWords;

}