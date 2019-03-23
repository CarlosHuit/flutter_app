import 'package:app19022019/core/src/redux/reading_course/reading_course_state.dart';
import 'package:meta/meta.dart';

@immutable
class RCFindLettersState {

  final List<FLData> data;
  final FLData currentData;
  final int currentIndex;
  final bool isSettingData;
  final bool showSuccessDialog;
  final bool showCoincidences;
  final bool disableAll;
  final int totalOfCorrects;
  final int pendings;

  RCFindLettersState({
    @required this.data,
    @required this.pendings,
    @required this.disableAll,
    @required this.currentData,
    @required this.currentIndex,
    @required this.isSettingData,
    @required this.totalOfCorrects,
    @required this.showCoincidences,
    @required this.showSuccessDialog,
  });


  factory RCFindLettersState.initialState() {
    return RCFindLettersState(
      data:      null,
      pendings:   null,
      disableAll:  null,
      currentData:  null,
      currentIndex:  null,
      isSettingData:  null,
      totalOfCorrects: null,
      showCoincidences: null,
      showSuccessDialog: null,
    );
  }


  factory RCFindLettersState.fromStore(ReadingCourseState state) {

    final letter = state.data.currentLetter.toLowerCase();
    final words  = state.data.words.firstWhere((el) => el.l == letter).w;

    final List<FLData> els = [];
    words.forEach((w) => els.add(FLData.initialize(w, letter)) );


    return RCFindLettersState(
      data:     els,
      pendings:  els[0].corrects,
      disableAll: false,
      currentData: els[0],
      currentIndex: 0,
      isSettingData: false,
      totalOfCorrects: els[0].corrects,
      showCoincidences: false,
      showSuccessDialog: false,
    );

  }


  RCFindLettersState copyWith({
    List<FLData> data,
    FLData currentData,
    int currentIndex,
    bool isSettingData,
    bool showSuccessDialog,
    bool showCoincidences,
    bool disableAll,
    int totalOfCorrects,
    int pendings,
  }) {

    return RCFindLettersState(
      data:      data      ?? this.data,
      pendings:   pendings   ?? this.pendings,
      disableAll:  disableAll  ?? this.disableAll,
      currentData:  currentData  ?? this.currentData,
      currentIndex:  currentIndex  ?? this.currentIndex,
      isSettingData:  isSettingData  ?? this.isSettingData,
      totalOfCorrects: totalOfCorrects ?? this.totalOfCorrects,
      showCoincidences: showCoincidences ?? this.showCoincidences,
      showSuccessDialog: showSuccessDialog ?? this.showSuccessDialog,
    );

  }



  @override
  bool operator == (Object other) => 
    identical(this, other) || other is RCFindLettersState
      && runtimeType       == other.runtimeType
      && data              == other.data
      && currentData       == other.currentData
      && currentIndex      == other.currentIndex
      && isSettingData     == other.isSettingData
      && showSuccessDialog == other.showSuccessDialog
      && showCoincidences  == other.showCoincidences
      && disableAll        == other.disableAll
      && totalOfCorrects   == other.totalOfCorrects
      && pendings          == other.pendings;

  @override
  int get hashCode => 
    data.hashCode ^
    disableAll.hashCode ^
    currentData.hashCode ^
    currentIndex.hashCode ^
    isSettingData.hashCode ^
    totalOfCorrects.hashCode ^
    showCoincidences.hashCode ^
    showSuccessDialog.hashCode ^
    pendings.hashCode;

}

class FLData {

  final String word;
  final String imgUrl;
  final String letter;
  final String type;
  final int corrects;
  final List<String> letters;
  final Map<String, dynamic> selections;
  final Map<String, dynamic> wrongSelections;
  final Map<String, dynamic> correctSelections;

  FLData({
    @required this.word,
    @required this.imgUrl,
    @required this.letter,
    @required this.type,
    @required this.corrects,
    @required this.letters,
    @required this.selections,
    @required this.wrongSelections,
    @required this.correctSelections
  });

  factory FLData.initialize(String w, String letter) {

    final word    = w.toLowerCase();
    final letters = word.split('');
    final urlImg  = 'assets/img100X100/$word-min.png';
    int corrects  = 0;
    letters.forEach((l) => l == letter ? corrects ++ : null);

    return FLData(
      word:     word,
      imgUrl:   urlImg,
      letter:   letter,
      letters:  letters,
      corrects: corrects,
      type:     'minúscula',
      selections:    {},
      wrongSelections: {},
      correctSelections: {},
    );

  }

}