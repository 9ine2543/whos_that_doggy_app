import 'dart:io';

import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final filename;

  const ResultPage({Key key, this.filename}) : super(key: key);

  final String huskyInfo =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Porttitor risus in cras id viverra neque urna malesuada aliquet.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF514ABF),
      body: SafeArea(
          child: Stack(
        children: [
          Positioned(
            top: 15,
            left: 15,
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                padding: EdgeInsets.zero,
                alignment: Alignment(0.4, 0),
                icon: Icon(Icons.arrow_back_ios),
                iconSize: 25,
                color: Color(0xFF514ABF),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, -0.7),
            child: Text(
              'And ... He\'s',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          Align(
            alignment: Alignment(2, -0.5),
            child: Image.asset('assets/Ellipse 11.png'),
          ),
          Align(
            alignment: Alignment(-2, -0.5),
            child: Image.asset('assets/Ellipse 12.png'),
          ),
          Align(
            alignment: Alignment(0, -0.4),
            child: CircleAvatar(
              backgroundImage: FileImage(File(filename)),
              radius: 125,
            ),
          ),
          Align(
            alignment: Alignment(0, 0.3),
            child: Text(
              'Husky',
              // 'Malamute',
              // 'Eskimo Dog',
              style: TextStyle(color: Colors.white, fontSize: 42, fontWeight: FontWeight.w500),
            ),
          ),
          Align(
            alignment: Alignment(0, 0.5),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.75,
              child: Text(
                huskyInfo,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      )),
    );
  }
}
