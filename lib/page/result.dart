import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final filename;

  const ResultPage({Key key, this.filename}) : super(key: key);
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
          )
        ],
      )),
    );
  }
}
