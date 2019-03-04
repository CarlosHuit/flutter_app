import 'package:app19022019/core/src/redux/reading_course/rc_data/rc_data_actions.dart';

import './rc_data_state.dart';

RCDataState readingCourseDataReducer(RCDataState state, dynamic action) {


  if (action is RCFetchInitialData) {
    return state.copyWith( isLoading: true );
  }

  if (action is RCFetchInitialDataSuccess) {

    return RCDataState.fromData(action.data);
    // return state.copyWith(
    //   isLoading: false, data: RCDataState.fromData(action.data), currentLetter: null );

  }

  if (action is RCFetchInitialDataFailed) {
    return state.copyWith(isLoading: false);
  }

  return state;

}