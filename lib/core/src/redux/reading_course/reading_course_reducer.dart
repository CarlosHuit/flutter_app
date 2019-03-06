import './rc_letter_detail/rc_letter_detail_reducer.dart';
import './rc_data/rc_data_reducer.dart';
import './reading_course_state.dart';


ReadingCourseState readingCourseReducer(ReadingCourseState state, dynamic action) {

  final d =  ReadingCourseState(
    letterDetail: readingCourseLetterDetailReducer(state, action),
    data:         readingCourseDataReducer(state.data, action),
  );


  return d;

}