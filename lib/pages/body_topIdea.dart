import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idea_app/stless_source/rounded_Card.dart';
import 'package:carousel_slider/carousel_slider.dart';

class BodytopIdea extends StatelessWidget {
  static const String id ='BodytopIdea';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: size.height * 0.1,
            child: Stack(
              children: [
                Container(
                  height: size.height * 0.1 - 27,
                  decoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 30.0),
                    height: 54,
                    decoration: BoxDecoration(
                      color: Colors.white54,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 50,
                          color: Colors.white54.withOpacity(0.2),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: CarouselSlider(
              options: CarouselOptions(height: 400.0),
              items: itemList(),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'new released IDEA',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.lightBlueAccent),
          ),
      ],
      ),
    );
  }
}

List<Widget> itemList() {
  return [
    ItemListWidget(),
    ItemListWidget(),
    ItemListWidget(),
  ];
}
