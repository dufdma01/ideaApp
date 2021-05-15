import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:idea_app/auth_source/auth.dart';
import 'package:idea_app/auth_source/usermodel.dart';
import 'package:idea_app/login_pages/log_in.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'file:///C:/Download/YRecommender419/idea_app/lib/pages/profile_Page.dart';
import '../list_data/add_listData.dart';
import '../stless_source/catagories_Scroller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'detailed_Idea.dart';

FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
ScrollController _controller = ScrollController();

class MainPage extends StatefulWidget {
  static const String id = 'MainPage';
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyHomePage(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.animateTo(_controller.position.minScrollExtent,
              duration: Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn);
        },
        child: Icon(Icons.arrow_upward),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  late AuthService fp;
  final CategoriesScroller categoriesScroller = CategoriesScroller();

  bool closeTopContainer = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (mounted)
        setState(() {
          closeTopContainer = _controller.offset > 50;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<AuthService>(context);
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height * 0.30;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: Icon(
            Icons.menu,
            color: Colors.black,
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search, color: Colors.black),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.person, color: Colors.black),
              onPressed: () async {
                await fp.signOut();
                print(fp.status);
                Navigator.pushReplacementNamed(context, Login.id);
              },
            )
          ],
        ),
        body: Container(
          // height: size.height,
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: closeTopContainer ? 0 : 1,
                child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: size.width,
                    alignment: Alignment.topCenter,
                    height: closeTopContainer ? 0 : categoryHeight,
                    child: categoriesScroller),
              ),
              MainMessage(),
            ],
          ),
        ),
      ),
    );
  }
}

class MainMessage extends StatefulWidget {
  @override
  _MainMessageState createState() => _MainMessageState();
}

class _MainMessageState extends State<MainMessage> {
  late QuerySnapshot? gettingSnap;

  @override
  void initState() {
    retrieveMainData();
    super.initState();
  }

  Future<QuerySnapshot> retrieveMainData() async {
    QuerySnapshot tempS0 =
        await _firebaseFirestore.collection('ideaList').orderBy('time').get();
    setState(() {
      this.gettingSnap = tempS0;
    });
    return tempS0;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: retrieveMainData(),
        builder: (context, snapshot) {
          List<ListBubble> listBubbles = [];
                if(!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.lightBlueAccent,
                    ),
                  );
                }
          var idealists = this.gettingSnap!.docs.reversed;
          for (var idealist in idealists) {
            final ideaData = idealist.data();
            final ideaIdea = ideaData['idea'];
            final ideaName = ideaData['name'];
            final ideaTitle = ideaData['title'];
            final ideaContent = ideaData['content'];
            final ideaKey = ideaData['key'];
            final idealike = ideaData['like'];

            final listBubble = ListBubble(
              title: ideaTitle,
              name: ideaName,
              idea: ideaIdea,
              content: ideaContent,
              keysign: ideaKey,
              likes: idealike,
            );

            listBubbles.add(listBubble);
          }

          return Expanded(
              child: ListView.builder(
                  controller: _controller,
                  itemCount: listBubbles.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return listBubbles[index];
                  }));
        });

    // // // // //
    // return StreamBuilder<QuerySnapshot>(
    //     stream:
    //         _firebaseFirestore.collection('ideaList').orderBy('time').snapshots(),
    //     builder: (context, snapshot) {
    //       List<ListBubble> listBubbles = [];
    //       if(snapshot.hasData==false) {
    //         return Center(
    //           child: CircularProgressIndicator(
    //             backgroundColor: Colors.lightBlueAccent,
    //           ),
    //         );
    //       }
    //       final idealists = snapshot.data!.docs.reversed;
    //
    //       for (var idealist in idealists) {
    //         final ideaData = idealist.data();
    //         final ideaIdea = ideaData['idea'];
    //         final ideaName = ideaData['name'];
    //         final ideaTitle = ideaData['title'];
    //         final ideaContent = ideaData['content'];
    //         final ideaVoted = ideaData['voted'] ;
    //
    //         final listBubble = ListBubble(
    //           title: ideaTitle,
    //           name: ideaName,
    //           idea: ideaIdea,
    //           content: ideaContent,
    //           voted: ideaVoted,
    //         );
    //
    //         listBubbles.add(listBubble);
    //       }
    //       return Expanded(
    //           child: ListView.builder(
    //               controller: _controller,
    //               itemCount: listBubbles.length,
    //               physics: BouncingScrollPhysics(),
    //               itemBuilder: (context, index) {
    //                 return listBubbles[index];
    //               }));
    //     },
    //
    // );
    // // // // //
  }
}
// FirebaseAuth _auth = FirebaseAuth.instance;
// late DocumentSnapshot userRecord;
// var reference = FirebaseFirestore.instance.collection('userProfile');
//
// void getuid() async{
//   var userId = _auth.currentUser!.email;
//   userRecord = await reference.doc(userId).get();
//   UserModel _userModel = UserModel.fromDocument(userRecord);
//   final future =  _userModel.uid;
//   return future;
// }





class ListBubble extends StatefulWidget {

  final String title;
  final String idea;
  final String name;
  final String content;
  final String  keysign;
  Map? likes;

  ListBubble(
      {required this.title,
      required this.idea,
      required this.name,
      required this.content,
        required this.keysign,
        required this.likes,
      });

  @override
  _ListBubbleState createState() => _ListBubbleState();
}

class _ListBubbleState extends State<ListBubble> {
  int likeCount =0;
  @override
  void initState() {
    // TODO: implement initState
  if(widget.likes?.length ==null){
    likeCount =0;
  }else{
    likeCount = widget.likes!.length;
  }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 150,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
          ]),
      child: TextButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailedIdea(
                        ideaTitle: widget.title,
                        ideaName: widget.name,
                        ideaIdea: widget.idea,
                        ideaContent: widget.content,
                        keysign: widget.keysign,
                        // ideaLike: like,
                      )));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                widget.name,
                style: const TextStyle(fontSize: 15, color: Colors.grey),
              ),
              Text(
                widget.idea,
                style: const TextStyle(fontSize: 20, color: Colors.black),
              ),
              Text(
                  likeCount.toString(),
                style: const TextStyle(fontSize: 10, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
