import 'package:app19022019/core/src/redux/reading_course/rc_game/rc_game_state.dart';
import 'package:meta/meta.dart';

import './rc_letter_detail/rc_letter_detail_state.dart';
import './rc_data/rc_data_state.dart';

@immutable
class ReadingCourseState {

  final RCDataState         data;
  final RCLetterDetailState letterDetail;
  final RCGameState         game;

  ReadingCourseState({
    @required this.data,
    @required this.letterDetail,
    @required this.game,
  });



  factory ReadingCourseState.initialState() {

    return ReadingCourseState(
      data:          RCDataState.initialData(),
      game:          RCGameState.initialState(),
      letterDetail:  RCLetterDetailState.initialState(),
    );

  }



  ReadingCourseState copyWith({
    RCDataState data,
    RCGameState game,
    RCLetterDetailState letterDetail,
  }) {

    return ReadingCourseState(
      data: data ?? this.data,
      game: game ?? this.game,
      letterDetail:  letterDetail ?? this.letterDetail,
    );
  }

  

  @override
  bool operator == (Object other) => 
    identical(this, other) || other is ReadingCourseState
      && runtimeType   == other.runtimeType
      && data          ==  other.data
      && game          ==  other.game
      && letterDetail  ==  other.letterDetail;

  @override
  int get hashCode =>
    data.hashCode ^
    game.hashCode ^
    letterDetail.hashCode;

}