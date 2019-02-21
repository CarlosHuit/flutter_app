import 'package:app19022019/core/src/models/auth_login_response.dart';

import '../auth/auth_state.dart';
import '../signup/signup_state.dart';
import 'package:key_value_store/key_value_store.dart';
import 'package:meta/meta.dart';
import '../login/login.dart';

@immutable
class AppState {


  final AuthState authState;
  final LoginState loginState;
  final SignupState signupState;
  final String appName;

  AppState({
    @required this.authState,
    @required this.appName,
    @required this.loginState,
    @required this.signupState
  });


  factory AppState.initialState({
    @required KeyValueStore keyValueStore,
    @required AuthLoginResponse auth
  }) {

    return AppState(
      appName:      'Weduc',
      authState:    AuthState.initialState(auth: auth),
      loginState:   LoginState.initialState(),
      signupState:  SignupState.initialState()
    );

  }


  AppState copyWith({ AuthState authState }) {
    return AppState(
      appName:      'Weduc',
      authState:    authState ?? this.authState,
      loginState:   loginState ?? this.loginState,
      signupState:  signupState ?? this.signupState
    );
  }

  @override
  bool operator == (Object other) =>
    identical(this, other) || other is AppState
      && runtimeType  == other.runtimeType
      && authState    == other.authState
      && appName      == other.appName
      && loginState   == other.loginState
      && signupState  == other.signupState;

  @override
  int get hashCode =>
    authState.hashCode ^
    appName.hashCode ^
    loginState.hashCode ^
    signupState.hashCode;

}