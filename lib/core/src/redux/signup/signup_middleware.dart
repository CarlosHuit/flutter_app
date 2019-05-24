import 'dart:async';
import 'dart:io';

import 'package:app19022019/core/src/models/auth_response_model.dart';
import 'package:app19022019/core/src/models/forms/signup_form_model.dart';
import 'package:redux/redux.dart';

import '../../networking/auth_api.dart';
import '../../redux/app/app.dart';
import '../../redux/auth/auth_actions.dart';
import '../../redux/courses/courses_actions.dart';
import '../../redux/signup/signup.dart';

class SignupMiddleware extends MiddlewareClass<AppState> {

  final AuthApi api;

  SignupMiddleware( this.api );

  @override
  void call(Store<AppState> store, action, NextDispatcher next) async {

    next(action);

    if (action is Signup) {

      final path = store.state.signupState;

      final SignupForm signupForm = new SignupForm(
        email:   path.email,
        avatar:  path.avatar,
        lastName: path.lastName,
        password: path.password,
        firstName: path.firstName,
        password2: path.password2,
      );

      try {
 

        final AuthResponse response = await api.signup(signupForm);

        next(SetCourses(courses: response.courses));
        next(PersistAuth(auth: response, screen: 'signup'));


      } catch (e) {

        if (e is SocketException) {
          next( SignupFailed(error: 'No hay conexion a internet') );
        } else {
          next( SignupFailed(error: e) );
        }

        Future.delayed(
          Duration(milliseconds: 100),
          () => next( RemoveSignupError() )
        );

      }

    }
  }

}