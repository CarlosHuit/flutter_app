
import 'package:meta/meta.dart';

@immutable
class RCGameState {
  
  final Map<String, dynamic> selection;
  final List<RCGameData> data;
  final RCGameData currentData;
  final bool isSettingData;
  final bool showWellDoneDialog;
  final bool showCoincidences;
  final bool showCorrectLetters;
  final int  currentIndex;

  RCGameState({
    @required this.data,
    @required this.selection,
    @required this.currentData,
    @required this.currentIndex,
    @required this.isSettingData,
    @required this.showCoincidences,
    @required this.showWellDoneDialog,
    @required this.showCorrectLetters,
  });

  factory RCGameState.initialState() {
    return RCGameState(
      data:     null,
      selection:  null,
      currentData:  null,
      currentIndex:   null,
      isSettingData:    null,
      showCoincidences:   null,
      showCorrectLetters:   null,
      showWellDoneDialog:     null,
    );
  }

  RCGameState copyWith({
    Map<String, dynamic> selection,
    List<RCGameData> data,
    RCGameData currentData,
    bool isSettingData,
    bool showWellDoneDialog,
    bool showCoincidences,
    bool showCorrectLetters,
    int  currentIndex,
  }) {
    return RCGameState(
      data:               data     ?? this.data,
      selection:          selection  ?? this.selection,
      currentData:        currentData  ?? this.currentData,
      currentIndex:       currentIndex   ?? this.currentIndex,
      isSettingData:      isSettingData    ?? this.isSettingData,
      showCoincidences:   showCoincidences   ?? this.showCoincidences,
      showWellDoneDialog: showWellDoneDialog   ?? this.showWellDoneDialog,
      showCorrectLetters: showCorrectLetters     ?? this.showCorrectLetters,
    );
  }

  @override
  bool operator == (Object other) => 
    identical(this, other) || other is RCGameState
      && runtimeType == other.runtimeType
      && data     ==   other.data
      && selection  ==   other.selection
      && currentData  ==   other.currentData
      && currentIndex   ==   other.currentIndex
      && isSettingData    ==   other.isSettingData
      && showCoincidences   ==   other.showCoincidences
      && showWellDoneDialog   ==   other.showWellDoneDialog
      && showCorrectLetters     ==   other.showCorrectLetters;

  @override
  int get hashCode =>
    data.hashCode    ^
    selection.hashCode ^
    currentData.hashCode ^
    currentIndex.hashCode  ^
    isSettingData.hashCode   ^
    showCoincidences.hashCode  ^
    showWellDoneDialog.hashCode  ^
    showCorrectLetters.hashCode;

}

class RCGameData {

  final String letter;
  final dynamic data;
  final String type;
  final int correctsValidation;
  final int totalCorrects;
  final int countCorrects;
  final int countIncorrects;
  final int opportunities;

  RCGameData({
    @required this.letter,
    @required this.data,
    @required this.type,
    @required this.correctsValidation,
    @required this.totalCorrects,
    @required this.countCorrects,
    @required this.countIncorrects,
    @required this.opportunities
  });

}