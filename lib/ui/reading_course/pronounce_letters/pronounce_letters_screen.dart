import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';

class PronounceLettersScreen extends StatefulWidget {
  @override
  _PronounceLettersScreenState createState() => _PronounceLettersScreenState();
}

class _PronounceLettersScreenState extends State<PronounceLettersScreen> {

  @override
  void initState() {
    super.initState();
    requestePermision();
  }

  Future<void> requestePermision() async {
    // await PermissionHandler().requestPermissions([
    //   PermissionGroup.microphone,
    //   PermissionGroup.speech,
    // ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        alignment: Alignment.center,
        child: Text('PronounceLetter'),
      ),

    );
  }
}