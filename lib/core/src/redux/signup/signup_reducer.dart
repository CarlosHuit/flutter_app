import 'package:app19022019/core/src/utils/utils.dart';

import './signup_actions.dart';
import './signup_state.dart';

SignupState signupReducer(SignupState state, dynamic action) {

  if (action is SignupUpdateFirstName) {

    final StatusValidator validator = AuthValidators.validateFirstName(action.firstName);
    return state.copyWith(
      firstName:         action.firstName,
      hasFirstNameError: validator.hasError,
      firstNameError:    validator.error
    );

  }

  if (action is SignupUpdateLastName) {

    final StatusValidator validator = AuthValidators.validateLastName(action.lastName);
    return state.copyWith(
      lastName:         action.lastName,
      hasLastNameError: validator.hasError,
      lastNameError:    validator.error
    );

  }

  if (action is SignupUpdateEmail) {

    final StatusValidator validator = AuthValidators.validateEmail(action.email); 
    return state.copyWith(
      email:         action.email,
      hasEmailError: validator.hasError,
      emailError:    validator.error
    );

  }

  if (action is SignupUpdatePassword) {

    final StatusValidator validator = AuthValidators.validatePassword(action.password);
    return state.copyWith(
      password:         action.password,
      hasPasswordError: validator.hasError,
      passwordError:    validator.error
    );

  }


  if (action is SignupUpdatePassword2) {

    final StatusValidator validator = AuthValidators.validatePasswordValidator(action.password2, state.password);
    return state.copyWith(
      password2:         action.password2,
      hasPasswor2dError: validator.hasError,
      password2Error:    validator.error
    );

  }


  if ( action is Signup ) {

    return state.copyWith(
      isLoading: true,
      canRedirect: false
    );

  }

  if (action is SignupSuccess) {
    return SignupState.initialState();
  }

  if (action is SignupFailed) {

    return state.copyWith(
      isLoading: false,
      hasSignupError: true,
      signupError: action.error
    );

  }

  if (action is RemoveSignupError) {
    return state.copyWith(
      hasSignupError: false,
      signupError: ''
    );
  }

  if (action is SignupRestartData) {
    return SignupState.initialState();
  }

  return state;

}