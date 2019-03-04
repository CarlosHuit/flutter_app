import './rc_data/rc_data_state.dart';
import 'package:meta/meta.dart';

@immutable
class ReadingCourseState {

  final RCDataState data;
  // final RCLetterDetail    letterDetail;

  ReadingCourseState({
    @required this.data,
    // @required this.letterDetail
  });

  factory ReadingCourseState.initialState() {
    return ReadingCourseState(
      data:          RCDataState.initialData(),
    );
  }

  ReadingCourseState copyWith({
    bool isLoading,
    String currentLetter,
    RCDataState data,
  }) {

    return ReadingCourseState(
      data:          data ?? this.data,
    );
  }

  

  @override
  bool operator == (Object other) => 
    identical(this, other) || other is ReadingCourseState
      && runtimeType   == other.runtimeType
      && data          == other.data;

  @override
  int get hashCode =>
    data.hashCode;

}