import 'package:flutter/material.dart';
import 'package:idea_app/auth_source/auth.dart';
import 'package:idea_app/intro_pages/intro.dart';
import 'package:idea_app/login_pages/log_in.dart';
import 'package:idea_app/pages/guardNav_State.dart';
import 'package:provider/provider.dart';



class AuthPage extends StatefulWidget {
  static const String id = 'AuthPage';
  @override
  _AuthPageState createState()=>_AuthPageState();
  }


class _AuthPageState extends State<AuthPage> {
   late AuthService provider ;

  @override
  Widget build(BuildContext context) {
   provider=  Provider.of<AuthService>(context);
   switch(provider.status) {
     case Status.Unauthenticated:
       return Login();
     case Status.Authenticated:
       return GuardNavState();


   }
  }
}