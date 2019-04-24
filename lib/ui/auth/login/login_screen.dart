import 'package:app19022019/core/src/redux/device/device_actions.dart';
import 'package:app19022019/utils/set_prefered_orientation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import './login_text.dart';
import '../../../core/core.dart';
import '../../../utils/on_back_pressed.dart';

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen> {


  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final OnBackPressed         onBackPressed = OnBackPressed();
  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController =TextEditingController();

  AssetImage providerBackgroundImage;

  @override
  void initState() {

    providerBackgroundImage = AssetImage('assets/background.jpg');
    providerBackgroundImage.resolve(ImageConfiguration()).addListener((i, b){});

    super.initState();

  }


  @override
  void dispose() {
    loginEmailController.dispose();
    loginPasswordController.dispose();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {

    return StoreConnector<AppState, LoginViewModel>(

      distinct:  true,
      onInit:    (store) => store.dispatch(SetDeviceData(context)),
      converter: (store) => LoginViewModel.fromStore( store: store ),
      builder:   (BuildContext _, LoginViewModel viewModel) {

        return WillPopScope(
          
          onWillPop: () => onBackPressed.validation(context),
          child: Scaffold(
            key: _scaffoldKey,
            body: Stack(
              children: <Widget>[

                backgroundImage(),
                login(viewModel),
                showSnackBar(
                  _scaffoldKey,
                  viewModel.hasLoginError,
                  viewModel.loginError
                ),

              ],
            )

          )

        );
      },
    );




  }




  TextStyle styleInput = TextStyle( color: Colors.white, fontSize: 16.0, fontFamily: 'Roboto' );
  TextStyle hintStyle  = TextStyle( color: Colors.white54);
  TextStyle errorStyle = TextStyle( fontSize:  14.0);






  Widget emailField(LoginViewModel viewModel) {


    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        maxLines:     1,
        style:        styleInput,
        keyboardType: TextInputType.emailAddress,
        onChanged:    viewModel.updateEmail,
        controller:   loginEmailController,
        decoration:   InputDecoration(

          prefixIcon: Icon( Icons.account_circle, color: Colors.white ),
          labelText:  LoginText.emailFieldLabelTxt,
          hintText:   LoginText.emailFieldHintTxt,
          hintStyle:  hintStyle,
          labelStyle: styleInput,
          border:     OutlineInputBorder(),
          
          errorText: viewModel.hasEmailError ? viewModel.emailError : null,
          errorStyle: errorStyle,
          errorMaxLines: 2

        ),
      )
    );

  }



  Widget passwordField(LoginViewModel viewModel) {

    return Container(

      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        obscureText:   true,
        style:         styleInput,
        enableInteractiveSelection: false,
        onChanged:     viewModel.updatePassword,
        controller:    loginPasswordController,

        decoration:    InputDecoration(

          prefixIcon:    Icon(Icons.vpn_key, color: Colors.white,),
          hintText:      LoginText.passFieldHintTxt,
          labelText:     LoginText.passFieldLabelTxt,
          hintStyle:     hintStyle,
          labelStyle:    styleInput,
          border:        OutlineInputBorder(),
          errorText:     viewModel.hasPasswordError ? viewModel.passwordError : null,
          errorStyle:    errorStyle,
          errorMaxLines: 2,

        ),

      )

    );

  }



  Widget loginAppTitle() {

    return Container(

      margin: EdgeInsets.symmetric(vertical: 15.0),
      child: Text(
        '${LoginText.appLoginTitle}',
        style: TextStyle(

          fontFamily:   'Pacifico',
          color:        Colors.white,
          fontSize:     48.0,
          fontWeight:   FontWeight.bold,

        ),
      ),

    );

  }



  Widget submitButton(LoginViewModel viewModel, BuildContext context) {


    return Container(

      margin: EdgeInsets.only(top: 10.0, bottom: 15.0),
      child:  MaterialButton(

        color:     Colors.red,
        textColor: Colors.white,
        minWidth:  180.0,
        height:    40.0,
        child:     Text(

          '${LoginText.btnSumbit}',
          style: TextStyle(

            fontWeight: FontWeight.bold,
            fontSize:   16.0,
            
          ),

        ),

        onPressed:  viewModel.isValidData == true && viewModel.isLoading == false ? () async {
          await setOrientationAndSetUIOverlays();
          FocusScope.of(context).requestFocus(new FocusNode());
          viewModel.login();
        } : null
      )

    );

  }



  Widget noRegisteredAccountMsg() {
    return Text(
      '${LoginText.linkSignupMsg}',
      style: TextStyle(
        color: Colors.white,
        fontSize: 16.0
      ),
    );
  }



  Widget registerLink(LoginViewModel viewModel) {

    return InkWell(

      child: Text(
        '${LoginText.linkSignupTxt}',
        style: TextStyle(

          color:      ThemeData().primaryColor,
          fontSize:   16.0,
          fontWeight: FontWeight.bold,

        ),
      ),

      onTap:  viewModel.isLoading ? null : () {
        viewModel.goToSignupScreen();
        loginEmailController.clear();
        loginPasswordController.clear();
      }

    );

  }



  Widget signupRedirection(LoginViewModel viewModel) {

    return Container(

      child:  Row(

        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          noRegisteredAccountMsg(),
          SizedBox( width: 8.0, ),
          registerLink(viewModel),

        ],

      ),
    );

  }



  Widget backgroundImage() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(

          fit:          BoxFit.cover,
          image:        AssetImage("assets/background.jpg"),
          colorFilter:  ColorFilter.mode(Colors.black54, BlendMode.darken )

        ),
      ),
    );
  }



  Widget loadingIndicator( bool isLoading ) {

    return Container(
      height: 25.0,
      width:  25.0,
      child:  isLoading ? CircularProgressIndicator(

        valueColor: AlwaysStoppedAnimation(
          Colors.lightBlue
        )

      ) : null,
    );

  }



  Widget login(LoginViewModel viewModel) {
    return Center(

      child: Container(

        constraints: BoxConstraints(maxWidth: 480.0),
        margin:      EdgeInsets.only(left: 20.0, right: 20.0),
        child:       SingleChildScrollView(
          child: Column(

            children: <Widget>[

              SizedBox( height: 15.0 ),
              loginAppTitle(),              
              emailField(viewModel),
              passwordField(viewModel),
              submitButton(viewModel, context),
              signupRedirection(viewModel),
              SizedBox( height: 15.0 ),
              loadingIndicator(viewModel.isLoading),
              SizedBox( height: 15.0 ),

            ],

          ),
        )

      ),

    );
  }



  Widget showSnackBar(GlobalKey<ScaffoldState> scaffoldKey, bool hasLoginError, String loginError){


    if (hasLoginError == true) {

      scaffoldKey.currentState.hideCurrentSnackBar();
      scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
          content: Text(
            loginError,
            maxLines: 1,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white,
              fontWeight: FontWeight.bold
            )
          )

        )
      );

    }

    return SizedBox();

  }



}