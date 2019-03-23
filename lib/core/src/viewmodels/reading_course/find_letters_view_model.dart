
import 'package:app19022019/core/src/redux/app/app_state.dart';
import 'package:app19022019/core/src/redux/reading_course/rc_find_letters/rc_find_letters_state.dart';
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

  FindLettersViewModel({
    @required this.data,
    @required this.currentData,
    @required this.currentIndex,
    @required this.isSettingData,
    @required this.showSuccessDialog,
    @required this.showCoincidences,
    @required this.disableAll,
    @required this.totalOfCorrects,
    @required this.pendings
  });

/*   factory FindLettersViewModel.fromStore(Store<AppState> store) {
    final path = store.state.
    return FindLettersViewModel(

    );
  } */

}