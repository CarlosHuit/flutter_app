import 'package:app19022019/core/src/redux/login/login_actions.dart';
import 'package:app19022019/core/src/redux/navigation/navigation_actions.dart';

import '../redux/app/app.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class LoginViewModel {
  final String email;
  final String emailError;
  final bool hasEmailError;

  final String password;
  final String passwordError;
  final bool hasPasswordError;

  final bool isLoading;
  final bool canRedirect;
  final bool hasLoginError;
  final String loginError;
  final bool isValidData;
  final bool loginSuccessful;

  final Function(String term) updateEmail;
  final Function(String term) updatePassword;
  final Function login;
  final Function goToSignupScreen;

  LoginViewModel({
    @required this.email,
    @required this.emailError,
    @required this.hasEmailError,
    @required this.password,
    @required this.passwordError,
    @required this.hasPasswordError,
    @required this.isLoading,
    @required this.canRedirect,
    @required this.hasLoginError,
    @required this.loginError,
    @required this.updateEmail,
    @required this.updatePassword,
    @required this.isValidData,
    @required this.login,
    @required this.loginSuccessful,
    @required this.goToSignupScreen
  });

  static LoginViewModel fromStore({ @required Store<AppState> store }) {

    return LoginViewModel(
      email:            store.state.loginState.email,
      emailError:       store.state.loginState.emailError,
      hasEmailError:    store.state.loginState.hasEmailError,
      password:         store.state.loginState.password,
      passwordError:    store.state.loginState.passwordError,
      hasPasswordError: store.state.loginState.hasPasswordError,
      isLoading:        store.state.loginState.isLoading,
      canRedirect:      store.state.loginState.canRedirect,
      hasLoginError:    store.state.loginState.hasLoginError,
      loginError:       store.state.loginState.loginError,
      isValidData:      store.state.loginState.isValidData(),
      loginSuccessful:  store.state.loginState.loginSuccessful,
      updateEmail:      (term) => store.dispatch(LoginUpdateEmail(email: term)),
      updatePassword:   (term) => store.dispatch(LoginUpdatePassword(password: term)),
      login:            () => store.dispatch(Login()),
      goToSignupScreen: () => store.dispatch(NavigatorPushSignup())
    );

  }

  @override
  bool operator == (Object other) =>
  identical(this, other) || other is LoginViewModel
    && runtimeType      == other.runtimeType
    && email            == other.email
    && emailError       == other.emailError
    && hasEmailError    == other.hasEmailError
    && password         == other.password
    && passwordError    == other.passwordError
    && hasPasswordError == other.hasPasswordError
    && isLoading        == other.isLoading
    && canRedirect      == other.canRedirect
    && hasLoginError    == other.hasLoginError
    && isValidData      == other.isValidData
    && loginError       == other.loginError
    && loginSuccessful  == other.loginSuccessful;

  @override
  int get hashCode =>
    email.hashCode ^
    emailError.hashCode ^
    hasEmailError.hashCode ^
    password.hashCode ^
    passwordError.hashCode ^
    hasPasswordError.hashCode ^
    isLoading.hashCode ^
    canRedirect.hashCode ^
    hasLoginError.hashCode ^
    isValidData.hashCode ^
    loginSuccessful.hashCode ^
    loginError.hashCode;

}
