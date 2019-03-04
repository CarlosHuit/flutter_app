import 'package:app19022019/core/src/redux/app/app_state.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class LetterDetailViewModel {
  
  final String currentLetter;
  final List<String> letterOptions;

  LetterDetailViewModel( {
    @required this.currentLetter,
    @required this.letterOptions,
  });


  factory LetterDetailViewModel.fromStore(Store<AppState> store) {
    return LetterDetailViewModel(
      currentLetter: null,
      letterOptions: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12']
    );
  }

}