import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
//수정필요
class ItemListWidget extends StatefulWidget {
  static const String id = 'itemListwidget';
  @override
  _ItemListWidgetState createState() => _ItemListWidgetState();
}

class _ItemListWidgetState extends State<ItemListWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                '금주의 idea',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              IconButton(
                  icon: SvgPicture.asset('icons/002-microphone.svg'),
                  onPressed: () {}),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'where idea will be displayed',
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              //likes button 자리
              IconButton(
                  icon: SvgPicture.asset('icons/002-microphone.svg'),
                  onPressed: () {}),
              //00명 참여중 자리
              IconButton(
                  icon: SvgPicture.asset('icons/002-microphone.svg'),
                  onPressed: () {}),
            ],
          ),
        ],
      ),
    );
  }
}
