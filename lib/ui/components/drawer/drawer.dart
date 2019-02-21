import 'package:flutter/material.dart';

Widget myDrawer(BuildContext context) {

  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[

        drawerHeader(),

        ListTile(
          leading: Icon(Icons.event_note),
          title: Text('Cursos', style: TextStyle(fontWeight: FontWeight.bold)),
          onTap: () =>  Navigator.pop(context)
        ),

        ListTile(
          leading: Icon(Icons.collections_bookmark),
          title: Text('Mis Cursos', style: TextStyle(fontWeight: FontWeight.bold)),
          onTap: () =>  Navigator.pop(context)
        ),

        ListTile(
          leading: Icon(Icons.calendar_today),
          title: Text('Calendario', style: TextStyle(fontWeight: FontWeight.bold)),
          onTap: () =>  Navigator.pop(context)
        ),

        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('Cerrar Sesion', style: TextStyle(fontWeight: FontWeight.bold)),
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

Widget userIcon() {
  return Container(
    width:  60.0,
    height: 60.0,
    margin: EdgeInsets.only(bottom: 5.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(50),
      image:        DecorationImage(image: AssetImage('assets/user_icon.png')),
      border:       Border.all(color: Colors.white, width: 2.0),
      boxShadow: <BoxShadow> [

        BoxShadow(
          color:      Colors.black38,
          blurRadius: 7.0, spreadRadius: 2.0
        )

      ]
    ),
  );
}


Widget userData() {

  return Container(
    margin: EdgeInsets.only(bottom: 5.0),
    child:  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        Text(
          'Carlos Pixtun',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28.0
          ),
        ),

        Text(
          'emox2544@gmail.com',
          style: TextStyle(
            fontSize: 14.0,
          ),
        )

        
      ],
    ),
  );

}

DrawerHeader drawerHeader() {

  return DrawerHeader(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/background-drawer.jpg'),
        fit:   BoxFit.cover
      )
    ),
    child: Container(
      child: Column(
        mainAxisAlignment:  MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          userIcon(),
          userData()
        ],
      ),
    ),
  );

}