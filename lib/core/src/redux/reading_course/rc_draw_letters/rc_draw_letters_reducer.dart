import './rc_draw_letters_state.dart';
import '../reading_course_state.dart';
import './rc_draw_letters_actions.dart';

RCDrawLettersState readingCourseDrawLettersReducer(ReadingCourseState state, dynamic action) {


  if (action is RCSetInitialDataDL) {
    return RCDrawLettersState.fromStateData(state);
  }

  if (action is RCResetStateDL) {
    return RCDrawLettersState.initialState();
  }

  if (action is RCChangeCurrentDataDL) {
    final index  = state.drawLetters.currentIndex + 1;

    return state.drawLetters.copyWith(
      currrentData: state.drawLetters.data[index],
      currentIndex: index,
    );
  }

  if (action is RCToggleStrokeSizeSelectorDL) {
    return state.drawLetters.copyWith(
      topControlBar: state.drawLetters.topControlBar.copyWith(
        showStrokeSizeSelector: !state.drawLetters.topControlBar.showStrokeSizeSelector
      )
    );
  }

  if (action is RCToggleStrokeColorSelectorDL) {

    return state.drawLetters.copyWith(
      topControlBar: state.drawLetters.topControlBar.copyWith(
        showStrokeColorSelector: !state.drawLetters.topControlBar.showStrokeColorSelector
      )
    );

  }


  if (action is RCChangeStrokeSizeDL) {
    return state.drawLetters.copyWith(
      preferences: state.drawLetters.preferences.copyWith(
        lineWidth: action.width
      )
    );
  }

  if (action is RCChangeStrokeColorDL) {
    return state.drawLetters.copyWith(
      preferences: state.drawLetters.preferences.copyWith(
        lineColor: action.color
      )
    );
  }

  if (action is RCToggleGuideLines) {
    return state.drawLetters.copyWith(
      preferences: state.drawLetters.preferences.copyWith(
        showGuideLines: !state.drawLetters.preferences.showGuideLines
      )
    );
  }

  if (action is RCShowWellDoneDialogDL) {
    return state.drawLetters.copyWith(
      showWellDoneDialog: true
    );
  }

  if (action is RCHideWellDoneDialogDL) {
    return state.drawLetters.copyWith(
      showWellDoneDialog: false
    );
  }

  return state.drawLetters;

}

