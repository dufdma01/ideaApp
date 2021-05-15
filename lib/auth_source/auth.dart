
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:idea_app/auth_source/authpage_state.dart';
import 'package:provider/provider.dart';
import 'package:idea_app/auth_source/authpage_state.dart';
import 'package:shared_preferences/shared_preferences.dart';


enum Status { Authenticated,  Unauthenticated}

class AuthService with ChangeNotifier{
static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
static final GoogleSignIn _googleSignIn = GoogleSignIn();
static User? _user;
Status _status = Status.Unauthenticated;

late SharedPreferences _sharedPreferences;


    AuthService() {
      _firebaseAuth.authStateChanges().listen(_onAuthStateChanged);
    }

Status get status => _status;

    void statusChangetoAuth(){
      _status = Status.Authenticated;
    }




Future<void> _onAuthStateChanged(User? firebaseUser) async {
  if (firebaseUser == null) {
    _status = Status.Unauthenticated;
    print('User is currently signed out!');
  } else {
    _user = firebaseUser;
    _status = Status.Authenticated;
    print('User is currently sign in!');
  }
  notifyListeners();

}

User? getCurrentUser() {
     _user = _firebaseAuth.currentUser;
      return _user;
   }

// void setUser(User? value) {
//   _user = value;
//   notifyListeners();
// }

User? getUser(){
  return _user;

}

void sharedprefSave(String email, String password) async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setString('email', email);
  pref.setString('password', password);
}

void checkPrefStatus() async{
      SharedPreferences pref = await SharedPreferences.getInstance();
      if(pref.getString('email') == null){
        _status =Status.Unauthenticated;
      }else
        _status =Status.Authenticated;
      notifyListeners();

}






// GET UID
String getCurrentUID() {
  return _firebaseAuth.currentUser!.uid;
}

// GET CURRENT USER
// Future getCurrentUser() async {
//   return _firebaseAuth.currentUser;
// }

getProfileImage() {
  if(_firebaseAuth.currentUser!.photoURL != null) {
    return Image.network(_firebaseAuth.currentUser!.photoURL!, height: 100, width: 100);
  } else {
    return Icon(Icons.account_circle, size: 100);
  }
}

// Email & Password Sign Up
Future<User?> createUserWithEmailAndPassword(
    String email, String password) async {

   final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
     email: email,
     password: password,
   );
 return authResult.user;

}


Future updateUserName(String name, User currentUser) async {
  await currentUser.updateProfile(displayName: name);
  await currentUser.reload();
}
  Future<User?> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    final credential = EmailAuthProvider.credential(
      email: email,
      password: password,
    );
    final authResult = await _firebaseAuth.signInWithCredential(credential);
    return authResult.user;
  }

// Email & Password Sign In
//로그아웃 해야함....
// Sign Out
signOut() async {
  await _firebaseAuth.signOut();
  notifyListeners();

}

// Reset Password
Future sendPasswordResetEmail(String email) async {
  return _firebaseAuth.sendPasswordResetEmail(email: email);
}

// Create Anonymous User
Future singInAnonymously() {
  return _firebaseAuth.signInAnonymously();
}

Future convertUserWithEmail(
    String email, String password, String name) async {
  final currentUser = _firebaseAuth.currentUser;

  final credential =
  EmailAuthProvider.credential(email: email, password: password);
  await currentUser!.linkWithCredential(credential);
  await updateUserName(name, currentUser);
}

Future convertWithGoogle() async {
  final currentUser = _firebaseAuth.currentUser;
  final GoogleSignInAccount account = (await _googleSignIn.signIn())!;
  final GoogleSignInAuthentication _googleAuth = await account.authentication;
  final AuthCredential credential = GoogleAuthProvider.credential(
    idToken: _googleAuth.idToken,
    accessToken: _googleAuth.accessToken,
  );
  await currentUser!.linkWithCredential(credential);
  await updateUserName(_googleSignIn.currentUser!.displayName!, currentUser);
}

// GOOGLE
Future<String> signInWithGoogle() async {
  final GoogleSignInAccount account = (await _googleSignIn.signIn())!;
  final GoogleSignInAuthentication _googleAuth = await account.authentication;
  final AuthCredential credential = GoogleAuthProvider.credential(
    idToken: _googleAuth.idToken,
    accessToken: _googleAuth.accessToken,
  );
  return (await _firebaseAuth.signInWithCredential(credential)).user!.uid;
}

// APPLE
// Future signInWithApple() async {
//   final AuthorizationResult result = await AppleSignIn.performRequests([
//     AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
//   ]);
//
//   switch (result.status) {
//     case AuthorizationStatus.authorized:
//       final AppleIdCredential _auth = result.credential;
//       final OAuthProvider oAuthProvider =
//       new OAuthProvider("apple.com");
//
//       final AuthCredential credential = oAuthProvider.credential(
//         idToken: String.fromCharCodes(_auth.identityToken),
//         accessToken: String.fromCharCodes(_auth.authorizationCode),
//       );
//
//       await _firebaseAuth.signInWithCredential(credential);
//
//       // update the user information
//       if (_auth.fullName != null) {
//         await _firebaseAuth.currentUser.updateProfile(displayName: "${_auth.fullName.givenName} ${_auth.fullName.familyName}");
//       }
//
//       break;
//
//     case AuthorizationStatus.error:
//       print("Sign In Failed ${result.error.localizedDescription}");
//       break;
//
//     case AuthorizationStatus.cancelled:
//       print("User Cancled");
//       break;
//   }
// }
//
// Future createUserWithPhone(String phone, BuildContext context) async {
//   _firebaseAuth.verifyPhoneNumber(
//       phoneNumber: phone,
//       timeout: Duration(seconds: 0),
//       verificationCompleted: (AuthCredential authCredential) {
//         _firebaseAuth.signInWithCredential(authCredential).then((UserCredential result){
//           Navigator.of(context).pop(); // to pop the dialog box
//           Navigator.of(context).pushReplacementNamed('/home');
//         }).catchError((e) {
//           return "error";
//         });
//       },
//       verificationFailed: (FirebaseAuthException exception) {
//         return "error";
//       },
//       (codeSent: (String verificationId, [int forceResendingToken]) {
//         final _codeController = TextEditingController();
//         showDialog(
//           context: context,
//           barrierDismissible: false,
//           builder: (context) => AlertDialog(
//             title: Text("Enter Verification Code From Text Message"),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[TextField(controller: _codeController)],
//             ),
//             actions: <Widget>[
//               FlatButton(
//                 child: Text("submit"),
//                 textColor: Colors.white,
//                 color: Colors.green,
//                 onPressed: () {
//                   var _credential = PhoneAuthProvider.credential(verificationId: verificationId,
//                       smsCode: _codeController.text.trim());
//                   _firebaseAuth.signInWithCredential(_credential).then((UserCredential result){
//                     Navigator.of(context).pop(); // to pop the dialog box
//                     Navigator.of(context).pushReplacementNamed('/home');
//                   }).catchError((e) {
//                     return "error";
//                   });
//                 },
//               )
//             ],
//           ),
//         );
//       })!,
//       codeAutoRetrievalTimeout: (String verificationId) {
//         verificationId = verificationId;
//       });
// }
}

class NameValidator {
  static String? validate(String value) {
    if (value.isEmpty) {
      return "Name can't be empty";
    }
    if (value.length < 2) {
      return "Name must be at least 2 characters long";
    }
    if (value.length > 50) {
      return "Name must be less than 50 characters long";
    }
    return null;
  }
}

class EmailValidator {
  static String? validate(String value) {
    if (value.isEmpty) {
      return "Email can't be empty";
    }
    return null;
  }
}

class PasswordValidator {
  static String? validate(String value) {
    if (value.isEmpty) {
      return "Password can't be empty";
    }
    return null;
  }
}
