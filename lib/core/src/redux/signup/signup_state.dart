
import 'package:meta/meta.dart';

@immutable
class SignupState {

  final String firstName;
  final String firstNameError;
  final bool hasFirstNameError;

  final String lastName;
  final String lastNameError;
  final bool hasLastNameError;

  final String email;
  final String emailError;
  final bool hasEmailError;

  final String password;
  final String passwordError;
  final bool hasPasswordError;

  final String password2;
  final String password2Error;
  final bool hasPasswor2dError;

  final String avatar;

  final bool hasSignupError;
  final String signupError;

  final bool isLoading;
  final bool canRedirect;

  SignupState({
    @required this.firstName,
    @required this.firstNameError,
    @required this.hasFirstNameError,
    @required this.lastName,
    @required this.lastNameError,
    @required this.hasLastNameError,
    @required this.email,
    @required this.emailError,
    @required this.hasEmailError,
    @required this.password,
    @required this.passwordError,
    @required this.hasPasswordError,
    @required this.password2,
    @required this.password2Error,
    @required this.hasPasswor2dError,
    @required this.hasSignupError,
    @required this.signupError,
    @required this.isLoading,
    @required this.canRedirect,
    @required this.avatar
  });


  SignupState copyWith({
    String firstName,
    String firstNameError,
    bool hasFirstNameError,
    String lastName,
    String lastNameError,
    bool hasLastNameError,
    String email,
    String emailError,
    bool hasEmailError,
    String password,
    String passwordError,
    bool hasPasswordError,
    String password2,
    String password2Error,
    bool hasPasswor2dError,
    bool hasSignupError,
    String signupError,
    bool isLoading,
    bool canRedirect,
    String avatar

  }) {
    return SignupState(

      firstName:          firstName ?? this.firstName,
      firstNameError:     firstNameError ?? this.firstNameError,
      hasFirstNameError:  hasFirstNameError ?? this.hasFirstNameError,

      lastName:         lastName ?? this.lastName,
      lastNameError:    lastNameError ?? this.lastNameError,
      hasLastNameError: hasLastNameError ?? this.hasLastNameError,

      email:         email ?? this.email,
      emailError:    emailError ?? this.emailError,
      hasEmailError: hasEmailError ?? this.hasEmailError,

      password:         password ?? this.password,
      passwordError:    passwordError ?? this.passwordError,
      hasPasswordError: hasPasswordError ?? this.hasPasswordError,

      password2:         password2 ?? this.password2,
      password2Error:    password2Error ?? this.password2Error,
      hasPasswor2dError: hasPasswor2dError ?? this.hasPasswor2dError,

      hasSignupError:    hasSignupError ?? this.hasSignupError,
      signupError:       signupError ?? this.signupError,

      isLoading:   isLoading ?? this.isLoading,
      canRedirect: canRedirect ?? this.canRedirect,
      avatar: avatar ?? this.avatar
    );
  }

  factory SignupState.initialState() {
    return SignupState(

      firstName:         '',
      firstNameError:    '',
      hasFirstNameError: false,

      lastName:         '',
      lastNameError:    '',
      hasLastNameError: false,

      email:         '',
      emailError:    '',
      hasEmailError: false,

      password:         '',
      passwordError:    '',
      hasPasswordError: false,

      password2:         '',
      password2Error:    '',
      hasPasswor2dError: false,

      hasSignupError: false,
      signupError:    '',

      isLoading: false,
      canRedirect: true,
      avatar: 'user'

    );
  }

  bool isValidData() {

    final bool isValidFirstName = firstName.length > 0 && hasFirstNameError == false;
    final bool isValidLastName  = lastName.length > 0 && hasLastNameError == false;
    final bool isValidEmail     = email.length > 0 && hasEmailError == false;
    final bool isValidPassWord  = password.length > 0 && hasPasswordError == false;
    final bool isValidPassword2 = password2.length > 0 && hasPasswor2dError == false;
    final bool isValidData = isValidFirstName && isValidLastName && isValidEmail && isValidPassWord && isValidPassword2;

    return isValidData;
  }

  @override
  bool operator ==(Object other) => 
  identical(this, other) || other is SignupState
    && runtimeType       == other.runtimeType
    && firstName         == other.firstName
    && firstNameError    == other.firstNameError
    && hasFirstNameError == other.hasFirstNameError
    && lastName          == other.lastName
    && lastNameError     == other.lastNameError
    && hasLastNameError  == other.hasLastNameError
    && email             == other.email
    && emailError        == other.emailError
    && hasEmailError     == other.hasEmailError
    && password          == other.password
    && passwordError     == other.passwordError
    && hasPasswordError  == other.hasPasswordError
    && password2         == other.password2
    && password2Error    == other.password2Error
    && hasPasswor2dError == other.hasPasswor2dError
    && hasSignupError    == other.hasSignupError
    && signupError       == other.signupError
    && isLoading         == other.isLoading
    && avatar            == other.avatar
    && canRedirect       == other.canRedirect;

  @override
  int get hashCode => 
    firstName.hashCode ^
    firstNameError.hashCode ^
    hasFirstNameError.hashCode ^
    lastName.hashCode ^
    lastNameError.hashCode ^
    hasLastNameError.hashCode ^
    email.hashCode ^
    emailError.hashCode ^
    hasEmailError.hashCode ^
    password.hashCode ^
    passwordError.hashCode ^
    hasPasswordError.hashCode ^
    password2.hashCode ^
    password2Error.hashCode ^
    hasPasswor2dError.hashCode ^
    hasSignupError.hashCode ^
    signupError.hashCode ^
    isLoading.hashCode ^
    avatar.hashCode ^
    canRedirect.hashCode;

}