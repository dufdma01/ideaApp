import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:idea_app/auth_source/auth.dart';
import 'package:provider/provider.dart';
import 'file:///C:/Download/YRecommender419/idea_app/lib/pages/profile_Page.dart';

import '../list_data/add_listData.dart';
import 'main_page.dart';
import 'notification_Page.dart';

class GuardNavState extends StatefulWidget {
  static const String id = 'GuardNavState';
  @override
  _GuardNavStateState createState() => _GuardNavStateState();
}

class _GuardNavStateState extends State<GuardNavState> {
  int _currentIndex = 0;
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    AuthService provider = Provider.of<AuthService>(context);
    String? currentUserEmail = provider.getUser()!.email;
    print('from GaurdNav $currentUserEmail');
    final List<Widget> _children = [MainPage(), Addpost(),NotificationsPage(), ProfilePage(user: currentUserEmail)];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: (int index) {
            if (_currentIndex != index) {
              setState(() {
                _currentIndex = index;
              });
            }
          },
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Add',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notifi',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            )
          ]),
      body: _children[_currentIndex],
    );
  }
}
