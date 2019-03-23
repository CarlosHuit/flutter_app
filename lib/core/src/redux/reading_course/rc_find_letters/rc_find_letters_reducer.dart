
import '../../reading_course/reading_course_state.dart';
import './rc_find_letters_actions.dart';
import './rc_find_letters_state.dart';

RCFindLettersState readingCourseFindLettersReducer(ReadingCourseState state, dynamic action) {


  if (action is RCSetInitialDataFL) {
    return RCFindLettersState.fromStore(state);
  }


  return state.findLetters;


}