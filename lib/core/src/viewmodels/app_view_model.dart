import '../redux/app/app_state.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';


class AppViewModel {

  final String title;
  final String initialRoute;

  AppViewModel({ @required this.title, @required this.initialRoute });

  static AppViewModel fromStore( Store<AppState> store ){

    return AppViewModel(
      title:        store.state.appName,
      initialRoute: store.state.authState.isLoggedIn ? '/home' : '/login'
    );

  }

  /* only properties and runtimeType */
  @override
  bool operator ==(Object other) =>
  identical(this, other) || other is AppViewModel 
    && runtimeType == other.runtimeType
    && title == other.title;

  @override
  int get hashCode => title.hashCode;

}