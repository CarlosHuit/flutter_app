import 'package:app19022019/core/core.dart';
import 'package:app19022019/core/src/redux/reading_course/reading_course_actions.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

import '../../redux/reading_course/rc_data/rc_data_state.dart';

class ReadingCourseViewModel {

  final SpeechSynthesisService  tts = SpeechSynthesisService();
  final List<String>            letters;
  final bool                    isLoading;
  final List<LearnedLetter>     learnedLetters;
  final List<ItemLetterMenu>    lettersMenu;
  final Function(String letter) startCourse;

  ReadingCourseViewModel({
    @required this.letters,
    @required this.isLoading,
    @required this.startCourse,
    @required this.lettersMenu,
    @required this.learnedLetters,
  });

  static ReadingCourseViewModel fromStore({@required Store<AppState> store}) {

    return ReadingCourseViewModel(
      letters:        [],
      isLoading:      store.state.readingCourseState.data.isLoading,
      lettersMenu:    store.state.readingCourseState.data.lettersMenu,
      learnedLetters: store.state.readingCourseState.data.learnedLetters,
      startCourse:    (String letter) => store.dispatch(RCSelectLetter(letter))
    );

  }

  void speak({ @required String term, double rate }) {
    tts.speak(term, rate: rate ?? .80);
  }

  void speakAlphabetMsg() {

    final msg = 'Este es el abecedario. Selecciona una letra para continuar';
    tts.speak(msg);

  }


  void speakLearnedLetterMsg() {

    final hasLearnedLetters = learnedLetters.length > 0 ? true : false;

    final msg1 = 'Aquí aparecerán las letras que vayas aprendiendo';
    final msg2 = 'Estas son las letras que has aprendido';
    final msg = hasLearnedLetters ? msg2 : msg1; 

    tts.speak(msg);

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