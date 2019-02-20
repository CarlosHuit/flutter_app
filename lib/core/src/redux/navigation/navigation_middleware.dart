
import 'package:app19022019/core/src/redux/app/app_state.dart';
import 'package:app19022019/core/src/redux/navigation/navigation_actions.dart';
import 'package:redux/redux.dart';
import 'key_navigation.dart';

class NavigationMiddleware extends MiddlewareClass<AppState> {

  @override
  void call(Store<AppState> store, action, NextDispatcher next) {

    if (action is NavigateToHome) {
      NavigationKey.key.currentState.pushReplacementNamed('/home');
    }

    if (action is NavigateToSignin) {
      NavigationKey.key.currentState.pushReplacementNamed('/signin');
    }

    if (action is NavigateToSignup) {
      NavigationKey.key.currentState.pushNamed('/signup');
    }

    if (action is NavigatePop) {
      NavigationKey.key.currentState.pop();
    }

    next(action);

  }
  
}