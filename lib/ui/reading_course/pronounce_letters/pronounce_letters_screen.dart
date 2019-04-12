import 'package:app19022019/core/src/redux/app/app_state.dart';
import 'package:app19022019/core/src/redux/reading_course/rc_pronounce_letters/rc_pronounce_letters_actions.dart';
import 'package:app19022019/core/src/viewmodels/reading_course/pronounce_letters_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:permission_handler/permission_handler.dart';
import './pronounce_letters_content.dart';

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


    return StoreConnector<AppState, PronounceLettersViewModel>(
      distinct:  true,
      converter: (store) => PronounceLettersViewModel.fromStore(store),
      onInit:    (store) => store.dispatch(RCSetInitialDataPL()),
      builder:   (_, vm) => PronounceLettersContent(vm: vm),
    );


  }


}