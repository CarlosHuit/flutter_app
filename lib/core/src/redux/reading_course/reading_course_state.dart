import 'package:meta/meta.dart';

import './rc_game/rc_game_state.dart';
import './rc_data/rc_data_state.dart';
import './rc_find_letters/rc_find_letters_state.dart';
import './rc_letter_detail/rc_letter_detail_state.dart';
import './rc_draw_letters/rc_draw_letters_state.dart';
import './rc_select_words/rc_select_words_state.dart';
import './rc_pronounce_letters/rc_pronounce_letters_state.dart';

@immutable
class ReadingCourseState {

  final RCDataState         data;
  final RCGameState         game;
  final RCLetterDetailState letterDetail;
  final RCFindLettersState  findLetters;
  final RCDrawLettersState  drawLetters;
  final RCSelectWordsState  selectWords;
  final RCPronounceLettersState pronounceLetters;

  ReadingCourseState({
    @required this.data,
    @required this.letterDetail,
    @required this.game,
    @required this.findLetters,
    @required this.drawLetters,
    @required this.selectWords,
    @required this.pronounceLetters,
  });


  factory ReadingCourseState.initialState() {

    return ReadingCourseState(
      data:          RCDataState.initialData(),
      game:          RCGameState.initialState(),
      letterDetail:  RCLetterDetailState.initialState(),
      findLetters:   RCFindLettersState.initialState(),
      drawLetters:   RCDrawLettersState.initialState(),
      selectWords:   RCSelectWordsState.initialState(),
      pronounceLetters: RCPronounceLettersState.initialState(),
    );

  }



  ReadingCourseState copyWith({
    RCDataState data,
    RCGameState game,
    RCLetterDetailState letterDetail,
    RCFindLettersState  findLetters,
    RCDrawLettersState  drawLetters,
    RCSelectWordsState  selectWords,
    RCPronounceLettersState pronounceLetters,
  }) {

    return ReadingCourseState(
      data:          data ?? this.data,
      game:          game ?? this.game,
      letterDetail:  letterDetail ?? this.letterDetail,
      findLetters:   findLetters  ?? this.findLetters,
      drawLetters:   drawLetters ?? this.drawLetters,
      selectWords:   selectWords ?? this.selectWords,
      pronounceLetters: pronounceLetters ?? this.pronounceLetters
    );

  }

  

  @override
  bool operator == (Object other) => 
    identical(this, other) || other is ReadingCourseState
      && runtimeType   == other.runtimeType
      && data == other.data
      && game == other.game
      && letterDetail == other.letterDetail
      && findLetters == other.findLetters
      && drawLetters ==other.drawLetters
      && selectWords == other.selectWords
      && pronounceLetters == other.pronounceLetters;

  @override
  int get hashCode =>
    data.hashCode ^
    game.hashCode ^
    letterDetail.hashCode ^
    findLetters.hashCode ^
    drawLetters.hashCode ^
    selectWords.hashCode ^
    pronounceLetters.hashCode;

}