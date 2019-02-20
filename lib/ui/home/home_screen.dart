import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            Text(
              'Hello from HomeScreen',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 36.0,
                fontWeight: FontWeight.bold
              ),
            ),

            RaisedButton(
              color: Colors.red,
              textColor: Colors.white,
              child: Text(
                'DeleteToken',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () async{
                final FlutterSecureStorage storage = FlutterSecureStorage();
                await storage.delete(key: 'token');
                final String token = await storage.read(key: 'token');
                print('The CurrentToken is $token');
              },
            )

          ],
        ),
      ),
    );
  }
}