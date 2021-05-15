import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String email;
  String name;
  String tool;
  String photoUrl;

  UserModel(
      {this.uid = '', required this.email, this.name = '', this.tool ='', this.photoUrl = ''});

  // Create a CollectionReference called users that references the firestore collection
  CollectionReference users = FirebaseFirestore.instance.collection(
      'userProfile');

  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return users.doc(email)
        .set({
      'uid': uid,
      'email': email,
      'name': name,
      'tool': tool,
      'photoUrl': photoUrl
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  factory UserModel.fromDocument(DocumentSnapshot document) {
    return UserModel(
      email: document.data()!['email'],
      name: document.data()!['name'],
      photoUrl: document.data()!['photoUrl'],
      uid: document.data()!['uid'],
      tool: document.data()!['tool'],

    );
  }

}
