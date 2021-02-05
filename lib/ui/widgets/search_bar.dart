import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final String hintText;

  SearchBar({this.hintText});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Icon(
          Icons.search,
        ),
        Container(
          width: 250,
          child: TextField(
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
