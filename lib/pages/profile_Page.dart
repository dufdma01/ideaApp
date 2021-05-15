import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:idea_app/auth_source/auth.dart';
import 'package:idea_app/list_data/add_listData.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';




class ProfilePage extends StatefulWidget {
  static const String id = 'ProfilePage';
  final String? user;
  ProfilePage({this.user = ''});
  @override
  _ProfilePageState createState() => _ProfilePageState();

}

class _ProfilePageState extends State<ProfilePage> {
  late AuthService provider;
  FirebaseAuth _auth = FirebaseAuth.instance;
  late User? loggedUser;
  String _userId = '';
  String _userTool = '';


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedUser = user;
        print(loggedUser!.email);
      }
    } catch (e) {
      print(e);
    }
  }


  createButtonTitleAndFunction(
      {required String title, required VoidCallback performFunction}) {
    return Container(
      padding: EdgeInsets.only(top: 3),
      child: TextButton(
        onPressed: performFunction,
        child: Container(
          width: MediaQuery
              .of(context)
              .size
              .width * 0.8,
          height: MediaQuery
              .of(context)
              .size
              .height * 0.05,
          child: Text(
            title,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.grey,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(6)),
        ),
      ),

    );
  }


  @override
  Widget build(BuildContext context) {
    provider=  Provider.of<AuthService>(context);
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('userProfile').doc(
            widget.user==provider.getUser()!.email ?provider.getUser()!.email : widget.user).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData == false) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }

          final userid = snapshot.data;
          final user = userid!.data();
          _userId = user!['uid'];
          _userTool = user['tool'];


          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://pbs.twimg.com/media/ExUElF7VcAMx7jx.jpg"),
                            fit: BoxFit.cover)),
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      child: Container(
                        alignment: Alignment(0.0, 2.5),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://pbs.twimg.com/media/ExUElF7VcAMx7jx.jpg"),
                          radius: 60.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Text(
                    '@$_userId',
                    style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.blueGrey,
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            icon: Icon(FontAwesomeIcons.facebookF),
                            onPressed: () {}),
                        IconButton(
                            icon: Icon(FontAwesomeIcons.instagram),
                            onPressed: () {}),
                        IconButton(
                            icon: Icon(FontAwesomeIcons.github),
                            onPressed: () {}),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {},
                      child: Text('$_userTool  developer',
                          style: TextStyle(color: Colors.black, fontSize: 20)),
                    ),
                  ),
                  Row(
                    // 상황에 따라 Edit profile, follow, unfollow 버튼으로 분기처리
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      createButtonTitleAndFunction(
                          title: 'Edit profile',
                          performFunction: () {
                            Navigator.pushNamed(context, Addpost.id);
                          })
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 150,
                        margin: EdgeInsets.only(right: 20),
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.20 - 20,
                        decoration: BoxDecoration(
                            color: Colors.white54,
                            borderRadius: BorderRadius.all(Radius.circular(
                                20.0))),
                        child: TextButton(
                          onPressed: () {

                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Most\nFavorites",
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "20 Items",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 150,
                        margin: EdgeInsets.only(right: 20),
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.20 - 20,
                        decoration: BoxDecoration(
                            color: Colors.white54,
                            borderRadius: BorderRadius.all(Radius.circular(
                                20.0))),
                        child: TextButton(
                          onPressed: () {

                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Most\nFavorites",
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "20 Items",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}
