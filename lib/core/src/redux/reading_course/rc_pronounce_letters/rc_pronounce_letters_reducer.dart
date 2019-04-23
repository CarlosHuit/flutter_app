import './rc_pronounce_letters_state.dart';
import '../reading_course_state.dart';
import './rc_pronounce_letters_actions.dart';

RCPronounceLettersState readingCoursePronounceLettersReducer(ReadingCourseState state, dynamic action) {

  if (action is RCSetInitialDataPL) {
    return RCPronounceLettersState.fromStore(state);
  }

  if (action is RCResetDataPL) {
    return RCPronounceLettersState.initialState();
  }

  if (action is RCRegisterAttemptPL) {
    return registerAttempt(state.pronounceLetters);
  }

  if (action is RCToggleRecordingStatePL) {
    return state.pronounceLetters.copyWith(
      isRecording: action.state
    );
  }

  return state.pronounceLetters;

}

RCPronounceLettersState registerAttempt(RCPronounceLettersState state) {

  return state.copyWith(
    currentData: state.currentData.copyWith( attempts: state.currentData.attempts + 1 )
  );

}