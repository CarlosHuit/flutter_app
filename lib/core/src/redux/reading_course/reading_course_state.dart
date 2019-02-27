
import 'package:meta/meta.dart';
import '../../models/reading_course/rc_data_model.dart';

@immutable
class ReadingCourseState {

  final bool              isLoading;
  final String            currentLetter;
  // final RCCourseDataModel data;

  ReadingCourseState({
    @required this.currentLetter,
    @required this.isLoading,
    // @required this.data
  });

  factory ReadingCourseState.initialState() {
    return ReadingCourseState(
      currentLetter: null,
      // data:          null,
      isLoading:     true
    );
  }

  ReadingCourseState copyWith({
    bool isLoading,
    String currentLetter,
    RCCourseDataModel data,
  }) {
    print('viewMoodel: ${isLoading ?? this.isLoading}' );
    return ReadingCourseState(
      currentLetter: currentLetter ?? this.currentLetter,
      isLoading:     isLoading ?? this.isLoading,
      // data:          data ?? this.data,
    );
  }

  

  @override
  bool operator == (Object other) => 
    identical(this, other) || other is ReadingCourseState
      && runtimeType   == other.runtimeType
      && isLoading     == other.isLoading
      // && data          == other.data
      && currentLetter == other.currentLetter;

  @override
  int get hashCode =>
    isLoading.hashCode ^
    // data.hashCode ^
    currentLetter.hashCode;

}