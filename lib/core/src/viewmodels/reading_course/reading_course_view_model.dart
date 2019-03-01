import 'dart:async';

import 'package:app19022019/core/core.dart';
import 'package:app19022019/core/src/models/reading_course/rc_data_model.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ReadingCourseViewModel {

  final SpeechSynthesisService tts = SpeechSynthesisService();
  final List<String>            letters;
  final bool                    isLoading;
  final List<LearnedLetter>     learnedLetters;
  final List<ItemLetterMenu>    lettersMenu;
  final Function(String letter) startCourse;

  ReadingCourseViewModel({
    @required this.letters,
    @required this.learnedLetters,
    @required this.isLoading,
    @required this.lettersMenu,
    @required this.startCourse
  });

  static ReadingCourseViewModel fromStore({@required Store<AppState> store}) {

    return ReadingCourseViewModel(
      letters:        [],
      isLoading:      store.state.readingCourseState.isLoading,
      lettersMenu:    store.state.readingCourseState.data.lettersMenu,
      learnedLetters: store.state.readingCourseState.data.learnedLetters,
      startCourse:    (String letter) => store.dispatch(NavigatorPushRCLetterDetail())
    );

  }

  Future<FlutterTts> speak({ @required String term, double rate }) {
    return tts.speak(term: term, rate: rate ?? 0.65);
  }


  @override
  bool operator == (Object other) =>
    identical(this, other) || other is ReadingCourseViewModel
      && runtimeType    == other.runtimeType
      && tts            == other.tts
      && letters        == other.letters
      && learnedLetters == other.learnedLetters
      && isLoading      == other.isLoading
      && lettersMenu    == other.lettersMenu;

  @override
  int get hashCode => 
    tts.hashCode ^ 
    letters.hashCode ^ 
    learnedLetters.hashCode ^
    isLoading.hashCode ^ 
    lettersMenu.hashCode;

}