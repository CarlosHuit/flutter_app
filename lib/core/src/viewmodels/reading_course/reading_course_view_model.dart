import 'package:app19022019/core/core.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ReadingCourseViewModel {

  final SpeechSynthesisService tts = SpeechSynthesisService();
  final List<String> letters;
  final List<String> learnedLetters;
  final bool isLoading;

  ReadingCourseViewModel({
    @required this.letters,
    @required this.learnedLetters,
    @required this.isLoading
  });

  static ReadingCourseViewModel fromStore({@required Store<AppState> store}) {
    return ReadingCourseViewModel(
      letters:        [],
      learnedLetters: [],
      isLoading:      store.state.readingCourseState.isLoading
    );

  }

  Future<FlutterTts> speak(String term) {
    return tts.speak(term: term);
  }

  @override
  bool operator == (Object other) =>
    identical(this, other) || other is ReadingCourseViewModel
      && runtimeType    == other.runtimeType
      && tts            == other.tts
      && letters        == other.letters
      && learnedLetters == other.learnedLetters
      && isLoading      == other.isLoading;

  @override
  int get hashCode => 
    tts.hashCode ^ 
    letters.hashCode ^ 
    learnedLetters.hashCode ^
    isLoading.hashCode;

}