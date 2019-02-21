import '../auth/auth_state.dart';
import './auth_actions.dart';

AuthState authReducer(AuthState state, dynamic action) {

  if (action is PersistAuth) {
    return state.copyWith(
      token:      action.auth.token,
      email:      action.auth.email,
      firstName:  action.auth.firstName,
      lastName:   action.auth.lastName,
      isLoggedIn: true
    );
  }

  if (action is RemoveAuth) {
    return AuthState.initialState(auth: null);
  }

  return state;
}