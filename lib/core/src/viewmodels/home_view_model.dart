import 'package:app19022019/core/src/redux/app/app_state.dart';
import 'package:app19022019/core/src/redux/auth/auth_actions.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class HomeViewModel {

  final String firstName;
  final String lastName;
  final String email;
  final String avatar;
  final Function() logout;

  HomeViewModel({
    @required this.firstName,
    @required this.lastName,
    @required this.email,
    @required this.avatar,
    @required this.logout
  });

  static HomeViewModel fromStore({@required Store<AppState> store}) {
    return HomeViewModel(
      firstName: store.state.authState.firstName,
      lastName:  store.state.authState.lastName,
      email:     store.state.authState.email,
      avatar:    store.state.authState.avatar,
      logout:    () => store.dispatch(Logout())
    );
  }

  String fullName() => '$firstName $lastName';

  @override
  bool operator == (Object other) =>
  identical(this, other) || other is HomeViewModel
    && runtimeType == other.runtimeType
    && lastName    == other.lastName
    && firstName   == other.firstName
    && avatar      == other.avatar
    && email       == other.email;

  @override
  int get hashCode =>
    firstName.hashCode ^
    lastName.hashCode ^
    avatar.hashCode ^
    email.hashCode;


}