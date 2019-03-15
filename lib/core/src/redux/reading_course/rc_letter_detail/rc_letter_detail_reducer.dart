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
    return handleValidateSelections(state.letterDetail);
  }

  return state.letterDetail;

}

RCLetterDetailState handleValidateSelections(RCLetterDetailState state) {

  final selections = state.selections;
  final sel1 = selections.selection1[0];
  final sel2 = selections.selection2[0];
  final currentLetter = state.currentData.letter;

  if (sel1 == currentLetter && sel2 == currentLetter ) {

    return state.copyWith(
      canPlayGame: false,
      hideAllCards: true,
      showAllCards: false,
      showSuccessScreen: false,
      showWellDoneDialog: true,
      selections: state.selections.restart()
    );

  } else {

    return state.copyWith(
      canPlayGame: false,
      hideAllCards: true,
      showAllCards: false,
      showTryAgainDialog: true,
      showWellDoneDialog: false,
      selections: state.selections.restart(),
    );

  }

}