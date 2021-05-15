import 'package:flutter/material.dart';
import 'file:///C:/Download/YRecommender419/idea_app/lib/pages/main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:idea_app/auth_source/ideamodel.dart';
import 'file:///C:/Download/YRecommender419/idea_app/lib/auth_source/auth.dart';

import '../pages/guardNav_State.dart';

FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
late User loggedUser;

class Addpost extends StatefulWidget {
  static const String id = 'Addpost';

  @override
  _AddpostState createState() => _AddpostState();
}

class _AddpostState extends State<Addpost> {
  IdeaModel _ideaModel = IdeaModel(title: '', idea: '', photoUrl: '');
  String _inputTitle = '';
  String _inputSumContent = '';
  String _inputContent = '';
  final TextEditingController _title = TextEditingController();
  final TextEditingController _sumcontent = TextEditingController();
  final TextEditingController _content = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;
  var unixTimestamp = DateTime.now().millisecondsSinceEpoch;
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
        print(loggedUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add your Idea',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.only(top: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _title,
                  maxLines: 1,
                  maxLength: 16,
                  onChanged: (value) {
                    _inputTitle = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Title',
                    hintText: 'add title',
                    hintStyle: TextStyle(
                      color: Colors.blueGrey.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _sumcontent,
                  maxLines: 2,
                  maxLength: 40,
                  onChanged: (value) {
                    _inputSumContent = value;
                  },
                  decoration: InputDecoration(
                    labelText: '컨텐츠 요약 2줄',
                    hintText: 'add your idea',
                    hintStyle: TextStyle(
                      color: Colors.blueGrey.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _content,
                  maxLines: 16,
                  maxLength: 300,
                  onChanged: (value) {
                    _inputContent = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Specific',
                    hintText: 'discrete contents!',
                    hintStyle: TextStyle(
                      color: Colors.blueGrey.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    if (_inputTitle != '' &&
                        _inputSumContent != '' &&
                        _inputContent != '') {
                      _title.clear();
                      _sumcontent.clear();
                      _content.clear();

                      String tempInputTitle = this._inputTitle;
                      String tempInputSumContent = this._inputSumContent;
                      String tempInputContent = this._inputContent;

                      _firebaseFirestore.collection('ideaList').doc('$unixTimestamp,${loggedUser.email}').set({
                        'title': tempInputTitle,
                        'name': loggedUser.email,
                        'idea': tempInputSumContent,
                        'content': tempInputContent,
                        'time':FieldValue.serverTimestamp(),
                        'key': '$unixTimestamp,${loggedUser.email}',

                      });

                      _ideaModel.title = tempInputTitle;
                      _ideaModel.idea = tempInputSumContent;
                      _ideaModel.content = tempInputContent;
                      _ideaModel.addIdea();

                      Navigator.pushNamed(context, GuardNavState.id);
                    } else {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('팝업메세지'),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: [
                                    Text('내용을 입력해 보아요'),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: new Text("Close"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          });
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
