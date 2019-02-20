
import 'package:key_value_store/key_value_store.dart';
import 'package:meta/meta.dart';

@immutable
class AuthState {

  final bool   isLoggedIn;
  final String token;
  final bool   isLoading;
  final String firstName;
  final String lastName;


  AuthState({
    @required this.isLoggedIn,
    @required this.token,
    @required this.isLoading,
    @required this.lastName,
    @required this.firstName
  });


  AuthState copyWith({
    bool   isLoggedIn,
    String token,
    bool   isLoading,
    String firstName,
    String lastName
  }) {
    return AuthState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      token:      token      ?? this.token,
      isLoading:  isLoading  ?? this.isLoading,
      firstName:  firstName  ?? this.firstName,
      lastName:   lastName   ?? this.lastName
    );
  }

  factory AuthState.initialState({ @required KeyValueStore keyValueStore }) {

    final String token = keyValueStore.getString('token');

    return AuthState(
      isLoading:  false,
      isLoggedIn: token != null ? true : false,
      firstName:  null,
      lastName:   null,
      token:      token != null ? token :null 
    );

  } 

  @override
  bool operator ==(Object other) =>
    identical(this, other) || other is AuthState
      && runtimeType == other.runtimeType
      && isLoggedIn  == other.isLoggedIn
      && firstName   == other.firstName
      && lastName    == other.lastName
      && isLoading   == other.isLoading
      && token       == other.token;

  @override
  int get hashCode => token.hashCode ^ isLoggedIn.hashCode ^ isLoading.hashCode ^ firstName.hashCode ^ lastName.hashCode;

}