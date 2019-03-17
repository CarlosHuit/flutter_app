
import 'package:redux/redux.dart';
import 'package:app19022019/core/src/redux/app/app_state.dart';
import 'package:app19022019/core/src/redux/login/login_actions.dart';
import 'package:app19022019/core/src/redux/signup/signup_actions.dart';
import './navigation_actions.dart';
import 'key_navigation.dart';
import 'package:page_transition/page_transition.dart';

class NavigationMiddleware extends MiddlewareClass<AppState> {

  @override
  void call(Store<AppState> store, action, NextDispatcher next) {

    if (action is NavigatorReplaceHome) {
      next(LoginRestartData());
      next(SignupRestartData());
      NavigationKey.key.currentState.pushReplacementNamed('/home');
    }

    if (action is NavigatorReplaceSignin) {
      NavigationKey.key.currentState.pushReplacementNamed('/signin');
    }

    if (action is NavigatorPushSignup) {
      next(LoginRestartData());
      NavigationKey.key.currentState.pushNamed('/signup');
    }

    if (action is NavigatorPop) {
      NavigationKey.key.currentState.pop();
    }

    if (action is NavigatorPushCourseDetail) {
      NavigationKey.key.currentState.pushNamed('/course-detail');
    }

    if (action is NavigatorReplaceCourse) {
      final String route = '/courses/${action.course}';
      NavigationKey.key.currentState.pushReplacementNamed(route);
    }


    if (action is NavigatorPushRCLetterDetail) {
      NavigationKey.key.currentState.pushNamed('/courses/lectura/detalle-letra');
    }

    if (action is NavigatorPushRigthToLeft) {

      /// -> /courses/lectura/juego
      NavigationKey.key.currentState.pushReplacement(
        PageTransition(
          type:  PageTransitionType.rightToLeft,
          child: action.screen
        )
      );

    }

    next(action);

  }
  
}