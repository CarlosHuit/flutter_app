
import 'dart:math';

import 'package:app19022019/core/src/redux/reading_course/reading_course_state.dart';
import 'package:meta/meta.dart';

@immutable
class RCGameState {
  
  final Map<String, dynamic> selections;
  final List<RCGameData> data;
  final RCGameData currentData;
  final bool isSettingData;
  final bool showWellDoneDialog;
  final bool showCoincidences;
  final bool showCorrectLetters;
  final int  currentIndex;

  RCGameState({
    @required this.data,
    @required this.selections,
    @required this.currentData,
    @required this.currentIndex,
    @required this.isSettingData,
    @required this.showCoincidences,
    @required this.showWellDoneDialog,
    @required this.showCorrectLetters,
  });

  factory RCGameState.fromStore(ReadingCourseState state) {

    final path = state;
    final letterLC = path.data.currentLetter.toLowerCase();
    final letterUC = path.data.currentLetter.toUpperCase();

    final slLowerCase = path.data.similarLetters.firstWhere((el) => el.l == letterLC).sl;
    final slUpperCase = path.data.similarLetters.firstWhere((el) => el.l == letterUC).sl;

    final dataLC = RCGameData.initialize(slLowerCase, letterLC, 411.42857142857144, 'minúscula');
    final dataUC = RCGameData.initialize(slUpperCase, letterUC, 411.42857142857144, 'mayúscula');
    final data = [dataLC, dataUC];

    return RCGameState(
      currentData:        dataLC,
      data:               data,
      currentIndex:       0,
      selections:          {},
      showCoincidences:   true,
      isSettingData:      false,
      showCorrectLetters: false,
      showWellDoneDialog: false,

    );

  }

  factory RCGameState.initialState() {
    return RCGameState(
      data:     null,
      selections:  null,
      currentData:  null,
      currentIndex:   null,
      isSettingData:    null,
      showCoincidences:   null,
      showCorrectLetters:   null,
      showWellDoneDialog:     null,
    );
  }

  RCGameState copyWith({
    Map<String, dynamic> selections,
    List<RCGameData> data,
    RCGameData currentData,
    bool isSettingData,
    bool showWellDoneDialog,
    bool showCoincidences,
    bool showCorrectLetters,
    int  currentIndex,
  }) {
    return RCGameState(
      data:               data     ?? this.data,
      selections:          selections  ?? this.selections,
      currentData:        currentData  ?? this.currentData,
      currentIndex:       currentIndex   ?? this.currentIndex,
      isSettingData:      isSettingData    ?? this.isSettingData,
      showCoincidences:   showCoincidences   ?? this.showCoincidences,
      showWellDoneDialog: showWellDoneDialog   ?? this.showWellDoneDialog,
      showCorrectLetters: showCorrectLetters     ?? this.showCorrectLetters,
    );
  }

  @override
  bool operator == (Object other) => 
    identical(this, other) || other is RCGameState
      && runtimeType == other.runtimeType
      && data     ==   other.data
      && selections  ==   other.selections
      && currentData  ==   other.currentData
      && currentIndex   ==   other.currentIndex
      && isSettingData    ==   other.isSettingData
      && showCoincidences   ==   other.showCoincidences
      && showWellDoneDialog   ==   other.showWellDoneDialog
      && showCorrectLetters     ==   other.showCorrectLetters;

  @override
  int get hashCode =>
    data.hashCode    ^
    selections.hashCode ^
    currentData.hashCode ^
    currentIndex.hashCode  ^
    isSettingData.hashCode   ^
    showCoincidences.hashCode  ^
    showWellDoneDialog.hashCode  ^
    showCorrectLetters.hashCode;

}

class RCGameData {

  final String letter;
  final List<List<dynamic>> data;
  final String type;
  final int correctsValidation;
  final int totalCorrects;
  final int countCorrects;
  final int countIncorrects;
  final int opportunities;

  RCGameData({
    @required this.letter,
    @required this.data,
    @required this.type,
    @required this.correctsValidation,
    @required this.totalCorrects,
    @required this.countCorrects,
    @required this.countIncorrects,
    @required this.opportunities
  });

  factory RCGameData.initialize(List<String> sl, String letter, double screenWidth, String type) {

    final approximatedElements = 35;

    final columnWidth = 90.0;
    final surplus = screenWidth % columnWidth;
    final columns = surplus > 0
      ? (screenWidth - surplus) ~/ columnWidth
      : screenWidth ~/ columnWidth;

    final rows = (approximatedElements / columns).round();
    final elements = columns * rows;

    final minCorrects = 8;
    final maxCorrexts = 12;
    final corrects = minCorrects + Random().nextInt(maxCorrexts - minCorrects);
    final elementsToInsert = elements - corrects;

    List<String> x = [];
    List<String> t = [];
    List<List<String>> result = [];

    // Generate array with the correct letters 
    for (var i = 0; i < corrects; i++) {
      x.add(letter);
    }

    // fill array with 8 * 7 = 56 > aproxEls
    for (var i = 0; i < 8; i++) {
      sl.forEach((l) => t.add(l));
    }

    // fill array with the incorrect letters;
    for (var i = 0; i < elementsToInsert; i++) {
      x.add(t[i]);
    }


    x.shuffle();
    final max = x.length ~/ columns;
    for (var i = 0; i < columns; i++) {
      result.add( x.sublist(0, max) );
      x.removeRange(0, max);
    }

    return RCGameData(
      letter: letter,
      data:   result,
      type:   type,
      correctsValidation: corrects,
      totalCorrects:      corrects,
      countCorrects:   0,
      countIncorrects: 0,
      opportunities:   3
    );
  }

  RCGameData copyWith({
    String letter,
    List<List<dynamic>> data,
    String type,
    int correctsValidation,
    int totalCorrects,
    int countCorrects,
    int countIncorrects,
    int opportunities,
  }) {
    return RCGameData(
      letter:             letter ?? this.letter,
      data:               data   ?? this.data,
      type:               type   ?? this.type,
      correctsValidation: correctsValidation ?? this.correctsValidation,
      totalCorrects:      totalCorrects      ?? this.totalCorrects,
      countCorrects:      countCorrects      ?? this.countCorrects,
      countIncorrects:    countIncorrects    ?? this.countIncorrects,
      opportunities:      opportunities      ?? this.opportunities,
    );
  }

}