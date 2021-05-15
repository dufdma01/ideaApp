import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:idea_app/intro_pages/intro.dart';
import 'package:idea_app/stless_source/rounded_button.dart';
import 'file:///C:/Download/YRecommender419/idea_app/lib/auth_source/usermodel.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import '../auth_source/auth.dart';

class RegistrationScreen extends StatefulWidget {
  static UserModel userModel = UserModel(uid: '', email: '', name: '', tool: '');
  static const String id = 'registration_screen';
  // const RegistrationScreen({required Key key}) : super(key: key);
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  late AuthService provider;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _userid = new TextEditingController();
  final TextEditingController _name = new TextEditingController();
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  final TextEditingController _confirmpassword = new TextEditingController();

  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AuthService>(context);

    final name = TextFormField(
      autofocus: false,
      textCapitalization: TextCapitalization.words,
      controller: _name,
      autovalidateMode: AutovalidateMode.always,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: Icon(
            Icons.person,
            color: Colors.grey,
          ), // icon is 48px widget.
        ), // icon is 48px widget.
        hintText: 'Name',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final userId = TextFormField(
      autofocus: false,
      textCapitalization: TextCapitalization.words,
      controller: _userid,
      autovalidateMode: AutovalidateMode.always,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: Icon(
            Icons.person,
            color: Colors.grey,
          ), // icon is 48px widget.
        ), // icon is 48px widget.
        hintText: 'Userid',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

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

    final confirmpassword = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: _confirmpassword,
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
          child: Padding(
            padding: const EdgeInsets.only(left: 55.0),
            child: Column(
              children: <Widget>[
                Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        SizedBox(height: 5),
                        Container(width: 300, child: name),
                        SizedBox(height: 5),
                        Container(width: 300, child: userId),
                        SizedBox(height: 5),
                        Container(width: 300, child: email),
                        SizedBox(height: 5),
                        Container(width: 300, child: password),
                        SizedBox(height: 5),
                        Container(width: 300, child: confirmpassword),
                      ],
                    ),
                  ],
                ),
                RoundedButton(
                  color: Colors.blueAccent,
                  function: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      if (_formKey.currentState!.validate()) {
                        SystemChannels.textInput.invokeMethod('TextInput.hide');
                        provider.sharedprefSave(
                            _email.text.toString(), _password.text.toString());

                        RegistrationScreen.userModel.email = _email.text;
                        RegistrationScreen.userModel.name = _name.text;
                        RegistrationScreen.userModel.uid = _userid.text;

                        provider.createUserWithEmailAndPassword(
                            _email.text, _password.text);

                        // RegistrationScreen.userModel.addUser();

                        provider.getCurrentUser();
                        print(provider.status);

                        Navigator.pushReplacementNamed(context, IntroScreen.id);

                        setState(() {
                          showSpinner = false;
                        });
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  text: 'Register',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
