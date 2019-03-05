import '../reading_course_state.dart';
import './rc_letter_detail_actions.dart';
import './rc_letter_detail_state.dart';

RCLetterDetail readingCourseLetterDetailReducer(ReadingCourseState state, dynamic action) {

  if (action is RCSetInitialDataLD) {
    print('Letter Detail: Set Initial Data of letter ${action.letter}');
    return state.letterDetail.fromStore(state);
  }

  return state.letterDetail;

}