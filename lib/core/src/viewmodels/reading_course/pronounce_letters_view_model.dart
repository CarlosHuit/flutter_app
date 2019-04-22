import 'package:app19022019/core/src/redux/app/app_state.dart';
import 'package:app19022019/core/src/redux/navigation/navigation_actions.dart';
import 'package:app19022019/core/src/redux/reading_course/rc_pronounce_letters/rc_pronounce_letters_actions.dart';
import 'package:app19022019/core/src/redux/reading_course/rc_pronounce_letters/rc_pronounce_letters_state.dart';
import 'package:app19022019/core/src/services/speech_synthesis_service.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';


@immutable
class PronounceLettersViewModel {

  final SpeechSynthesisService  tts = SpeechSynthesisService();
  final List<RCPronounceLettersData> data;
  final RCPronounceLettersData currentData;
  final int currentIndex;
  final bool showWellDoneDialog;
  final bool isRecording;
  final bool isSettingData;
  final Function(dynamic action) dispatch;


  PronounceLettersViewModel({
    @required this.data,
    @required this.currentData,
    @required this.currentIndex,
    @required this.showWellDoneDialog,
    @required this.isRecording,
    @required this.isSettingData,
    @required this.dispatch,
  });


  factory PronounceLettersViewModel.fromStore(Store<AppState> store) {

    final path = store.state.readingCourseState.pronounceLetters;

    return PronounceLettersViewModel(
      currentData:        path.currentData,
      data:               path.data,
      currentIndex:       path.currentIndex,
      isRecording:        path.isRecording,
      isSettingData:      path.isSettingData,
      showWellDoneDialog: path.showWellDoneDialog,
      dispatch:           (action) => store.dispatch(action),
    );

  }


  void speakInstructions() {
    final msg = 'Presiona el micrófono y di cuál es esta letra.';
    tts.speak(term: msg);
  }


  void speakHelp() {
    final msg = 'Esta es la letra: ${currentData.letterSound} ${currentData.letterType}';
    tts.speak(term: msg);
  }


  void speakMessageTryAgain() {
    final msg = 'Inténtalo nuevamente, si necesitas ayuda presiona el botón azul.';
    tts.speak(term: msg);
  }


  void speakMessageWrongRecogntion() {
    final msg = 'Si dijiste algo no se escuchó, Inténtalo nuevamente';
    tts.speak(term: msg);
  }


  void changeCurrentData() {
    dispatch(RCChangeCurrentDataPL());
  }


  void navigateToReadingCourseHome() {
    dispatch(NavigatorPop());
  }


  @override
  bool operator == (Object other) =>
    identical(this, other)  || other is PronounceLettersViewModel
      && runtimeType        == other.runtimeType
      && data               == other.data
      && currentData        == other.currentData
      && currentIndex       == other.currentIndex
      && showWellDoneDialog == other.showWellDoneDialog
      && isRecording        == other.isRecording
      && isSettingData      == other.isSettingData;

  @override
  int get hashCode =>
    data.hashCode ^
    currentData.hashCode ^
    currentIndex.hashCode ^
    showWellDoneDialog.hashCode ^
    isRecording.hashCode ^
    isSettingData.hashCode;

}