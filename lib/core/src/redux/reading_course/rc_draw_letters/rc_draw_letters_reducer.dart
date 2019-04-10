import 'package:flutter/material.dart';

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
    return changeCurrentData(state);
  }

  if (action is RCToggleStrokeSizeSelectorDL) {
    return toggleStrokeSizeSelector(state);
  }

  if (action is RCToggleStrokeColorSelectorDL) {
    return toggleStrokeColorSelector(state);
  }

  if (action is RCChangeStrokeSizeDL) {
    return changeStrokeSize(state, action.width);
  }

  if (action is RCChangeStrokeColorDL) {
    return changeStrokeColor(state, action.color);
  }

  if (action is RCToggleGuideLines) {
    return toggleGuideLines(state);
  }

  if (action is RCShowWellDoneDialogDL) {
    return showWellDoneDialog(state);
  }

  if (action is RCHideWellDoneDialogDL) {
    return hideWellDoneDialog(state);
  }

  if (action is RCShowHandwritingDL) {
    return showHandwriting(state);
  }

  if (action is RCHideHandwritingDL) {
    return hideHandwriting(state);
  }


  return state.drawLetters;

}


RCDrawLettersState hideWellDoneDialog(ReadingCourseState state) {
  return state.drawLetters.copyWith(
    showWellDoneDialog: false
  );
}


RCDrawLettersState showHandwriting(ReadingCourseState state) {
  return state.drawLetters.copyWith(
    showHandWriting: true
  );

}

RCDrawLettersState hideHandwriting(ReadingCourseState state) {
  return state.drawLetters.copyWith(
    showHandWriting: false
  );
}

RCDrawLettersState changeStrokeColor(ReadingCourseState state, MaterialColor color) {
  return state.drawLetters.copyWith(
    preferences: state.drawLetters.preferences.copyWith(
      lineColor: color
    )
  );
}

RCDrawLettersState changeStrokeSize(ReadingCourseState state, double width) {
  return state.drawLetters.copyWith(
    preferences: state.drawLetters.preferences.copyWith(
      lineWidth: width
    )
  );
}

RCDrawLettersState toggleStrokeColorSelector(ReadingCourseState state) {
  return state.drawLetters.copyWith(
    topControlBar: state.drawLetters.topControlBar.copyWith(
      showStrokeColorSelector: !state.drawLetters.topControlBar.showStrokeColorSelector
    )
  );
}

RCDrawLettersState toggleStrokeSizeSelector(ReadingCourseState state) {
  return state.drawLetters.copyWith(
    topControlBar: state.drawLetters.topControlBar.copyWith(
      showStrokeSizeSelector: !state.drawLetters.topControlBar.showStrokeSizeSelector
    )
  );
}

RCDrawLettersState changeCurrentData(ReadingCourseState state) {

  final index  = state.drawLetters.currentIndex + 1;

  return state.drawLetters.copyWith(
    currrentData:    state.drawLetters.data[index],
    currentIndex:    index,
    showHandWriting: true
  );

}

RCDrawLettersState showWellDoneDialog(ReadingCourseState state) {
  return state.drawLetters.copyWith(
    showWellDoneDialog: true
  );
}

RCDrawLettersState toggleGuideLines(ReadingCourseState state) {
  return state.drawLetters.copyWith(
    preferences: state.drawLetters.preferences.copyWith(
      showGuideLines: !state.drawLetters.preferences.showGuideLines
    )
  );
}
