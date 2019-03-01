import 'dart:async';

import 'package:app19022019/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import './signup_text.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {


  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {

    hideStatusBar();

    return StoreConnector<AppState, SignupViewModel>(
      distinct: true,
      onDispose: (store) => store.dispatch(SignupRestartData()),
      converter: (store) => SignupViewModel.fromStore(store: store),
      builder: (BuildContext _, SignupViewModel viewModel) {

        return Scaffold(

          key: _scaffoldKey,
          body: Stack(
            children: <Widget>[
              backgroundImage(),
              signup(viewModel),
              showSnackBar(
                _scaffoldKey,
                viewModel.hasSignupError,
                viewModel.signupError
              ),
            ]
          ),

        );        

      },
    );

  }


  TextStyle styleInput = TextStyle( color: Colors.white, fontSize: 16.0, fontFamily: 'Roboto' );
  TextStyle hintStyle  = TextStyle( color: Colors.white54 );



  Future hideStatusBar() {

    return Future.delayed(Duration(milliseconds: 10), () {

      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Colors.transparent
        )
      );

    });

  }



  Widget signupAppTitle() {

    return Container(

      child: Text(
        '${SignupText.appSignupTitle}',
        style: TextStyle(

          fontFamily:   'Pacifico',
          color:        Colors.white,
          fontSize:     48.0,
          fontWeight:   FontWeight.bold,

        ),
      ),

    );

  }



  Widget firstNameField(SignupViewModel viewModel) {

    return Container(
      margin: EdgeInsets.symmetric(vertical: 7.5),
      child: TextField(

        style:      styleInput,
        onChanged:  viewModel.updateFirstName,
        maxLines:   1,
        decoration: InputDecoration(

          prefixIcon: Icon(Icons.account_box, color: Colors.white,),
          labelText:  SignupText.firstNameLabelTxt,
          hintText:   SignupText.firstNameHintTxt,
          hintStyle:  hintStyle,
          labelStyle: styleInput,
          border:     OutlineInputBorder(),

          errorText: viewModel.hasFirstNameError
            ? viewModel.firstNameError
            : null

        ),
      )

    );

  }



  Widget lastNameField( SignupViewModel viewModel ) {

    return Container(

      margin: EdgeInsets.symmetric(vertical: 7.5),
      child: TextField(

        maxLines:   1,
        style:      styleInput,
        onChanged:  viewModel.updateLastName,
        decoration: InputDecoration(

          prefixIcon: Icon(Icons.account_box, color: Colors.white,),
          labelText:  SignupText.lastNameLabelTxt,
          hintText:   SignupText.lastNameHintTxt,
          hintStyle:  hintStyle,
          labelStyle: styleInput,
          border:     OutlineInputBorder(),

          errorText:  viewModel.haslastNameError
            ? viewModel.lastNameError
            : null

        ),

      )

    );

  }



  Widget emailField( SignupViewModel viewModel ) {

    return Container(

      margin: EdgeInsets.symmetric(vertical: 7.5),
      child: TextField(

        maxLines:     1,
        style:        styleInput,
        keyboardType: TextInputType.emailAddress,
        onChanged:    viewModel.updateEmail,

        decoration: InputDecoration(

          prefixIcon: Icon(Icons.email, color: Colors.white,),
          labelText:  SignupText.emailFieldLabelTxt,
          hintText:   SignupText.emailFieldHintTxt,
          hintStyle:  hintStyle,
          labelStyle: styleInput,
          border:     OutlineInputBorder(),
          errorText:  viewModel.hasEmailError
            ? viewModel.emailError
            : null

        ),

      )

    );

  }



  Widget passwordField( SignupViewModel viewModel ) {

    return Container(

      margin: EdgeInsets.symmetric(vertical: 7.5),
      child:  TextField(

        maxLines:     1,
        obscureText:  true,
        onChanged:    viewModel.updatePassword,
        style:        styleInput,
        enableInteractiveSelection: false,
        decoration: InputDecoration(

          prefixIcon: Icon(Icons.vpn_key, color: Colors.white,),
          labelStyle: styleInput,
          labelText:  SignupText.passwordFieldLabelTxt,
          hintText:   SignupText.passwordFieldHintTxt,
          hintStyle:  hintStyle,
          border:     OutlineInputBorder(),
          errorText:  viewModel.hasPasswordError ? viewModel.passwordError : null

        ),
      )

    );

  }



  Widget password2Field( SignupViewModel viewModel ) {

    return Container(
      margin: EdgeInsets.symmetric(vertical: 7.5),
      child: TextField(

        style:       styleInput,
        maxLines:    1,
        obscureText: true,
        onChanged:   viewModel.updatePassword2,
        enableInteractiveSelection: false,
        decoration: InputDecoration(

          prefixIcon: Icon(Icons.vpn_key, color: Colors.white,),
          labelText:  SignupText.password2FieldLabelTxt,
          hintText:   SignupText.password2FieldHintTxt,
          hintStyle:  hintStyle,
          labelStyle: styleInput,
          border:     OutlineInputBorder(),
          errorText: viewModel.hasPasswor2dError ? viewModel.password2Error : null

        ),
      )

    );

  }



  Widget submitButton(SignupViewModel viewModel, BuildContext context) {


    Function registerAccount = () {
      FocusScope.of(context).requestFocus(new FocusNode());
      viewModel.signup();
    };

    return Container(

      margin: EdgeInsets.symmetric(vertical: 10.0),
      child:  MaterialButton(

        color:     Colors.red,
        textColor: Colors.white,
        minWidth:  180.0,
        height:    40.0,
        child:     Text(

          '${SignupText.btnSumbitSignup}',
          style: TextStyle(

            fontWeight: FontWeight.bold,
            fontSize:   16.0,
            
          ),

        ),
        onPressed: viewModel.isValidData == true && viewModel.isLoading == false
          ? registerAccount
          : null

      )

    );

  }



  Widget loginMsg() {

    return Text(
      '${SignupText.linkLoginMsg}',
      style: TextStyle(
        color:    Colors.white,
        fontSize: 16.0
      ),

    );

  }



  Widget loginLink(bool isLoading) {

    return InkWell(

      child: Text(

        '${SignupText.linkLoginTxt}',
        style: TextStyle(

          color:      ThemeData().primaryColor,
          fontSize:   16.0,
          fontWeight: FontWeight.bold,

        ),

      ),

      onTap: isLoading ? null : () => Navigator.pop(context)

    );

  }



  Widget loginRedirection(SignupViewModel viewModel) {

    return Container(

      child:  Row(

        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          loginMsg(),
          SizedBox(width: 8.0),
          loginLink(viewModel.isLoading)
        ],

      ),

    );

  }



  Widget signupLoading(SignupViewModel viewModel) {

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      width: 25.0,
      height: 25.0,
      child:  !viewModel.isLoading
        ? null
        : CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation( Colors.lightBlue )
        ),
    );

  }



  Widget backgroundImage() {

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(

          fit:          BoxFit.cover,
          image:        AssetImage("assets/background.jpg"),
          colorFilter:  ColorFilter.mode(
            Color.fromRGBO(0, 0, 0, .65),
            BlendMode.darken
          )

        ),
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
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white
            )
          )

        )
      );

    }

    return SizedBox();

  }



  Widget signup(SignupViewModel viewModel) {
    return Center(

      child: Container(
        
        constraints: BoxConstraints(maxWidth: 480.0),
        margin:      EdgeInsets.only(left: 20.0, right: 20.0),
        child:       SingleChildScrollView(

          child: Column(
            children: <Widget>[

              SizedBox(height: 10.0),
              signupAppTitle(),
              firstNameField( viewModel ),
              lastNameField( viewModel ),
              emailField( viewModel ),
              passwordField( viewModel ),
              password2Field( viewModel ),
              submitButton( viewModel, context ),
              loginRedirection( viewModel ),
              signupLoading( viewModel ),
              SizedBox(height: 10.0),

            ],
          ),

        ),

      ),

    );
  }






}