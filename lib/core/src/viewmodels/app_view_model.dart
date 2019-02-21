import '../redux/app/app_state.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';


class AppViewModel {

  final String title;
  final bool isLoggedIn;

  AppViewModel({ @required this.title, @required this.isLoggedIn });

  static AppViewModel fromStore( Store<AppState> store ){

    return AppViewModel(
      title:      store.state.appName,
      isLoggedIn: store.state.authState.isLoggedIn
    );

  }


  @override
  bool operator ==(Object other) =>
  identical(this, other) || other is AppViewModel 
    && runtimeType == other.runtimeType
    && isLoggedIn == other.isLoggedIn
    && title == other.title;


  @override
  int get hashCode =>
    title.hashCode ^
    isLoggedIn.hashCode;


}