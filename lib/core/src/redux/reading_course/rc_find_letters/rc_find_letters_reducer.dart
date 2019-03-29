
import '../../reading_course/reading_course_state.dart';
import './rc_find_letters_actions.dart';
import './rc_find_letters_state.dart';

RCFindLettersState readingCourseFindLettersReducer(ReadingCourseState state, dynamic action) {


  if (action is RCSetInitialDataFL) {
    return RCFindLettersState.fromStore(state);
  }

  if (action is  RCSubtractCorrectFL) {
    return subtractPendings(state);
  }

  if (action is RCChangeCurrentDataFL) {
    return changeCurrentData(state);
  }

  return state.findLetters;

}

RCFindLettersState subtractPendings(ReadingCourseState state) {
  return state.findLetters.copyWith(
    currentData: state.findLetters.currentData.subtractPendings()
  );
}

RCFindLettersState changeCurrentData(ReadingCourseState state) {

  final currentIndex = state.findLetters.currentIndex;
  final index        = currentIndex + 1;
  final dataLength   = state.findLetters.data.length;

  if (index <= dataLength ) {

    return state.findLetters.copyWith(
      currentData: state.findLetters.data[index],
      currentIndex: index
    );

  }


  return state.findLetters;


}