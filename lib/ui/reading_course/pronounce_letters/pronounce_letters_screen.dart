import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PronounceLettersScreen extends StatefulWidget {
  @override
  _PronounceLettersScreenState createState() => _PronounceLettersScreenState();
}

class _PronounceLettersScreenState extends State<PronounceLettersScreen> {

  bool waitingForPermission;


  @override
  void initState() {
    super.initState();
    waitingForPermission = true;
    validatePermissions();


  }

  void  validatePermissions() async {

    final permissionMic = await PermissionHandler().checkPermissionStatus(PermissionGroup.microphone);

    final permissionSpeech = await PermissionHandler().checkPermissionStatus(PermissionGroup.speech);

    if (permissionMic != PermissionStatus.granted || permissionSpeech != permissionSpeech ) {
      
      final req = await requestePermision();
      print(req);
      final denied = req[PermissionGroup.microphone] != PermissionStatus.granted && req[PermissionGroup.speech] != PermissionStatus.granted;

      if (denied) {
        Navigator.pop(context);
        return;
      }

      setSuccessPermision();
      return;
    }

    setSuccessPermision();
    return;

  }

  void setSuccessPermision() {
    setState(() {
      waitingForPermission = false;
    });
  }

  Future<Map<PermissionGroup, PermissionStatus>> requestePermision() async {
    Map<PermissionGroup, PermissionStatus> status = await PermissionHandler().requestPermissions([
      PermissionGroup.microphone,
      PermissionGroup.speech,
    ]);
    return status;
  }

  @override
  Widget build(BuildContext context) {


    if (waitingForPermission) {

      return Scaffold( body: Container( ) );

    }


    return Scaffold(
      body: Container(
        color: Colors.blue,
      ),
    );


  }


}