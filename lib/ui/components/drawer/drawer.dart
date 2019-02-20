import 'package:flutter/material.dart';

Widget myDrawer(BuildContext context) {

  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Text('data'),
          decoration: BoxDecoration(color: Colors.blue),
        ),
        ListTile(
          title: Text('Cursos'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('Cerrar Sesion'),
          onTap: () {
            // update state
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, '/login');
          }
        )
      ],
    ),
  );

}