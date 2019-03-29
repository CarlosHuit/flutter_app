
import 'package:app19022019/core/src/redux/app/app_state.dart';
import 'package:app19022019/core/src/redux/reading_course/rc_find_letters/rc_find_letters_actions.dart';
import 'package:app19022019/core/src/redux/reading_course/rc_find_letters/rc_find_letters_state.dart';
import 'package:app19022019/core/src/services/audio_service.dart';
import 'package:app19022019/core/src/services/speech_synthesis_service.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

@immutable
class FindLettersViewModel {

  final SpeechSynthesisService tts = SpeechSynthesisService();

  final List<FLData> data;
  final FLData currentData;
  final int currentIndex;
  final bool isSettingData;
  final bool showSuccessDialog;
  final bool showCoincidences;
  final bool disableAll;
  final int totalOfCorrects;
  final int pendings;
  final String currentLetter;

  final Function(dynamic action) dispatch;

  FindLettersViewModel({
    @required this.data,
    @required this.currentData,
    @required this.currentIndex,
    @required this.isSettingData,
    @required this.showSuccessDialog,
    @required this.showCoincidences,
    @required this.disableAll,
    @required this.totalOfCorrects,
    @required this.pendings,
    @required this.currentLetter,
    @required this.dispatch
  });

  factory FindLettersViewModel.fromStore(Store<AppState> store) {

    final path = store.state.readingCourseState.findLetters;
    return FindLettersViewModel(
      data:              path.data,
      pendings:          path.currentData.pendings,
      disableAll:        path.disableAll,
      currentData:       path.currentData,
      currentIndex:      path.currentIndex,
      isSettingData:     path.isSettingData,
      currentLetter:     path.currentData.letter,
      totalOfCorrects:   path.totalOfCorrects,
      showCoincidences:  path.showCoincidences,
      showSuccessDialog: path.showSuccessDialog,
      dispatch:          (action) => store.dispatch(action),
    );

  }


  void selectLetter(String selection) {

    if (selection == currentLetter) {

      tts.speak(term: selection);
      dispatch( RCSubtractCorrectFL() );

    } else {

      tts.cancel();
      AudioService.playAsset(AudioType.incorrect);

    }

  }


  void listenInstructions() {
    tts.cancel();
    final msg = 'Encuentra las letras: ${currentData.soundLetter} ${currentData.type} de la palabra ${currentData.word}';
    tts.speak(term: msg);
  }


  void listenWord() {
    tts.speak(term: currentData.word);
  }


  void changeCurrentData() {
    print('dispatch Action to change current data');
    dispatch(RCChangeCurrentDataFL());
  }


  @override
  bool operator == (Object other) => 
    identical(this, other) || other is FindLettersViewModel
      && runtimeType       == other.runtimeType
      && data              == other.data
      && currentData       == other.currentData
      && currentIndex      == other.currentIndex
      && isSettingData     == other.isSettingData
      && showSuccessDialog == other.showSuccessDialog
      && showCoincidences  == other.showCoincidences
      && disableAll        == other.disableAll
      && totalOfCorrects   == other.totalOfCorrects
      && pendings          == other.pendings
      && currentLetter     == other.currentLetter;

  @override
  int get hashCode => 
    data.hashCode ^
    currentData.hashCode ^
    currentIndex.hashCode ^
    isSettingData.hashCode ^
    showSuccessDialog.hashCode ^
    showCoincidences.hashCode ^
    disableAll.hashCode ^
    totalOfCorrects.hashCode ^
    pendings.hashCode ^
    currentLetter.hashCode;

}