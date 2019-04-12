import 'package:app19022019/core/src/redux/reading_course/reading_course_state.dart';
import 'package:meta/meta.dart';

@immutable
class RCPronounceLettersState {

  final List<RCPronounceLettersData> data;
  final RCPronounceLettersData currentData;
  final int currentIndex;
  final bool showWellDoneDialog;
  final bool isRecording;
  final bool isSettingData;

  RCPronounceLettersState({
    @required this.data,
    @required this.currentData,
    @required this.currentIndex,
    @required this.showWellDoneDialog,
    @required this.isRecording,
    @required this.isSettingData
  });

  factory RCPronounceLettersState.initialState() {
    return RCPronounceLettersState(
      data: null,
      currentData: null,
      isRecording: null,
      currentIndex: null,
      isSettingData: null,
      showWellDoneDialog: null,
    );
  }

  factory RCPronounceLettersState.fromStore(ReadingCourseState store) {

    final letterLowerCase = store.data.currentLetter.toLowerCase();
    final letterUpperCase = letterLowerCase.toUpperCase();

    final letterSound = store.data.soundLetters[letterLowerCase];

    final dataLowerCase = RCPronounceLettersData(
      letter:      letterLowerCase,
      attempts:    0,
      letterSound: letterSound,
      letterType:  'minúscula',
    );

    final dataUpperCase = RCPronounceLettersData(
      letter:      letterUpperCase,
      attempts:    0,
      letterType:  'mayúscula',
      letterSound: letterSound,
    );

    final data = [ dataLowerCase, dataUpperCase ];

    return RCPronounceLettersState(
      data: data,
      currentData: data[0],
      currentIndex: 0,
      isRecording: false,
      isSettingData: false,
      showWellDoneDialog: false,
    );

  }

  RCPronounceLettersState copyWith({
    List<RCPronounceLettersData> data,
    RCPronounceLettersData currentData,
    int currentIndex,
    bool showWellDoneDialog,
    bool isRecording,
    bool isSettingData,
  }) {

    return RCPronounceLettersState(
      data: data ?? this.data,
      currentData: currentData ?? this.currentData,
      currentIndex: currentIndex ?? this.currentIndex,
      showWellDoneDialog: showWellDoneDialog ?? this.showWellDoneDialog,
      isRecording: isRecording ?? this.isRecording,
      isSettingData: isSettingData ?? this.isSettingData,
    );

  }

  @override
  bool operator == (Object other) =>
    identical(this, other) || other is RCPronounceLettersState
    && runtimeType == other.runtimeType
    && data == other.data
    && currentData == other.currentData
    && currentIndex == other.currentIndex
    && showWellDoneDialog == other.showWellDoneDialog
    && isRecording == other.isRecording
    && isSettingData == other.isSettingData;

  @override
  int get hashCode => 
    data.hashCode ^
    currentData.hashCode ^
    currentIndex.hashCode ^
    showWellDoneDialog.hashCode ^
    isRecording.hashCode ^
    isSettingData.hashCode;

}

class RCPronounceLettersData {

  final String letterSound;
  final String letterType;
  final String letter;
  final int attempts;

  RCPronounceLettersData({
    @required this.letterSound,
    @required this.letterType,
    @required this.letter,
    @required this.attempts
  });

  RCPronounceLettersData copyWith({
    String letterSound,
    String letterType,
    String letter,
    int attempts,
  }) {
    return  RCPronounceLettersData(
      letterSound: letterSound?? this.letterSound,
      letterType: letterType?? this.letterType,
      letter: letter?? this.letter,
      attempts: attempts?? this.attempts,
    );
  }

}