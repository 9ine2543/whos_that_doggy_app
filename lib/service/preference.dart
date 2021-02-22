import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  Preference();

  Future<bool> checkPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('first');
  }

  savePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('first', true);
  }
}
