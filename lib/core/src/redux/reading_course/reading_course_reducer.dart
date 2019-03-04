import './reading_course_state.dart';
import './rc_data/rc_data_reducer.dart';

ReadingCourseState readingCourseReducer(ReadingCourseState state, dynamic action) {


  // if (action is RCFetchInitialData) {
  //   return state.copyWith( isLoading: true );
  // }

  // if (action is RCFetchInitialDataSuccess) {

  //   return state.copyWith(
  //     isLoading: false, data: RCDataState.fromData(action.data), currentLetter: null );

  // }

  // if (action is RCFetchInitialDataFailed) {

  //   return state.copyWith(isLoading: false);

  // }

  // return state;

  return ReadingCourseState(
    data:          readingCourseDataReducer(state.data, action)
  );

}