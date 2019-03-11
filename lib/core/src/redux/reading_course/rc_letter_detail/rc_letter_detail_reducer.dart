import '../reading_course_state.dart';
import './rc_letter_detail_actions.dart';
import './rc_letter_detail_state.dart';

RCLetterDetailState readingCourseLetterDetailReducer(ReadingCourseState state, dynamic action) {



  if (action is RCSetInitialDataLD) {
    return RCLetterDetailState.fromStore(state);
  }



  if (action is RCAddFirstSelectionLD) {
    return state.letterDetail.copyWith(
      selections: state.letterDetail.selections.copyWith(
        selection1: action.selection
      )
    );
  }



  if (action is RCAddSecondSelectionLD) {
    return state.letterDetail.copyWith(
      canPlayGame: false,
      selections:  state.letterDetail.selections.copyWith(selection2: action.selection),
    );
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
      hideAllCards: true,
      canPlayGame: true
    );
  }

  if (action is RCValidateSelectionsLD) {
    final selections = state.letterDetail.selections;
    print('selection1: ${selections.selection1} -- selection2: ${selections.selection2}');
  }

  return state.letterDetail;

}