import '../auth/auth_state.dart';
import './auth_actions.dart';

AuthState authReducer(AuthState state, dynamic action) {

  if (action is PersistAuth) {
    return state.copyWith(
      token:      action.auth.token,
      email:      action.auth.email,
      firstName:  action.auth.firstName,
      lastName:   action.auth.lastName,
      avatar:     action.auth.avatar,
      isLoggedIn: true
    );
  }

  if (action is RemoveAuth) {
    return AuthState.initialState(auth: null);
  }

  if (action is Logout) {
    Future.delayed(Duration(seconds: 1), () {
      return AuthState.initialState(auth: null);
    });
  }

  return state;
}