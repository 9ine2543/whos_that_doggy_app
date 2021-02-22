import 'package:flutter/material.dart';
import 'package:whos_that_doggy_app/page/result.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String path = '';

  Future takeImg() async {
    final pickerImg = await ImagePicker().getImage(source: ImageSource.camera);
    path = '';
    if (pickerImg != null) path = pickerImg.path;
  }

  Future selectImg() async {
    final pickerImg = await ImagePicker().getImage(source: ImageSource.gallery);
    path = '';
    if (pickerImg != null) path = pickerImg.path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Align(
            alignment: Alignment(0, -0.7),
            child: Text(
              '" Love Me\nLove My Dog "',
              style: TextStyle(
                color: Color(0xFFBEC7DE),
                fontSize: 32,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Align(
            alignment: Alignment(0, 0.1),
            child: Image.asset('assets/bg.png'),
          ),
          Container(
            width: double.maxFinite,
            height: double.maxFinite,
            color: Color(0x660C1927),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.maxFinite,
              height: 180,
              padding: EdgeInsets.only(top: 40),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(),
                  Container(
                    width: 72,
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 72,
                          height: 72,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: FloatingActionButton(
                            heroTag: 'take photo',
                            onPressed: () async {
                              await takeImg();
                              // print('take photo');
                              if (path.length > 0)
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ResultPage(
                                      filename: path,
                                    ),
                                  ),
                                );
                            },
                            backgroundColor: Color(0xff6c63ff),
                            child: Icon(
                              Icons.camera_alt_rounded,
                              size: 35,
                            ),
                          ),
                        ),
                        Text('Take Photo')
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: 72,
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 72,
                          height: 72,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: FloatingActionButton(
                            heroTag: 'upload',
                            onPressed: () async {
                              await selectImg();

                              // () {};
                              if (path.length > 0)
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ResultPage(
                                      filename: path,
                                    ),
                                  ),
                                );
                            },
                            backgroundColor: Color(0xff6c63ff),
                            child: Icon(
                              Icons.cloud_upload_rounded,
                              size: 35,
                            ),
                          ),
                        ),
                        Text('Upload')
                      ],
                    ),
                  ),
                  Spacer()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
