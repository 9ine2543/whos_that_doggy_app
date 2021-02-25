import 'package:flutter/material.dart';
import 'package:whos_that_doggy_app/page/result.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whos_that_doggy_app/service/animation.dart';
import 'package:whos_that_doggy_app/service/preference.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
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

  bool started = false;
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    ))
      ..addListener(() {
        setState(() {});
      });
    started = await Preference().checkPreference();
    // print(started);
    setState(() {});
  }

  forwardAnimation() {
    controller.forward(from: 0);

    stateBloc.toggleAnimation();
  }

  reverseAnimation() {
    controller.reverse(from: 1);

    stateBloc.toggleAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // started || animation.value == 1
          //     ? Align(
          //         alignment: Alignment(0, -0.7),
          //         child: Text(
          //           '" Love Me\nLove My Dog "',
          //           style: TextStyle(
          //             color: Color(0xFFBEC7DE),
          //             fontSize: 32,
          //             fontWeight: FontWeight.w500,
          //           ),
          //           textAlign: TextAlign.center,
          //         ),
          //       )
          //     :
          Positioned(
              left: 30,
              top: 80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'WHO\'S\nTHAT DOGGY ?',
                    style: TextStyle(
                      color: Color(0xFF5850D9),
                      fontWeight: FontWeight.w700,
                      fontSize: 36,
                      letterSpacing: -0.5,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Placerat habitasse at a dis faucibus dictum lacus interdum.',
                      style: TextStyle(
                        color: Color(0xFFABB3C8),
                        fontSize: 14,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                ],
              )),
          Positioned(
            bottom: started ? 120 : 60 + (60 * animation.value),
            child: Image.asset('assets/bg.png'),
          ),
          started || animation.value == 1
              ? Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  color: Color(0x660C1927),
                )
              : Container(),
          Align(
            alignment: Alignment(0, 0.9),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.75,
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xff6C63FF),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(color: Colors.grey[400], blurRadius: 3, offset: Offset(0, 4)),
                ],
              ),
              child: FlatButton(
                child: Text(
                  'Get Started',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  forwardAnimation();
                  await Preference().savePreference();
                },
              ),
            ),
          ),
          Positioned(bottom: started ? 0 : -180 + (180 * animation.value), child: bottomMenu()),
        ],
      ),
    );
  }

  Widget bottomMenu() {
    return Container(
      width: MediaQuery.of(context).size.width,
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
    );
  }
}
