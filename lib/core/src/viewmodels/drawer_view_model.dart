import 'package:app19022019/core/src/redux/app/app_state.dart';
import 'package:app19022019/core/src/redux/auth/auth_actions.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';


class DrawerViewModel {
  

  final String firstName;
  final String lastName;
  final String email;
  final String avatar;
  final List<ItemDrawer> items;
  final Function() logout;


  DrawerViewModel({
    @required this.firstName,
    @required this.lastName,
    @required this.email,
    @required this.avatar,
    @required this.items,
    @required this.logout,
  });

  factory DrawerViewModel.fromStore(Store<AppState> store) {
    return DrawerViewModel(
      avatar:    store.state.authState.avatar,
      email:     store.state.authState.email,
      firstName: store.state.authState.firstName,
      lastName:  store.state.authState.lastName,
      logout:    () => store.dispatch(Logout()),
      items:     null
    );
  }

  String fullName() => '$firstName $lastName'; 

  @override
  bool operator == (Object other) =>
    identical(this, other) || other is DrawerViewModel
      && runtimeType == other.runtimeType
      && firstName == other.firstName
      && lastName == other.lastName
      && email == other.email
      && avatar == other.avatar
      && items == other.items;

  @override
  int get hashCode => 
    firstName.hashCode ^
    lastName.hashCode ^
    email.hashCode ^
    avatar.hashCode ^
    items.hashCode;

}


class ItemDrawer {


  final String item;
  final Icon icon;


  ItemDrawer({
    @required this.item,
    @required this.icon
  });


}