
import 'package:app19022019/core/src/redux/app/app_state.dart';
import 'package:app19022019/core/src/redux/reading_course/rc_game/rc_game_actions.dart';
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

  final int totalCorrects;
  final int pendings;

  final int countCorrects;
  final int countIncorrects;
  final double percentPendings;

  final Function(dynamic action) dispatch;

  GameViewModel({
    @required this.selection,
    @required this.data,
    @required this.currentData,
    @required this.isSettingData,
    @required this.showWellDoneDialog,
    @required this.showCoincidences,
    @required this.showCorrectLetters,
    @required this.currentIndex,
    @required this.totalCorrects,
    @required this.pendings,
    @required this.countCorrects,
    @required this.countIncorrects,
    @required this.percentPendings,
    @required this.dispatch
  });

  factory GameViewModel.fromStore(Store<AppState> store) {

    final path = store.state.readingCourseState.game;
    final totalCorrects = path.currentData.totalCorrects;
    final totalPendings = path.currentData.correctsValidation;


    final percentPendings = (100 - ((totalPendings * 100) / totalCorrects)) * 0.01;
    print('tc: $totalCorrects tp: $totalPendings %: $percentPendings');


    return GameViewModel(
      data:               path.data,
      selection:          path.selections,
      currentData:        path.currentData,
      currentIndex:       path.currentIndex,
      isSettingData:      path.isSettingData,
      showCoincidences:   path.showCoincidences,
      showWellDoneDialog: path.showWellDoneDialog,
      showCorrectLetters: path.showCorrectLetters,
      totalCorrects:      totalCorrects,
      pendings:           totalPendings,
      countCorrects:      path.currentData.countCorrects,
      countIncorrects:    path.currentData.countIncorrects,
      percentPendings:    percentPendings,
      dispatch:          (action) => store.dispatch(action),
    );

  }

  void selectOption(String letter) {

    final correctLetter = currentData.letter;
    final type = currentData.type;


    if (letter == correctLetter) {

      print('Total pengings: ${pendings - 1}');
      // final p =pendings - 1;
      // if (p > 0) {
      //   print('puuuuuuuuuuuuuuuuuuum');
      // }
      dispatch( RCRegisterCorrectSelectionG(letter: letter) );
      print('correct selection');
      tts.speak(term: '$letter $type');

    } else {

      dispatch( RCRegisterWrongSelectionG(letter: letter) );
      print('wrong selection');
      tts.cancel();
      AudioService.playAsset(AudioType.incorrect);

    }

  }

  @override
  bool operator ==(Object other) =>
    identical(this, other) || other is GameViewModel
      && runtimeType         == other.runtimeType
      &&  selection          == other.selection
      &&  data               == other.data
      &&  currentData        == other.currentData
      &&  isSettingData      == other.isSettingData
      &&  showWellDoneDialog == other.showWellDoneDialog
      &&  showCoincidences   == other.showCoincidences
      &&  showCorrectLetters == other.showCorrectLetters
      &&  currentIndex       == other.currentIndex
      &&  totalCorrects      == other.totalCorrects
      &&  pendings           == other.pendings
      &&  countCorrects      == other.countCorrects
      &&  countIncorrects    == other.countIncorrects
      &&  percentPendings    == other.percentPendings;


  @override
  int get hashCode =>
    selection.hashCode ^
    data.hashCode ^
    currentData.hashCode ^
    isSettingData.hashCode ^
    showWellDoneDialog.hashCode ^
    showCoincidences.hashCode ^
    showCorrectLetters.hashCode ^
    currentIndex.hashCode ^
    totalCorrects.hashCode ^
    pendings.hashCode ^
    countCorrects.hashCode ^
    countIncorrects.hashCode ^
    percentPendings.hashCode;


}