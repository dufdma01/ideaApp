import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:idea_app/auth_source/auth.dart';
import 'package:idea_app/login_pages/registration_page.dart';
import 'package:idea_app/pages/guardNav_State.dart';
import 'package:idea_app/stless_source/RoundedButtonForUserable.dart';
import 'package:idea_app/stless_source/rounded_button.dart';
import 'package:provider/provider.dart';
class UserbleTool extends StatefulWidget {
  static const String id = 'UserbleTool';

  @override
  _UserbleToolState createState() => _UserbleToolState();
}

class _UserbleToolState extends State<UserbleTool>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  bool _hasBeenPressed0 = false;
  int zero=0;
  bool _hasBeenPressed1 = false;
  int one = 0;
  bool _hasBeenPressed2 = false;
  int two = 0;
  bool _hasBeenPressed3 = false;
  int three = 0;
  bool _hasBeenPressed4 = false;
  int four = 0;
  String userTool = '';

  @override
  void initState() {
    super.initState();
    zero=0;
    one=0;
    two=0;
    three=0;
    four=0;
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    AuthService provider = Provider.of<AuthService>(context);
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              children: <Widget>[
                AnimatedTextKit(
                  totalRepeatCount: 1,
                  animatedTexts: [
                    TypewriterAnimatedText(
                      '개발에 가장 자신있는 언어 1개를 골라주세요!',
                      textStyle: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 18.0,
            ),
            RoundedButtonUserble(
              color: _hasBeenPressed0 ? Colors.lightBlueAccent : Colors.white,
              function: () {
                setState(() {
                  _hasBeenPressed0 = !_hasBeenPressed0;
                  zero = _hasBeenPressed0 ? 1 : 0;
                  userTool = _hasBeenPressed0 ? 'JAVA': '';

                });
              },
              text: 'JAVA',
            ),
            RoundedButtonUserble(
              color: _hasBeenPressed1 ? Colors.lightBlueAccent : Colors.white,
              function: () {
                setState(() {
                  _hasBeenPressed1 = !_hasBeenPressed1;
                  one = _hasBeenPressed1 ? 1 : 0;
                  userTool = _hasBeenPressed1 ? 'Kotlin': '';
                });
              },
              text: 'Kotlin',
            ),
            RoundedButtonUserble(
              color: _hasBeenPressed2 ? Colors.lightBlueAccent : Colors.white,
              function: () {
                setState(() {
                  _hasBeenPressed2 = !_hasBeenPressed2;
                  two = _hasBeenPressed2 ? 1 : 0;
                  userTool = _hasBeenPressed2 ? 'Dart': '';
                });
              },
              text: 'Dart',
            ),
            RoundedButtonUserble(
              color: _hasBeenPressed3 ? Colors.lightBlueAccent : Colors.white,
              function: () {
                setState(() {
                  _hasBeenPressed3 = !_hasBeenPressed3;
                  three = _hasBeenPressed3 ? 1 : 0;
                  userTool = _hasBeenPressed3 ? 'Swift': '';
                });
              },
              text: 'Swift',
            ),
            RoundedButtonUserble(
              color: _hasBeenPressed4 ? Colors.lightBlueAccent : Colors.white,
              function: () {
                setState(() {
                  _hasBeenPressed4 = !_hasBeenPressed4;
                  four = _hasBeenPressed4 ? 1 : 0;
                  userTool = _hasBeenPressed4 ? 'React': '';
                });
              },
              text: 'React',
            ),
            AnimatedOpacity(
              opacity: zero + one + two + three + four == 1 ? 1.0 : 0.0,
              duration: Duration(milliseconds: 500),
              child: RoundedButton(
                  color: Colors.lightBlueAccent,
                  function: () {
                    RegistrationScreen.userModel.tool = userTool;
                    RegistrationScreen.userModel.addUser();
                    Navigator.pushReplacementNamed(context, GuardNavState.id);
                    print(provider.status);
                  },
                  text: '다음으로'),
            )
          ],
        ),
      ),
    );
  }
}
