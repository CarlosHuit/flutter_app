
import 'package:app19022019/core/src/redux/reading_course/rc_game/rc_game_state.dart';
import 'package:app19022019/core/src/redux/reading_course/reading_course_state.dart';
import './rc_game_actions.dart';

RCGameState readingCourseGameReducer(ReadingCourseState state, dynamic action) {


  if (action is RCSetInitialDataG) {
    return RCGameState.fromStore(state);
  }


  return state.game;


}