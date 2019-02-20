import 'package:meta/meta.dart';

@immutable
class LoginState {
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
  final bool loginSuccessful;

  LoginState({
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
    @required this.loginSuccessful
  });

  factory LoginState.initialState() {
    return LoginState(
      email:            '',
      hasEmailError:    false,
      emailError:       '',
      password:         '',
      hasPasswordError: false,
      passwordError:    '',
      isLoading:        false,
      canRedirect:      true,
      hasLoginError:    false,
      loginError:       '',
      loginSuccessful:  false
    );
  }

  LoginState copyWith({
    String email,
    String emailError,
    bool hasEmailError,
    String password,
    String passwordError,
    bool hasPasswordError,
    bool isLoading,
    bool canRedirect,
    bool hasLoginError,
    String loginError,
    bool loginSuccessful

  }) {

    return LoginState(
      email:            email ?? this.email,
      emailError:       emailError ?? this.emailError,
      hasEmailError:    hasEmailError ?? this.hasEmailError,

      password:         password ?? this.password,
      passwordError:    passwordError ?? this.passwordError,
      hasPasswordError: hasPasswordError ?? this.hasPasswordError,

      isLoading:        isLoading ?? this.isLoading,
      canRedirect:      canRedirect ?? this.canRedirect,
      hasLoginError:    hasLoginError ?? this.hasLoginError,
      loginError:       loginError ?? this.loginError,
      loginSuccessful:  loginSuccessful ?? this.loginSuccessful
    );

  }

  bool isValidData() {
    final bool isValidEmail = email.length > 0 && hasEmailError == false;
    final bool isValidPassword =password.length > 0 && hasPasswordError == false;
    final bool isValidData = isValidEmail && isValidPassword;

    return isValidData; 
  }


  @override
  bool operator == (Object other) =>
  identical(this, other) || other is LoginState
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
    && loginSuccessful  == other.loginSuccessful
    && loginError       == other.loginError;


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
    loginSuccessful.hashCode ^
    loginError.hashCode;
  
}