import 'package:flutter/material.dart';
import 'package:whos_that_doggy_app/page/getting-start.dart';
import 'package:whos_that_doggy_app/page/home.dart';
import 'package:whos_that_doggy_app/service/preference.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  bool started = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  void init() async {
    started = await Preference().checkPreference();
  }

  @override
  Widget build(BuildContext context) {
    return HomePage();
    // return started ? HomePage() : GettingStarted();
  }
}
