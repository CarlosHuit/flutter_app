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

  return state.selectWords;

}