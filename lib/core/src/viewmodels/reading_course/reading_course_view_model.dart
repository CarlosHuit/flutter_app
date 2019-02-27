import 'package:app19022019/core/core.dart';
import 'package:app19022019/core/src/models/reading_course/rc_data_model.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ReadingCourseViewModel {

  final SpeechSynthesisService tts = SpeechSynthesisService();
  final List<String> letters;
  final List<String> learnedLetters;
  final bool isLoading;
  final List<ItemLetterMenu> lettersMenu;

  ReadingCourseViewModel({
    @required this.letters,
    @required this.learnedLetters,
    @required this.isLoading,
    @required this.lettersMenu
  });

  static ReadingCourseViewModel fromStore({@required Store<AppState> store}) {

    return ReadingCourseViewModel(
      letters:        [],
      learnedLetters: [],
      isLoading:      store.state.readingCourseState.isLoading,
      lettersMenu:    store.state.readingCourseState.data.lettersMenu,
    );

  }

  Future<FlutterTts> speak(String term) {
    return tts.speak(term: term, rate: 0.65);
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