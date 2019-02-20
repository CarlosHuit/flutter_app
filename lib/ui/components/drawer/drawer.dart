import 'package:flutter/material.dart';

Widget myDrawer(BuildContext context) {

  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[

        DrawerHeader(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background-drawer.jpg'),
              fit:   BoxFit.cover
            )
          ),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 60.0,
                  height: 60.0,
                  margin: EdgeInsets.only(bottom: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    image: DecorationImage(
                      image: AssetImage('assets/user_icon.png')
                    ),
                    border: Border.all(color: Colors.white, width: 2.0),
                    boxShadow: <BoxShadow> [
                      BoxShadow(color: Colors.black38, blurRadius: 7.0, spreadRadius: 2.0)
                    ]
                  ),
                ),
                Container(
                  child: Text(
                    'Carlos Huit',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28.0
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    'emox2544@gmail.com',
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  )

                )
              ],
            ),
          ),
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