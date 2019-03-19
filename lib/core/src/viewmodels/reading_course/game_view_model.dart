
import 'package:app19022019/core/src/redux/app/app_state.dart';
import 'package:app19022019/core/src/services/audio_service.dart';
import 'package:app19022019/core/src/services/speech_synthesis_service.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

@immutable
class GameViewModel {

  final SpeechSynthesisService tts = SpeechSynthesisService(); 
  final String letter;

  GameViewModel({
    @required this.letter
  });

  factory GameViewModel.fromStore(Store<AppState> store) {
    return GameViewModel(
      letter: 'a'
    );
  } 

  void selectOption(String letterId) {

    if (letterId[0] ==letter) {
      tts.speak(term: letter);
    } else {
      AudioService.playAsset(AudioType.incorrect);
    }

  }

  @override
  bool operator ==(Object other) =>
    identical(this, other) || other is GameViewModel
      && runtimeType == other.runtimeType
      && letter == other.letter;

  @override
  int get hashCode =>
    letter.hashCode;



}