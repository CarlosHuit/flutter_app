import './signup_actions.dart';
import './signup_state.dart';

SignupState signupReducer(SignupState state, dynamic action) {

  if (action is SignupUpdateFirstName) {
    return state.copyWith(firstName: action.firstName);
  }

  if (action is SignupUpdateLastName) {
    return state.copyWith(lastName: action.lastName);
  }

  if (action is SignupUpdateEmail) {
    return state.copyWith(email: action.email);
  }

  if (action is SignupUpdatePassword) {
    return state.copyWith(password: action.password);
  }

  if (action is SignupUpdatePassword2) {
    return state.copyWith(password2: action.password2);
  }

  if ( action is Signup ) {
    return state.copyWith(isLoading: true, canRedirect: false);
  }

  return state;

}