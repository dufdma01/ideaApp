import 'package:flutter/material.dart';

class RoundedButtonUserble extends StatelessWidget {
  final Color color;
  final String text;
  final  VoidCallback  function;

  RoundedButtonUserble({required this.color, required this.function, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed:function,
          minWidth: 22.0,
          height: 22.0,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}