import '../login/login_state.dart';
import './login_actions.dart';
import '../../utils/utils.dart';

LoginState loginReducer(LoginState state, dynamic action) {


  if (action is LoginUpdateEmail){

    final StatusValidator validator = AuthValidators.validateEmail(action.email);
    print('email is: ${state.email}');

    return state.copyWith(
      email:         action.email,
      hasEmailError: validator.hasError,
      emailError:    validator.error
    );

  }
  
  if (action is LoginUpdatePassword) {

    final StatusValidator validator = AuthValidators.validatePassword(action.password);

    return state.copyWith(
      password:         action.password,
      hasPasswordError: validator.hasError,
      passwordError:    validator.error
    );

  } 
  
  if (action is Login) {

    return state.copyWith(isLoading: true);

  } 
  
  if ( action is LoginFailed ) {

    print('login failed');

    return state.copyWith(
      isLoading:     false,
      hasLoginError: true,
      loginError: action.error
    );

  }
  
  if ( action is LoginSuccess ) {

    return state.copyWith(
      isLoading: false,
      loginSuccessful: true
    );

  }

  return state;
}