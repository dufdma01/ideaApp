// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:idea_app/auth_source/auth.dart';
import 'package:idea_app/auth_source/authpage_state.dart';
import 'package:idea_app/intro_pages/intro.dart';
import 'file:///C:/Download/YRecommender419/idea_app/lib/pages/detailed_Idea.dart';
import 'file:///C:/Download/YRecommender419/idea_app/lib/pages/guardNav_State.dart';
import 'file:///C:/Download/YRecommender419/idea_app/lib/login_pages/log_in.dart';
import 'file:///C:/Download/YRecommender419/idea_app/lib/login_pages/login_page.dart';
import 'file:///C:/Download/YRecommender419/idea_app/lib/pages/profile_Page.dart';
import 'file:///C:/Download/YRecommender419/idea_app/lib/login_pages/registration_page.dart';
import 'intro_pages/userable_tool.dart';
import 'pages/main_page.dart';
import 'pages/notification_Page.dart';
import 'stless_source/rounded_Card.dart';
import 'pages/body_topIdea.dart';
import 'list_data/add_listData.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'auth_source/auth.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
         ChangeNotifierProvider(
        create: (_) => AuthService()),

      ],
      child: MaterialApp(
                debugShowCheckedModeBanner: false,
                initialRoute: AuthPage.id,
                routes: {
                  MainPage.id: (context) => MainPage(),
                  Login.id : (context) => Login(),
                  ItemListWidget.id: (context) => ItemListWidget(),
                  BodytopIdea.id: (context)=> BodytopIdea(),
                  Addpost.id: (context)=> Addpost(),
                  RegistrationScreen.id: (context)=> RegistrationScreen(),
                  LoginScreen.id: (context)=> LoginScreen(),
                  DetailedIdea.id: (context)=> DetailedIdea(),
                  ProfilePage.id:(context)=>ProfilePage(),
                  GuardNavState.id:(context)=>GuardNavState(),
                  NotificationsPage.id:(context)=>NotificationsPage(),
                  AuthPage.id:(context)=> AuthPage(),
                  IntroScreen.id:(context)=> IntroScreen(),
                  UserbleTool.id: (context)=> UserbleTool(),
                }


      ),
    );
  }
}


// Provider(
// auth: AuthService(),
// db: FirebaseFirestore.instance,
// colors: Colors.white,
// child: