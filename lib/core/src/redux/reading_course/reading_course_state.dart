import 'package:meta/meta.dart';

import './rc_letter_detail/rc_letter_detail_state.dart';
import './rc_data/rc_data_state.dart';

@immutable
class ReadingCourseState {

  final RCDataState data;
  final RCLetterDetail    letterDetail;

  ReadingCourseState({
    @required this.data,
    @required this.letterDetail
  });

  factory ReadingCourseState.initialState() {
    return ReadingCourseState(
      data:          RCDataState.initialData(),
      letterDetail:  RCLetterDetail.initialState()
    );
  }

  ReadingCourseState copyWith({
    RCDataState data,
    RCLetterDetail letterDetail
  }) {

    return ReadingCourseState(
      data: data ?? this.data,
      letterDetail: letterDetail ?? this.letterDetail
    );
  }

  

  @override
  bool operator == (Object other) => 
    identical(this, other) || other is ReadingCourseState
      && runtimeType   == other.runtimeType
      && data          == other.data
      && letterDetail  == other.letterDetail;

  @override
  int get hashCode =>
    data.hashCode ^
    letterDetail.hashCode;

}