import './rc_draw_letters_state.dart';
import '../reading_course_state.dart';
import './rc_draw_letters_actions.dart';

RCDrawLettersState readingCourseDrawLettersReducer(ReadingCourseState state, dynamic action) {


  if (action is RCSetInitialDataDL) {
    return RCDrawLettersState.fromStateData(state);
  }

  if (action is RCResetStateDL) {
    return RCDrawLettersState.initialState();
  }


  return state.drawLetters;

}

