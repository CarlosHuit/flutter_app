import 'package:app19022019/core/src/viewmodels/home_view_model.dart';
import 'package:flutter/material.dart';


class MyDrawer extends StatelessWidget {

  final BuildContext context;
  final HomeViewModel viewModel;

  const MyDrawer({Key key, this.context, this.viewModel}) : super(key: key);


  @override
  Widget build(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[

        DrawerHeaderApp(viewModel: viewModel),

        ListTile(
          leading: Icon(Icons.event_note),
          title:   Text('Cursos', style: TextStyle(fontWeight: FontWeight.bold)),
          onTap:   () =>  Navigator.pop(context)
        ),

        ListTile(
          leading: Icon(Icons.collections_bookmark),
          title:   Text('Mis Cursos', style: TextStyle(fontWeight: FontWeight.bold)),
          onTap:   () =>  Navigator.pop(context)
        ),

        ListTile(
          leading: Icon(Icons.calendar_today),
          title:   Text('Calendario', style: TextStyle(fontWeight: FontWeight.bold)),
          onTap:   () =>  Navigator.pop(context)
        ),

        ListTile(
          leading: Icon(Icons.exit_to_app),
          title:   Text('Cerrar Sesion', style: TextStyle(fontWeight: FontWeight.bold)),
          onTap:   () {
            Navigator.pop(context);
            viewModel.logout();
          }
        )
      ],
    ),
  );
  }
}

class UserIcon extends StatelessWidget {

  final HomeViewModel viewModel;

  const UserIcon({Key key, this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width:  60.0,
      height: 60.0,
      margin: EdgeInsets.only(bottom: 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        image:        DecorationImage(
          image: AssetImage('assets/${viewModel.avatar}-min.png')
        ),
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
}

class UserData extends StatelessWidget {

  final HomeViewModel viewModel;

  const UserData({Key key, this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5.0),
      child:  Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Text(
            viewModel.fullName(),
            overflow: TextOverflow.ellipsis,
            style:    TextStyle( fontWeight: FontWeight.bold, fontSize: 28.0 ),
          ),

          Text(
            viewModel.email,
            overflow: TextOverflow.ellipsis,
            style:    TextStyle( fontSize: 14.0 ),
          )

          
        ],

      ),
    );
  }
}



class DrawerHeaderApp extends StatelessWidget {

  final HomeViewModel viewModel;

  const DrawerHeaderApp({Key key, this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            UserIcon(viewModel: viewModel),
            UserData(viewModel: viewModel)
          ],
        ),
      ),

    );
  }
}

