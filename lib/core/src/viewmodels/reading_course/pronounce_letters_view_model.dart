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
  final String pronunciation;


  PronounceLettersViewModel({
    @required this.data,
    @required this.currentData,
    @required this.currentIndex,
    @required this.showWellDoneDialog,
    @required this.isRecording,
    @required this.isSettingData,
    @required this.dispatch,
    @required this.pronunciation,
  });


  factory PronounceLettersViewModel.fromStore(Store<AppState> store) {

    final path = store.state.readingCourseState.pronounceLetters;
    final pr = '${path.currentData.letter} ${path.currentData.letterType}'.toLowerCase();

    return PronounceLettersViewModel(
      currentData:        path.currentData,
      data:               path.data,
      currentIndex:       path.currentIndex,
      isRecording:        path.isRecording,
      isSettingData:      path.isSettingData,
      showWellDoneDialog: path.showWellDoneDialog,
      dispatch:           (action) => store.dispatch(action),
      pronunciation:      pr,
    );

  }


  void speakInstructions() {

    final msg = 'Presiona el micrófono y di cuál es esta letra.';
    tts.speak(msg);

  }


  void speakHelp() {

    final msg = 'Esta es la letra: ${currentData.letterSound} ${currentData.letterType}';
    tts.speak(msg, rate: 0.85);

  }


  void stopTts() {

    tts.cancel();

  }


  void speakWellDone() {

    final msg = 'Bien Hecho';
    tts.speak(msg, rate: 0.8);

  }


  void speakMessageTryAgain() {

    final msg = 'Inténtalo nuevamente... Si necesitas ayuda presiona el botón azul.';
    tts.speak(msg);

  }


  void speakMessageWrongRecogntion() {

    final msg = 'Si dijiste algo no se escuchó... Inténtalo nuevamente';
    tts.speak(msg);

  }


  void handleAndroidRecognitionError(int code) {


    final androidErrorCodes = {
      1: 'ERROR_NETWORK_ERROR',
      2: 'ERROR_NETWORK',
      3: 'ERROR_AUDIO',
      4: 'ERROR_SERVER',
      5: 'ERROR_CLIENT',
      6: 'ERROR_SPEECH_TIMEOUT',
      7: 'ERROR_NO_MATCH',
      8: 'ERROR_RECOGNIZER_BUSY',
      9: 'ERROR_INSUFICIENT_PERMISSIONS'
    };

    print(androidErrorCodes[code]);

    if (code == 7 || code == 6) {
      speakMessageWrongRecogntion();
    }


  }


  void handleIOSRecognitionError() {
    speakMessageWrongRecogntion();
  }


  /// [ void ] validate result on succesful speech recognition
  /// The argument `term` is required
  void validateResult(String term) {

    if (term.contains(pronunciation)) {
      dispatch(RCShowWellDoneDilalogPL());
      return;
    }

    speakMessageTryAgain();
    return;


  }


  /// [ void ] Dispatch action to toggle state of speech recognition
  void setRecordingState(bool state) => dispatch(RCToggleRecordingStatePL(state));


  /// [ void ] dispacth action to change current data
  void changeCurrentData() => dispatch(RCChangeCurrentDataPL());


  /// [ void ] dispatch action to remove current page of tha stack of routes
  void navigateToReadingCourseHome() => dispatch(NavigatorPop());


  /// [ void ] Dispatch action to register new attempt
  void registerAttempt() => dispatch(RCRegisterAttemptPL());


  /// [ void ] Dispatch action to show well done dialog
  void showDialog() => dispatch(RCShowWellDoneDilalogPL());


  /// [ void ] Dispacth action to hide well done dialog
  void hideDialog() => dispatch(RCHideWellDoneDialogPL());


  @override
  bool operator == (Object other) =>
    identical(this, other)  || other is PronounceLettersViewModel
      && runtimeType        == other.runtimeType
      && data               == other.data
      && currentData        == other.currentData
      && currentIndex       == other.currentIndex
      && showWellDoneDialog == other.showWellDoneDialog
      && isRecording        == other.isRecording
      && isSettingData      == other.isSettingData
      && pronunciation      == other.pronunciation;

  @override
  int get hashCode =>
    data.hashCode ^
    currentData.hashCode ^
    currentIndex.hashCode ^
    showWellDoneDialog.hashCode ^
    isRecording.hashCode ^
    isSettingData.hashCode ^
    pronunciation.hashCode;

}