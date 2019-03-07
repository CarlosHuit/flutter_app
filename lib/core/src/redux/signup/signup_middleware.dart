import 'dart:async';

import 'package:redux/redux.dart';

import '../../redux/courses/courses_actions.dart';
import '../../redux/auth/auth_actions.dart';
import '../../redux/signup/signup.dart';
import '../../networking/auth_api.dart';
import '../../redux/app/app.dart';
import '../../models/models.dart';

class SignupMiddleware extends MiddlewareClass<AppState> {

  final AuthApi api;

  SignupMiddleware( this.api );

  @override
  void call(Store<AppState> store, action, NextDispatcher next) async {

    next(action);

    if (action is Signup) {

      final path = store.state.signupState;

      final AccountForm accountForm = AccountForm(
        email:      path.email,
        firstName:  path.firstName,
        lastName:   path.lastName,
        password:   path.password,
        password2:  path.password2,
        avatar:     path.avatar
      );

      try {
 

        final LoginResponse response = await api.signup(accountForm);
        next(SetCourses(courses: response.courses));
        next(PersistAuth(auth: response.auth, screen: 'signup'));


      } catch (e) {

        next( SignupFailed(error: e) );
        Future.delayed(
          Duration(milliseconds: 100),
          () => next( RemoveSignupError() )
        );

      }

    }
  }

}