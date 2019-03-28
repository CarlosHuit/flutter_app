import './rc_find_letters/rc_find_letters_reducer.dart';
import './rc_letter_detail/rc_letter_detail_reducer.dart';
import './rc_game/rc_game_reducer.dart';
import './rc_data/rc_data_reducer.dart';
import './reading_course_state.dart';



ReadingCourseState readingCourseReducer(ReadingCourseState state, dynamic action) {

  return ReadingCourseState(
    game:         readingCourseGameReducer(state, action),
    data:         readingCourseDataReducer(state.data, action),
    findLetters:  readingCourseFindLettersReducer(state, action),
    letterDetail: readingCourseLetterDetailReducer(state, action),
  );

}