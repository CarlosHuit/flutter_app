import '../rc_data/rc_data_actions.dart';
import './rc_data_state.dart';

RCDataState readingCourseDataReducer(RCDataState state, dynamic action) {


  if (action is RCFetchInitialData) {
    return state.copyWith( isLoading: true );
  }


  if (action is RCFetchInitialDataSuccess) {
    return RCDataState.fromData(action.data);
  }


  if (action is RCFetchInitialDataFailed) {
    return state.copyWith(isLoading: false);
  }

  if (action is RCSetCurrentLetter) {
    return state.copyWith( currentLetter: action.letter );
  }

  return state;

}