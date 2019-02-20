import 'package:app19022019/core/core.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class SignupViewModel {

  final String firstName;
  final String firstNameError;
  final bool   hasFirstNameError;
  final String lastName;
  final String lastNameError;
  final bool   haslastNameError;
  final String email;
  final String emailError;
  final bool   hasEmailError;
  final String password;
  final String passwordError;
  final bool   hasPasswordError;
  final String password2;
  final String password2Error;
  final bool   hasPasswor2dError;
  final String avatar;
  final bool   hasSignupError;
  final String signupError;
  final bool   isLoading;
  final bool   canRedirect;
  final bool   isValidData;

  final Function(String term) updateFirstName;
  final Function(String term) updateLastName;
  final Function(String term) updateEmail;
  final Function(String term) updatePassword;
  final Function(String term) updatePassword2;
  final Function() signup;


  SignupViewModel({
    @required this.firstName,
    @required this.firstNameError,
    @required this.hasFirstNameError,

    @required this.lastName,
    @required this.lastNameError,
    @required this.haslastNameError,

    @required this.email,
    @required this.emailError,
    @required this.hasEmailError,

    @required this.password,
    @required this.passwordError,
    @required this.hasPasswordError,

    @required this.password2,
    @required this.password2Error,
    @required this.hasPasswor2dError,

    @required this.avatar,

    @required this.hasSignupError,
    @required this.signupError,

    @required this.isLoading,
    @required this.canRedirect,
    @required this.isValidData,

    @required this.updateFirstName,
    @required this.updateLastName,
    @required this.updateEmail,
    @required this.updatePassword,
    @required this.updatePassword2,
    @required this.signup,
  });

  static SignupViewModel fromStore({ @required Store<AppState> store }) {

    return SignupViewModel(
      firstName:         store.state.signupState.firstName,
      firstNameError:    store.state.signupState.firstNameError,
      hasFirstNameError: store.state.signupState.hasFirstNameError,
      lastName:          store.state.signupState.lastName,
      lastNameError:     store.state.signupState.lastNameError,
      haslastNameError:  store.state.signupState.hasLastNameError,
      email:             store.state.signupState.email,
      emailError:        store.state.signupState.emailError,
      hasEmailError:     store.state.signupState.hasEmailError,
      password:          store.state.signupState.password,
      passwordError:     store.state.signupState.passwordError,
      hasPasswordError:  store.state.signupState.hasPasswordError,
      password2:         store.state.signupState.password2,
      password2Error:    store.state.signupState.password2Error,
      hasPasswor2dError: store.state.signupState.hasPasswor2dError,
      avatar:            store.state.signupState.avatar,
      hasSignupError:    store.state.signupState.hasSignupError,
      signupError:       store.state.signupState.signupError,
      isLoading:         store.state.signupState.isLoading,
      canRedirect:       store.state.signupState.canRedirect,
      isValidData:       store.state.signupState.isValidData(),
      updateFirstName:   (term) => store.dispatch( SignupUpdateFirstName(firstName: term)),
      updateEmail:       (term) => store.dispatch( SignupUpdateEmail(email: term)),
      updateLastName:    (term) => store.dispatch( SignupUpdateLastName(lastName: term)),
      updatePassword:    (term) => store.dispatch( SignupUpdatePassword(password: term)),
      updatePassword2:   (term) => store.dispatch( SignupUpdatePassword2(password2: term)),
      signup:            () => store.dispatch( Signup() )
    );

  }

  @override
  bool operator == (Object other) =>
  identical(this, other) || other is SignupViewModel
    && runtimeType        == other.runtimeType
    && firstName          == other.firstName
    && firstNameError     == other.firstNameError
    && hasFirstNameError  == other.hasFirstNameError
    && lastName           == other.lastName
    && lastNameError      == other.lastNameError
    && haslastNameError   == other.haslastNameError
    && email              == other.email
    && emailError         == other.emailError
    && hasEmailError      == other.hasEmailError
    && password           == other.password
    && passwordError      == other.passwordError
    && hasPasswordError   == other.hasPasswordError
    && password2          == other.password2
    && password2Error     == other.password2Error
    && hasPasswor2dError  == other.hasPasswor2dError
    && avatar             == other.avatar
    && hasSignupError     == other.hasSignupError
    && signupError        == other.signupError
    && isLoading          == other.isLoading
    && canRedirect        == other.canRedirect
    && updateFirstName    == other.updateFirstName
    && updateLastName     == other.updateLastName
    && updateEmail        == other.updateEmail
    && updatePassword     == other.updatePassword
    && updatePassword2    == other.updatePassword2
    && isValidData        == other.isValidData
    && signup             == other.signup;

  @override
  int get hashCode => 
    firstName.hashCode ^
    firstNameError.hashCode ^
    hasFirstNameError.hashCode ^
    lastName.hashCode ^
    lastNameError.hashCode ^
    haslastNameError.hashCode ^
    email.hashCode ^
    emailError.hashCode ^
    hasEmailError.hashCode ^
    password.hashCode ^
    passwordError.hashCode ^
    hasPasswordError.hashCode ^
    password2.hashCode ^
    password2Error.hashCode ^
    hasPasswor2dError.hashCode ^
    avatar.hashCode ^
    hasSignupError.hashCode ^
    signupError.hashCode ^
    isLoading.hashCode ^
    isValidData.hashCode ^
    canRedirect.hashCode;

}