import 'package:app19022019/core/src/redux/app/app_state.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';


class RCLetterDetail {

  final List<SLData> data;
  final SLSelections selections;
  final int          currentIndex;
  final SLData       currentData;
  final bool         isSettingData;
  final bool         showAllCards;
  final bool         hideAllCards;
  final bool         canPlayGame;
  final bool         showSuccessScreen;

  RCLetterDetail({
    @required this.data,
    @required this.selections,
    @required this.canPlayGame,
    @required this.currentData,
    @required this.currentIndex,
    @required this.showAllCards,
    @required this.hideAllCards,
    @required this.isSettingData,
    @required this.showSuccessScreen,

  });

  factory RCLetterDetail.initialState() {
    return RCLetterDetail(
      canPlayGame:       null,
      currentData:       null,
      currentIndex:      null,
      data:              null,
      hideAllCards:      null,
      isSettingData:     null,
      selections:        null,
      showAllCards:      null,
      showSuccessScreen: null,
    );
  }

  RCLetterDetail fromStore(Store<AppState> store) {

    return RCLetterDetail(
      canPlayGame:       false,
      currentData:       SLData('letter', ['data'], 'mayuscula'),
      currentIndex:      0,
      data:              [ SLData('l', ['d'], 'm'), SLData('l', ['d'], 'm') ],
      hideAllCards:      true,
      showAllCards:      false,
      isSettingData:     false,
      selections:        SLSelections('', ''),
      showSuccessScreen: false
    );

  }

  RCLetterDetail copyWith({
    SLSelections selections,
    List<SLData> data,
    SLData currentData,
    bool isSettingData,
    bool showAllCards,
    bool hideAllCards,
    bool canPlayGame,
    bool showSuccessScreen,
    int currentIndex,
  }) {
    return RCLetterDetail(
      data:              data              ?? this.data,
      currentIndex:      currentIndex      ?? this.currentIndex,
      currentData:       currentData       ?? this.currentData,
      selections:        selections        ?? this.selections,
      isSettingData:     isSettingData     ?? this.isSettingData,
      showAllCards:      showAllCards      ?? this.showAllCards,
      hideAllCards:      hideAllCards      ?? this.hideAllCards,
      canPlayGame:       canPlayGame       ?? this.canPlayGame,
      showSuccessScreen: showSuccessScreen ?? this.showSuccessScreen,
    );
  }

  @override
  bool operator == (Object other) =>
    identical(this, other) || other is RCLetterDetail
      && runtimeType       == other.runtimeType
      && data              == data
      && selections        == selections
      && canPlayGame       == canPlayGame
      && currentData       == currentData
      && currentIndex      == currentIndex
      && showAllCards      == showAllCards
      && hideAllCards      == hideAllCards
      && isSettingData     == isSettingData
      && showSuccessScreen == showSuccessScreen;

  @override
  int get hashCode => 
    data.hashCode ^
    selections.hashCode ^
    canPlayGame.hashCode ^
    currentData.hashCode ^
    currentIndex.hashCode ^
    showAllCards.hashCode ^
    hideAllCards.hashCode ^
    isSettingData.hashCode ^
    showSuccessScreen.hashCode;

}



class SLData {

  final String letter;
  final List<String> data;
  final String type;

  SLData(this.letter, this.data, this.type);

  @override
  bool operator == (Object other) => 
    identical(this, other) || other is SLData
       && runtimeType == other.runtimeType
       && letter      == other.letter
       && data        == other.data
       && type        == other.type;

  @override
  int get hashCode => 
    letter.hashCode ^
    data.hashCode ^
    type.hashCode;

}



class SLSelections {

  final String selection1;
  final String selection2;

  SLSelections(this.selection1, this.selection2);

  @override
  bool operator == (Object other) =>
    identical(this, other) || other is SLSelections
      && runtimeType == other.runtimeType
      && selection1 == other.selection1
      && selection2 == other.selection2;
  
  @override
  int get hashCode => 
    selection1.hashCode ^
    selection2.hashCode;

}
