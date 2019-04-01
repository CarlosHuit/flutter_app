import 'package:app19022019/core/src/redux/app/app_state.dart';
import 'package:app19022019/core/src/redux/reading_course/rc_draw_letters/rc_draw_letters.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

@immutable
class DrawLettersViewModel {
  
  final List<RCDrawLetterData> data;
  final RCDrawLetterData currrentData;
  final bool isSettingData;
  final bool showWellDoneDialog;
  final RCDrawLetterPreferences preferences;
  final RCDrawLetterConfigData configData;
  final int currentIndex;
  final bool showHandWriting;

  final Function(dynamic action) dispatch;

  DrawLettersViewModel({
    @required this.data,
    @required this.currrentData,
    @required this.isSettingData,
    @required this.showWellDoneDialog,
    @required this.preferences,
    @required this.configData,
    @required this.currentIndex,
    @required this.showHandWriting,
    @required this.dispatch,
  });

  factory DrawLettersViewModel.fromStore(Store<AppState> store) {

    final path = store.state.readingCourseState.drawLetters;

    return DrawLettersViewModel(
      data:               path.data,
      configData:         path.configData,
      preferences:        path.preferences,
      currentIndex:       path.currentIndex,
      currrentData:       path.currrentData,
      isSettingData:      path.isSettingData,
      showHandWriting:    path.showHandWriting,
      showWellDoneDialog: path.showWellDoneDialog,
      dispatch:           (action) => store.dispatch(action),
    );
  }

  @override
  bool operator ==(Object other) =>
    identical(this, other)  || other is DrawLettersViewModel
      && runtimeType        == other.runtimeType
      && data               == other.data
      && currrentData       == other.currrentData
      && isSettingData      == other.isSettingData
      && showWellDoneDialog == other.showWellDoneDialog
      && preferences        == other.preferences
      && configData         == other.configData
      && currentIndex       == other.currentIndex
      && showHandWriting    == other.showHandWriting;

  @override
  int get hashCode =>
    data.hashCode ^
    currrentData.hashCode ^
    isSettingData.hashCode ^
    showWellDoneDialog.hashCode ^
    preferences.hashCode ^
    configData.hashCode ^
    currentIndex.hashCode ^
    showHandWriting.hashCode;

}