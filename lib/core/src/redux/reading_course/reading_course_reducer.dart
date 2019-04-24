import 'package:app19022019/core/src/redux/app/app_state.dart';

import './rc_find_letters/rc_find_letters_reducer.dart';
import './rc_letter_detail/rc_letter_detail_reducer.dart';
import './rc_game/rc_game_reducer.dart';
import './rc_data/rc_data_reducer.dart';
import './reading_course_state.dart';
import './rc_draw_letters/rc_draw_letters_reducer.dart';
import './rc_select_words/rc_select_words_reducer.dart';
import './rc_pronounce_letters/rc_pronounce_letters_reducer.dart';


ReadingCourseState readingCourseReducer(AppState store, dynamic action) {

  final state = store.readingCourseState;

  return ReadingCourseState(
    game:             readingCourseGameReducer(store, action),
    data:             readingCourseDataReducer(state.data, action),
    findLetters:      readingCourseFindLettersReducer(state, action),
    letterDetail:     readingCourseLetterDetailReducer(state, action),
    drawLetters:      readingCourseDrawLettersReducer(state, action),
    selectWords:      readingCourseSelectWordsReducer(state, action),
    pronounceLetters: readingCoursePronounceLettersReducer(state, action),
  );

}