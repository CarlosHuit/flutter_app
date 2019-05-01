
import 'package:app19022019/core/src/models/auth_login_response.dart';
import 'package:meta/meta.dart';

@immutable
class AuthState {

  final bool   isLoggedIn;
  final String token;
  final String firstName;
  final String lastName;
  final String email;
  final String avatar;
  final String userId;

  AuthState({
    @required this.isLoggedIn,
    @required this.token,
    @required this.lastName,
    @required this.firstName,
    @required this.email,
    @required this.avatar,
    @required this.userId,
  });


  AuthState copyWith({
    bool   isLoggedIn,
    String token,
    String firstName,
    String lastName,
    String email,
    String avatar,
    String userId,
  }) {
    return AuthState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      token:      token      ?? this.token,
      firstName:  firstName  ?? this.firstName,
      lastName:   lastName   ?? this.lastName,
      email:      email      ?? this.email,
      avatar:     avatar     ?? this.avatar,
      userId:     userId     ?? this.userId,
    );
  }

  factory AuthState.initialState({@required AuthLoginResponse auth }) {

    final bool isNull =  auth == null ? true : false;

    return AuthState(
      isLoggedIn: !isNull ? true : false,
      firstName:  !isNull ? auth.firstName : null,
      lastName:   !isNull ? auth.lastName : null,
      token:      !isNull ? auth.token : null,
      email:      !isNull ? auth.email : null,
      avatar:     !isNull ? auth.avatar : null,
      userId:     !isNull ? auth.userId : null, 
    );

  } 

  @override
  bool operator ==(Object other) =>
    identical(this, other) || other is AuthState
      && runtimeType == other.runtimeType
      && isLoggedIn  == other.isLoggedIn
      && firstName   == other.firstName
      && lastName    == other.lastName
      && token       == other.token
      && avatar      == other.avatar
      && email       == other.email
      && userId      == other.userId;

  @override
  int get hashCode =>
    token.hashCode ^
    isLoggedIn.hashCode ^
    firstName.hashCode ^
    lastName.hashCode ^
    avatar.hashCode ^
    email.hashCode ^
    userId.hashCode;

}