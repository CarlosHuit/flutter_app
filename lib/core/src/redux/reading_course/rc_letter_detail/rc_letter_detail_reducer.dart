import '../reading_course_state.dart';
import './rc_letter_detail_actions.dart';
import './rc_letter_detail_state.dart';

RCLetterDetailState readingCourseLetterDetailReducer(ReadingCourseState state, dynamic action) {


  if (action is RCSetInitialDataLD) {
    return RCLetterDetailState.fromStore(state);
  }

  if (action is RCSelectOptionLD) {
    print('You have selected: ${action.selection}');

    if (state.letterDetail.selections.selection1 == null) {
      return state.letterDetail.copyWith(
        selections: state.letterDetail.selections.copyWith(
          selection1: action.selection )
      );
      
    }

    if (state.letterDetail.selections.selection1 != null) {
      return state.letterDetail.copyWith(
        selections: state.letterDetail.selections.copyWith(
          selection2: action.selection
        )
      );
    }

    return state.letterDetail;
  }

  if (action is RCShowAllCardsLD) {
    return state.letterDetail.copyWith(
      showAllCards: true,
      hideAllCards: false
    );
  }

  if (action is RCHideAllCardsLD) {
    return state.letterDetail.copyWith(
      showAllCards: false,
      hideAllCards: true
    );
  }

  return state.letterDetail;

}