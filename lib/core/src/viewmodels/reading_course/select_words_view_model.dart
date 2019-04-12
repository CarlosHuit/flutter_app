import 'package:app19022019/core/src/redux/app/app_state.dart';
import 'package:app19022019/core/src/redux/navigation/navigation_actions.dart';
import 'package:app19022019/core/src/redux/reading_course/rc_select_words/rc_select_words_actions.dart';
import 'package:app19022019/core/src/services/audio_service.dart';
import 'package:app19022019/core/src/services/speech_synthesis_service.dart';
import 'package:app19022019/ui/reading_course/pronounce_letters/pronounce_letters_screen.dart';
import 'package:meta/meta.dart';
import 'package:page_transition/page_transition.dart';
import 'package:redux/redux.dart';

import '../../redux/reading_course/rc_select_words/rc_select_words_state.dart';

@immutable
class SelectWordsViewModel {

  final SpeechSynthesisService tts = SpeechSynthesisService();
  final List<RCSelectWordsData> data;
  final RCSelectWordsData currentData;
  final bool isSettingData;
  final bool showWellDoneDialog;
  final int currentIndex;
  final double percentPendings;

  final Function(dynamic action) dispatch;
  final String sound;

  SelectWordsViewModel({
    @required this.data,
    @required this.currentData,
    @required this.isSettingData,
    @required this.showWellDoneDialog,
    @required this.currentIndex,
    @required this.dispatch,
    @required this.percentPendings,
    @required this.sound,

  });

  factory SelectWordsViewModel.fromStore(Store<AppState> store) {

    final path = store.state.readingCourseState.selectWords;
    final totalCorrects   = path.currentData.totalOfCorrect;
    final totalPendings   = path.currentData.totalOfPending;
    final percentPendings = (100 - ((totalPendings * 100) / totalCorrects)) * 0.01;

    return SelectWordsViewModel(
      data:               path.data,
      currentData:        path.currentData,
      currentIndex:       path.currentIndex,
      isSettingData:      path.isSettingData,
      showWellDoneDialog: path.showWellDoneDialog,
      percentPendings:    percentPendings,
      dispatch:           (action) => store.dispatch(action),
      sound: path.sound
    );
  }

  void speakWellDone() {
    tts.speak(term: 'Bien Hecho');
  }

  void onSelectWord(String word) {

    if (word.contains(currentData.letter)) {
      dispatch(RCCorrectSelectionSW());
      tts.speak(term: word);
    } else {
      AudioService.playAsset(AudioType.incorrect);
    }

  }

  void speakInstructions() {
    final typeLetter = currentData.type;
    final soundletter = sound;
    final msg = 'Encuentra las palabras que al menos tengan una letra: $soundletter $typeLetter';
    tts.speak(term: msg);
  }

  void changeCurrentData() {
    dispatch(RCChangeCurrentDataSW());
  }

  void redirection() {
    dispatch(
      NavigatorPushReplaceWithTransition(
        screen: PronounceLettersScreen(),
        transition: PageTransitionType.rightToLeft
      )
    );
    
  }

  void showWellDoneDialogApp() {
    dispatch(RCShowWellDoneDialogSW());
  }

  void hideWellDoneDialog() {
    dispatch(RCHideWellDoneDialogSW());
  }

  @override
  bool operator == (Object other) => 
    identical(this, other) || other is SelectWordsViewModel
      && runtimeType == other.runtimeType
      && data == other.data
      && currentData == other.currentData 
      && isSettingData == other.isSettingData 
      && showWellDoneDialog == other.showWellDoneDialog 
      && currentIndex == other.currentIndex
      && percentPendings == other.percentPendings
      && sound == other.sound;

  @override
  int get hashCode => 
    data.hashCode ^
    currentData.hashCode ^
    isSettingData.hashCode ^
    showWellDoneDialog.hashCode ^
    currentIndex.hashCode ^
    percentPendings.hashCode ^
    sound.hashCode;

} 