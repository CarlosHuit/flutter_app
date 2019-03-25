
import 'package:app19022019/core/src/redux/app/app_state.dart';
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
  });

  factory FindLettersViewModel.fromStore(Store<AppState> store) {

    final path = store.state.readingCourseState.findLetters;
    return FindLettersViewModel(
      currentData:       path.currentData,
      currentIndex:      path.currentIndex,
      data:              path.data,
      disableAll:        path.disableAll,
      isSettingData:     path.isSettingData,
      pendings:          path.pendings,
      showCoincidences:  path.showCoincidences,
      showSuccessDialog: path.showSuccessDialog,
      totalOfCorrects:   path.totalOfCorrects,
      currentLetter:     path.currentData.letter
    );

  }


  void selectLetter(String selection) {

    if (selection == currentLetter) {

      tts.speak(term: selection);

    } else {

      AudioService.playAsset(AudioType.incorrect);

    }

  }


  void listenInstructions() {
    final msg = 'Encuentra las letras ${currentData.letter} de la palabra ${currentData.word}';
    tts.speak(term: msg);
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
      && currentLetter     == other.currentLetter
      && pendings          == other.pendings;

  @override
  int get hashCode =>
    data.hashCode      ^
    disableAll.hashCode ^
    currentData.hashCode ^
    currentIndex.hashCode ^
    currentLetter.hashCode ^
    isSettingData.hashCode  ^
    totalOfCorrects.hashCode ^
    showCoincidences.hashCode ^
    showSuccessDialog.hashCode ^
    pendings.hashCode;

}