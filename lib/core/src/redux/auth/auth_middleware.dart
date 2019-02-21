import 'dart:convert';

import 'package:app19022019/core/src/redux/login/login_actions.dart';
import 'package:app19022019/core/src/redux/navigation/navigation_actions.dart';
import 'package:app19022019/core/src/redux/signup/signup_actions.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../redux/app/app_state.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import './auth_actions.dart';

class AuthMiddleware extends MiddlewareClass<AppState> {

  final FlutterSecureStorage secureStorage;
  AuthMiddleware({@required this.secureStorage});

  @override
  Future<Null> call(Store<AppState> store, action, NextDispatcher next) async{
    
    next(action);

    if ( action is  PersistAuth) {

      try {
  
        final authEncoded = json.encode(action.auth.toJson());
        await secureStorage.write(key: 'auth', value: authEncoded);

        if (action.screen == 'login')
          next(LoginSuccess(authLoginResponse: action.auth));
        
        if (action.screen == 'signup')
          next(SignupSuccess(authLoginResponse: action.auth));

        next(NavigatorReplaceHome());

      } catch (e) {

        if (action.screen == 'login') {
          next(LoginFailed(error: 'Error al autenticar'));
          Future.delayed(Duration(milliseconds: 100), () => next(RemoveLoginError()));
        }

        if(action.screen == 'signup') {
          next(SignupFailed(error: 'Error al autenticar'));
          Future.delayed(Duration(milliseconds: 100), () => next(RemoveSignupError()));
        }

      }
    }
    

  }
  
}