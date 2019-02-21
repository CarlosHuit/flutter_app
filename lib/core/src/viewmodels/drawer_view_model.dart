import 'package:flutter/material.dart';
import 'package:meta/meta.dart';


class DrawerViewModel {
  

  final String firstName;
  final String lastName;
  final String email;
  final String avatar;
  final List<ItemDrawer> items;


  DrawerViewModel({
    @required this.firstName,
    @required this.lastName,
    @required this.email,
    @required this.avatar,
    @required this.items
  });


}


class ItemDrawer {


  final String item;
  final Icon icon;


  ItemDrawer({
    @required this.item,
    @required this.icon
  });


}