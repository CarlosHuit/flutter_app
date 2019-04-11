import 'package:app19022019/core/src/redux/app/app_state.dart';
import 'package:app19022019/core/src/services/audio_service.dart';
import 'package:app19022019/core/src/services/speech_synthesis_service.dart';
import 'package:meta/meta.dart';
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

  SelectWordsViewModel({
    @required this.data,
    @required this.currentData,
    @required this.isSettingData,
    @required this.showWellDoneDialog,
    @required this.currentIndex
  });

  factory SelectWordsViewModel.fromStore(Store<AppState> store) {
    final path = store.state.readingCourseState.selectWords;
    return SelectWordsViewModel(
      data:               path.data,
      currentData:        path.currentData,
      currentIndex:       path.currentIndex,
      isSettingData:      path.isSettingData,
      showWellDoneDialog: path.showWellDoneDialog
    );
  }


  void onSelectWord(String word) {

    if (word.contains(currentData.letter)) {
      tts.speak(term: word);
    } else {
      AudioService.playAsset(AudioType.incorrect);
    }

  }

  void speakInstructions() {
    final msg = 'Encuentra las palabras que al menos tengan una letra: ${currentData.letter} ${currentData.type}';
  }


  @override
  bool operator == (Object other) => 
    identical(this, other) || other is SelectWordsViewModel
      && runtimeType == other.runtimeType
      && data == other.data
      && currentData == other.currentData 
      && isSettingData == other.isSettingData 
      && showWellDoneDialog == other.showWellDoneDialog 
      && currentIndex == other.currentIndex;

  @override
  int get hashCode => 
    data.hashCode ^
    currentData.hashCode ^
    isSettingData.hashCode ^
    showWellDoneDialog.hashCode ^
    currentIndex.hashCode;

} 