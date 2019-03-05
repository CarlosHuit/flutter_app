import './rc_letter_detail/rc_letter_detail_reducer.dart';
import './reading_course_state.dart';
import './rc_data/rc_data_reducer.dart';


ReadingCourseState readingCourseReducer(ReadingCourseState state, dynamic action) {

  return ReadingCourseState(
    data:         readingCourseDataReducer(state.data, action),
    letterDetail: readingCourseLetterDetailReducer(state, action),
  );

}