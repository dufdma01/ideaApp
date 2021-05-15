import 'package:flutter/material.dart';


class FloatingWidget extends StatelessWidget {
  final IconData leadingIcon;
  final String txt;
  FloatingWidget({
    Key? key,
    required this.leadingIcon,
    required this.txt,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: 150,
      child: FloatingActionButton(
        elevation: 5,
        onPressed: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(75.0),
        ),
        heroTag: null,
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.lightBlueAccent,
            borderRadius: BorderRadius.circular(75.0),
          ),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: 300.0,
              minHeight: 50.0,
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  leadingIcon,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 80,
                  child: Text(
                    txt,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
