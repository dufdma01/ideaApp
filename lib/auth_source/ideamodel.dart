import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class IdeaModel {
  late User loggedUser;
  FirebaseAuth _auth = FirebaseAuth.instance;

  String? title;
  String? idea;
  String? content;
  String? photoUrl;
  // Map? like;

  IdeaModel(
      {this.title = '', this.idea='' , this.content='', this.photoUrl = '',
        // this.like
      });



  Future<void> addIdea() {
    getCurrentUser();

    DocumentReference users = FirebaseFirestore.instance.collection(
        'userProfile').doc(loggedUser.email);
    return users.collection('userIdea').doc(title)
        .set({
      'title': title,
      'idea': idea,
      'content': content,
      'photoUrl': photoUrl,
      // 'like': like


    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
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

}
