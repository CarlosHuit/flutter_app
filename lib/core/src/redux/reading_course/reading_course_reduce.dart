import './reading_course_actions.dart';
import './reading_course_state.dart';

ReadingCourseState readingCourseReducer(ReadingCourseState state, dynamic action) {

  if (action is RCFetchInitialData) {
    return state.copyWith( isLoading: true );
  }

  if (action is RCFetchInitialDataSuccess) {
    print('ReadingCourseFetchDataSuccess');
    return state.copyWith(isLoading: false);
  }

  if (action is RCFetchInitialDataFailed) {
    return state.copyWith(isLoading: false);
  }

  return state;
}