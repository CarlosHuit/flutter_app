
import 'package:app19022019/core/src/models/auth_response_model.dart';
import 'package:app19022019/core/src/models/user_model.dart';
import 'package:meta/meta.dart';

@immutable
class AuthState {

  final bool   isLoggedIn;
  final String token;
  final User   user;

  AuthState({
    @required this.isLoggedIn,
    @required this.token,
    @required this.user,
  });


  AuthState copyWith({
    bool   isLoggedIn,
    String token,
    User   user,
  }) {
    return AuthState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      token:      token      ?? this.token,
      user:       user       ?? this.user,
    );
  }

  factory AuthState.initialState({@required AuthResponse auth }) {

    final bool isNull =  auth == null ? true : false;
    return AuthState(
      isLoggedIn: !isNull ? true : false,
      token:      !isNull ? auth.token : null,
      user:       !isNull ? auth.user : null,
    );

  } 

  @override
  bool operator ==(Object other) =>
    identical(this, other) || other is AuthState
      && runtimeType == other.runtimeType
      && isLoggedIn  == other.isLoggedIn
      && token       == other.token
      && user        == other.user;

  @override
  int get hashCode =>
    token.hashCode ^
    isLoggedIn.hashCode ^
    user.hashCode;
}