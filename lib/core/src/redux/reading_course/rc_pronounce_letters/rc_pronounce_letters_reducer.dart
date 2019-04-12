import './rc_pronounce_letters_state.dart';
import '../reading_course_state.dart';
import './rc_pronounce_letters_actions.dart';

RCPronounceLettersState readingCoursePronounceLettersReducer(ReadingCourseState state, dynamic action) {

  if (action is RCSetInitialDataPL) {
    return RCPronounceLettersState.fromStore(state);
  }

  if (action is RCResetDataPL) {
    return RCPronounceLettersState.initialState();
  }

  return state.pronounceLetters;

}
