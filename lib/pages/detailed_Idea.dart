

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:idea_app/auth_source/usermodel.dart';
import 'package:idea_app/pages/profile_Page.dart';
import 'package:idea_app/stless_source/floating_source.dart';
import 'main_page.dart';


//나중에 사진이랑 detail한 세부내용 받아와야함

//처음 add idea 할 때, likes null이라고 하고 likes count는 0이라고 하자요
//detailed idea에서는 data를 받아와야하는데 current title 이런 식으로 해서 likes를 선언!

FirebaseAuth _auth = FirebaseAuth.instance;
class DetailedIdea extends StatefulWidget {
  static const String id = 'DetailedIdea';

  final ideaIdea;
  final ideaName;
  final ideaTitle;
  final ideaContent;
  final keysign;



  DetailedIdea(
      {required this.ideaTitle,
      required this.ideaName,
      required this.ideaIdea,
      required this.ideaContent,
        required this.keysign,
      // required this.ideaLike
      });

  @override
  _DetailedIdeaState createState() => _DetailedIdeaState(
  );
}

class _DetailedIdeaState extends State<DetailedIdea>{
  Map likes ={_auth.currentUser!.email: false};
  bool maplikes =false;
  bool liked= false;
  late User loggedUser;
  var reference = FirebaseFirestore.instance.collection('userProfile');
  late DocumentSnapshot userRecord;
   UserModel _userModel =UserModel(email: '', uid: '', tool: '', photoUrl: '');
  int likeCount = 0;
  @override
  void initState(){
    super.initState();
    getCurrentUser();
    getCurrentuid();
    reference.doc(widget.ideaName).collection('userIdea').doc(widget.ideaTitle).get().then((DocumentSnapshot ds){
      maplikes= ds.data()!['like']['${_userModel.uid}'];
      // liked =ds.data()!['like']['${_userModel.uid}'];
      // print(liked);
      print(maplikes);
      setState(() {
        likes= {_userModel.uid: maplikes};
        likeCount = ds.data()!['like'].length;
      });

      print(likes);
    });
  }


  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedUser = user;
        print(loggedUser.email);
      }
    } catch (e) {
      print(e);
    }
  }


  void getCurrentuid()async{
    var userId = _auth.currentUser!.email;
    userRecord = await reference.doc(userId).get();
    _userModel = UserModel.fromDocument(userRecord);

  }


  IconButton buildIcon(){
    print('icon $liked');
    return IconButton(
       icon: Icon(
         liked ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
        size: 25.0,
        color: liked ? Colors.pink : Colors.lightBlueAccent,
      ),
      onPressed: (){
        _likePost(widget.ideaName);
      },
    );
  }



  GestureDetector buildLikeIcon() {
    return GestureDetector(
        child: Icon(
          liked ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
          size: 25.0,
          color: liked ? Colors.pink : Colors.lightBlueAccent,
        ),
        onTap: () {
          _likePost(widget.ideaName);
        });
  }
  void _likePost(String postId) {

    bool _liked = likes[_userModel.uid] == true;

    if (_liked) {
      print('removing like');
      reference.doc(postId).collection('userIdea').doc(widget.ideaTitle).update({'like.${_userModel.uid}': FieldValue.delete()});
        //firestore plugin doesnt support deleting, so it must be nulled / falsed


      setState(() {
        likeCount = likeCount - 1;
        maplikes = false;
        likes[_userModel.uid] = false;
      });

      removeItem();
      removeActivityFeedItem();
    }

    if (!_liked) {
      print('liking');

      reference.doc(postId).collection('userIdea').doc(widget.ideaTitle).update({'like.${_userModel.uid}': true});

      addItem();
      addActivityFeedItem();

      setState(() {
        likeCount = likeCount + 1;
        maplikes = true;
        likes[_userModel.uid] = true;

      });

    }
  }

  void addItem() {
    FirebaseFirestore.instance
        .collection("ideaList")
        .doc(widget.keysign)
        .update({'like.${_userModel.uid}': true});

  }

  void addActivityFeedItem() {
    FirebaseFirestore.instance
        .collection("userProfile")
        .doc(loggedUser.email)
        .collection("userLiked")
        .doc(widget.ideaTitle)
        .set({
      "title": widget.ideaTitle,
      "timestamp": DateTime.now(),

    });
  }

  void removeItem() {
    FirebaseFirestore.instance
        .collection("ideaList")
        .doc(widget.keysign)
        .update({'like.${_userModel.uid}': FieldValue.delete()});

  }

  void removeActivityFeedItem() {
    FirebaseFirestore.instance
        .collection("userProfile")
        .doc(loggedUser.email)
        .collection("userLiked")
        .doc(widget.ideaTitle)
        .delete();
  }


  @override
  Widget build(BuildContext context) {
    liked = likes[_userModel.uid] == true;
    print('build liked: $liked');
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'IDea',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 0,
        ),
        width: screenWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            FloatingWidget(
              leadingIcon: Icons.mail,
              txt: "Message",
            ),

          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 15, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.ideaIdea,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(
                        widget.ideaName,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    buildLikeIcon(),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Container(
                    height: 45,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                        color: Colors.black12,
                      ),
                    ),
                    child: Center(
                      child: TextButton(
                        child: Text(widget.ideaName,
                        style: Theme.of(context).textTheme.caption!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfilePage( user: widget.ideaName,)));
                        },
                    ),
                  ),
                ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 15,
              bottom: 15,
              left: 15,
            ),
            child: Text(
              widget.ideaTitle,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                  top: 20,
                  bottom: 20,
                ),
                child: Text(
                  widget.ideaContent,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              )),
          Container(
            margin: const EdgeInsets.only(left: 20.0),
            child: Text(
              "$likeCount likes",
            ),
          )

        ],
      ),
    );
  }
}

