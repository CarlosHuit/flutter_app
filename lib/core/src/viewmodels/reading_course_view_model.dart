import 'package:app19022019/core/core.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ReadingCourseViewModel {

  final SpeechSynthesisService tts;
  final List<String> letters;
  final List<String> learnedLetters;


  ReadingCourseViewModel({
    @required this.tts,
    @required this.letters,
    @required this.learnedLetters,
  });

  static ReadingCourseViewModel fromStore({@required Store<AppState> store}) {
    return ReadingCourseViewModel(
      tts:            SpeechSynthesisService(),
      letters:        [],
      learnedLetters: [],
    );
  }

  Future<FlutterTts> speak(String term) {
    return tts.speak(term: term);
  }

}