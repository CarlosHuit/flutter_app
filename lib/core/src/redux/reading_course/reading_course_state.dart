
import 'package:meta/meta.dart';

@immutable
class ReadingCourseState {

  final String letter;

  ReadingCourseState({@required this.letter});

  factory ReadingCourseState.initialState() {
    return ReadingCourseState(
      letter: ''
    );
  }

}