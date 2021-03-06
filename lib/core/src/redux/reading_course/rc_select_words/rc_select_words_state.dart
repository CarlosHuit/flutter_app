
import 'dart:math';

import 'package:app19022019/core/src/redux/reading_course/reading_course_state.dart';
import 'package:meta/meta.dart';

@immutable
class RCSelectWordsState {
  
  final List<RCSelectWordsData> data;
  final RCSelectWordsData currentData;
  final bool isSettingData;
  final bool showWellDoneDialog;
  final int currentIndex;
  final String sound;

  RCSelectWordsState({
    @required this.data,
    @required this.currentData,
    @required this.isSettingData,
    @required this.showWellDoneDialog,
    @required this.currentIndex,
    @required this.sound,
  });


  factory RCSelectWordsState.initialState() {
    return RCSelectWordsState(
      data: null,
      currentData: null,
      currentIndex: null,
      isSettingData: null,
      showWellDoneDialog: null,
      sound: null,
    );
  }

  factory RCSelectWordsState.fromStore(ReadingCourseState state) {

    final String letter = state.data.currentLetter.toLowerCase();
    final String sound  = state.data.soundLetters[letter];

    final List<String> words = [];

    state.data.words.forEach((e) => e.w.forEach((w) => words.add(w)));

    final  correctWords = words.where((w) => w.contains(letter)).toList();
    final  incorrectWords = words.where((w) => !w.contains(letter)).toList();

    final dataLC = RCSelectWordsData.generate(correctWords, incorrectWords, 'minúscula', 10, letter.toLowerCase());
    final dataUC = RCSelectWordsData.genUpperCase(correctWords, incorrectWords, 'mayúscula', 10, letter.toUpperCase());

    final data = [ dataLC, dataUC ];

    return RCSelectWordsState(
      data:               data,
      sound:              sound,
      currentData:        dataLC,
      currentIndex:       0,
      isSettingData:      false,
      showWellDoneDialog: false,
    );

  }

  RCSelectWordsState copyWith({
    List<RCSelectWordsData> data,
    RCSelectWordsData currentData,
    bool isSettingData,
    bool showWellDoneDialog,
    int currentIndex,
    String sound,
  }) {

    return RCSelectWordsState(
      sound: sound ?? this.sound,
      data:     data ?? this.data,
      currentData:  currentData ?? this.currentData,
      currentIndex:   currentIndex ?? this.currentIndex,
      isSettingData:    isSettingData ?? this.isSettingData,
      showWellDoneDialog: showWellDoneDialog ?? this.showWellDoneDialog,
    );

  }

  @override
  bool operator ==(Object other) => 
    identical(this, other) || other is RCSelectWordsState
      && runtimeType == other.runtimeType
      && this.data == other.data
      && this.currentData == other.currentData
      && this.isSettingData == other.isSettingData
      && this.showWellDoneDialog == other.showWellDoneDialog
      && this.currentIndex == other.currentIndex
      && this.sound == other.sound;

  @override
  int get hashCode =>
    data.hashCode ^
    currentData.hashCode ^
    isSettingData.hashCode ^
    showWellDoneDialog.hashCode ^
    currentIndex.hashCode ^
    sound.hashCode;

}

@immutable
class RCSelectWordsData {

  final int totalOfCorrect;
  final int totalOfPending;
  final String letter;
  final String type;
  final List<String> words;
  final List<String> correctWords;
  final List<String> incorrectWords;
  final Map<String, String> selections;
  final Map<String, String> correctSelections;
  final Map<String, String> wrongSelections;

  RCSelectWordsData({
    this.type,
    this.words,
    this.letter,
    this.selections,
    this.correctWords,
    this.incorrectWords,
    this.totalOfCorrect,
    this.totalOfPending,
    this.wrongSelections,
    this.correctSelections,
  });

  factory RCSelectWordsData.generate( List<String> corrects, List<String> incorrects, String type, int max, String letter ) {

    int random(int min, int maxi, int length) {
      final maximum = maxi > length ? length + 1 : maxi + 1;
      return min + Random().nextInt(maximum - min);
    }

    List<String> randomWords(List<String> words, int max) {
      final messyWords = List.from(words);
      messyWords.shuffle();
      return List.generate(max, (i) => messyWords[i]);
    }

    final maxOpts = 10;
    final totalCorrects = random(2, 6, corrects.length);
    final totalIncorrects = maxOpts - totalCorrects;

    final correctWords = randomWords(corrects, totalCorrects);
    final incorrectWords = randomWords(incorrects, totalIncorrects);

    final List<String> words = []..addAll(correctWords)..addAll(incorrectWords);
    words.shuffle();

    return RCSelectWordsData(
      type:   type,
      words:  words,
      letter: letter,
      selections:   {},
      correctWords: correctWords,
      incorrectWords: incorrectWords,
      totalOfCorrect: totalCorrects,
      totalOfPending: totalCorrects,
      wrongSelections:   {},
      correctSelections: {},
    );
  }

  factory RCSelectWordsData.genUpperCase( List<String> corrects, List<String> incorrects, String type, int max, String letter ) {


    int random(int min, int maxi, int length) {
      final maximum = maxi > length ? length + 1 : maxi + 1;
      return min + Random().nextInt(maximum - min);
    }

    List<String> randomWords(List<String> words, int max) {
      final messyWords = List.from(words);
      messyWords.shuffle();
      return List.generate(max, (i) => messyWords[i]);
    }

    final maxOpts = 10;
    final totalCorrects = random(2, 6, corrects.length);
    final totalIncorrects = maxOpts - totalCorrects;

    final correctWords = randomWords(corrects, totalCorrects);
    final incorrectWords = randomWords(incorrects, totalIncorrects);

    final List<String> words = []..addAll(correctWords)..addAll(incorrectWords);
    final data = List.generate(words.length, (i) =>words[i].toUpperCase());
    words.shuffle();

    return RCSelectWordsData(
      type:   type,
      words:  data,
      letter: letter,
      selections:   {},
      correctWords:   correctWords,
      incorrectWords: incorrectWords,
      totalOfCorrect: totalCorrects,
      totalOfPending: totalCorrects,
      wrongSelections:   {},
      correctSelections: {},
    );
  }

  RCSelectWordsData copyWith({
    List<String> words,
    List<String> correctWords,
    List<String> incorrectWords,
    String letter,
    String type,
    int totalOfCorrect,
    int totalOfPending,
    Map<String, String> selections,
    Map<String, String> correctSelections,
    Map<String, String> wrongSelections,
  }) {

    return RCSelectWordsData(
      type:   type ?? this.type,
      words:  words ?? this.words,
      letter: letter ?? this.letter,
      selections:   selections ?? this.selections,
      correctWords: correctWords ?? this.correctWords,
      incorrectWords: incorrectWords ?? this.incorrectWords,
      totalOfCorrect: totalOfCorrect ?? this.totalOfCorrect,
      totalOfPending: totalOfPending ?? this.totalOfPending,
      wrongSelections:   wrongSelections ?? this.wrongSelections,
      correctSelections: correctSelections ?? this.correctSelections,
    );

  }

}