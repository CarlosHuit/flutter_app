import 'package:app19022019/core/src/models/reading_course/rc_data_model.dart';

import './reading_course_actions.dart';
import './reading_course_state.dart';

ReadingCourseState readingCourseReducer(ReadingCourseState state, dynamic action) {


  if (action is RCFetchInitialData) {
    return state.copyWith( isLoading: true );
  }

  if (action is RCFetchInitialDataSuccess) {

    return state.copyWith(
      isLoading: false, data: RCCourseDataModel.fromData(action.data), currentLetter: null );

  }

  if (action is RCFetchInitialDataFailed) {

    return state.copyWith(isLoading: false);

  }

  return state;


}