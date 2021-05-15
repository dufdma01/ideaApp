import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:idea_app/auth_source/auth.dart';
import 'package:idea_app/pages/guardNav_State.dart';
import 'package:idea_app/stless_source/rounded_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'Login_Screen';
  // const LoginScreen({required Key key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late User? _user;


  final TextEditingController _email =  TextEditingController();
  final TextEditingController _password =  TextEditingController();


  bool showSpinner = false;
  late AuthService provider ;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AuthService>(context);


    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      controller: _email,
      autovalidateMode: AutovalidateMode.always,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Icon(
            Icons.email,
            color: Colors.grey,
          ), // icon is 48px widget.
        ), // icon is 48px widget.
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: _password,
      autovalidateMode: AutovalidateMode.always,
      decoration: InputDecoration(
        prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Icon(
              Icons.lock,
              color: Colors.grey,
            ), // icon is 48px widget.
          ),
         // icon is 48px widget.
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );


    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: <Widget>[
              Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Column(
                        children: <Widget>[
                          SizedBox(
                            height: 30.0,
                          ),
                          Container(
                            width: 300,
                              child: email),
                          SizedBox(
                            height: 30.0,
                          ),
                          Container(
                            width: 250.0,
                            height: 1.0,
                            color: Colors.grey[400],
                          ),
                          Container(
                            width: 300,
                              child: password),
                        ],
                  ),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              RoundedButton(
                color: Colors.blueAccent,
                function: () async {
                  setState(() {
                    showSpinner = true;
                  });

                  _emailLogin(
                      email: _email.text, password: _password.text, context: context);
                  provider.sharedprefSave(_email.text.toString(), _password.text.toString());

                  // sharedprefSave();
                },
                text: 'Log in',
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.black,
                          fontSize: 16.0,
                          fontFamily: 'WorkSansMedium'),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: <Color>[
                              Colors.white10,
                              Colors.white,
                            ],
                            begin: FractionalOffset(0.0, 0.0),
                            end: FractionalOffset(1.0, 1.0),
                            stops: <double>[0.0, 1.0],
                            tileMode: TileMode.clamp),
                      ),
                      width: 100.0,
                      height: 1.0,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Text(
                        'Or',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontFamily: 'WorkSansMedium'),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: <Color>[
                              Colors.white10,
                              Colors.white,
                            ],
                            begin: FractionalOffset(0.0, 0.0),
                            end: FractionalOffset(1.0, 1.0),
                            stops: <double>[0.0, 1.0],
                            tileMode: TileMode.clamp),
                      ),
                      width: 100.0,
                      height: 1.0,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, right: 40.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(15.0),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: const Icon(
                          FontAwesomeIcons.facebookF,
                          color: Color(0xFF0084ff),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(15.0),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: const Icon(
                          FontAwesomeIcons.google,
                          color: Color(0xFF0084ff),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _emailLogin(
      {required String email, required String password, required BuildContext context}) async {
    if (_formKey.currentState!.validate()) {
      try {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        provider.signInWithEmailAndPassword(email: email, password: password);
        print(provider.status);
        // _user = provider.getCurrentUser();

        // Navigator.pushNamed(context, GuardNavState.id);
        Navigator.pushReplacementNamed(context, GuardNavState.id);


        setState(() {
              showSpinner = false;
            });
      }
      catch(e) {
        print(e);
      }
    }
  }
  //
  // void sharedprefSave() async{
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   pref.setString('email', _email.text.toString());
  //   pref.setString('password', _password.text.toString());
  // }
  //
  //






}


//
// Scaffold(
// backgroundColor: Colors.white,
// body: LoadingScreen(
// child: Form(
// key: _formKey,
// autovalidate: _autoValidate,
// child: Padding(
// padding: const EdgeInsets.symmetric(horizontal: 24.0),
// child: Center(
// child: SingleChildScrollView(
// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// crossAxisAlignment: CrossAxisAlignment.stretch,
// children: <Widget>[
// logo,
// SizedBox(height: 48.0),
// email,
// SizedBox(height: 24.0),
// password,
// SizedBox(height: 12.0),
// loginButton,
// forgotLabel,
// signUpLabel
// ],
// ),
// ),
// ),
// ),
// ),
// inAsyncCall: _loadingVisible),
// );