
import 'package:app19022019/core/src/redux/app/app_state.dart';
import 'package:app19022019/core/src/redux/reading_course/rc_game/rc_game_state.dart';
import 'package:app19022019/core/src/services/audio_service.dart';
import 'package:app19022019/core/src/services/speech_synthesis_service.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

@immutable
class GameViewModel {

  final SpeechSynthesisService tts = SpeechSynthesisService(); 
  final Map<String, dynamic> selection;
  final List<RCGameData> data;
  final RCGameData currentData;
  final bool isSettingData;
  final bool showWellDoneDialog;
  final bool showCoincidences;
  final bool showCorrectLetters;
  final int  currentIndex;


  GameViewModel({
    @required this.selection,
    @required this.data,
    @required this.currentData,
    @required this.isSettingData,
    @required this.showWellDoneDialog,
    @required this.showCoincidences,
    @required this.showCorrectLetters,
    @required this.currentIndex
  });

  factory GameViewModel.fromStore(Store<AppState> store) {

    final path = store.state.readingCourseState.game;

    return GameViewModel(
      data:               path.data,
      selection:          path.selections,
      currentData:        path.currentData,
      currentIndex:       path.currentIndex,
      isSettingData:      path.isSettingData,
      showCoincidences:   path.showCoincidences,
      showWellDoneDialog: path.showWellDoneDialog,
      showCorrectLetters: path.showCorrectLetters,
    );

  } 

  void selectOption(String letter) {

    final correctLetter = currentData.letter;
    final type = currentData.type;

    if (letter == correctLetter) {
      tts.speak(term: '$letter $type');
    } else {
      tts.cancel();
      AudioService.playAsset(AudioType.incorrect);
    }

  }

  @override
  bool operator ==(Object other) =>
    identical(this, other) || other is GameViewModel
      && runtimeType        == other.runtimeType
      && selection          == other.selection
      && data               == other.data
      && currentData        == other.currentData
      && isSettingData      == other.isSettingData
      && showWellDoneDialog == other.showWellDoneDialog
      && showCoincidences   == other.showCoincidences
      && showCorrectLetters == other.showCorrectLetters
      && currentIndex       == other.currentIndex;

  @override
  int get hashCode =>
    selection.hashCode ^
    data.hashCode ^
    currentData.hashCode ^
    isSettingData.hashCode ^
    showWellDoneDialog.hashCode ^
    showCoincidences.hashCode ^
    showCorrectLetters.hashCode ^
    currentIndex.hashCode;



}