import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pradhangroup/Home.dart';
import 'package:pradhangroup/login/loginUI.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firstonboard.dart';

class splash extends StatefulWidget {
  @override
  _splashState createState() => _splashState();
}

class _splashState extends State<splash> {
  int incoming = 0;
  settingint() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    incoming = pre.getInt("onboardint")!;
  }

  @override
  void initState() {
    settingint();
    super.initState();

    // check if user is logged in if yes go to home else go to login page
    var user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Timer(
          Duration(seconds: 2, microseconds: 50),
          () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => home())));
    } else {
      Timer(
          Duration(seconds: 2, microseconds: 50),
          () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => loginui())));
    }

    // Timer(Duration(seconds: 2, microseconds: 50),
    //         ()=>Navigator.pushReplacement(context,
    //         MaterialPageRoute(builder:
    //             (context) =>
    //         incoming == 0 ? OnBoard() : home()
    //         )
    //     )
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Colors.white,
              ],
            )),
          ),
          Image.asset(
            'assets/Logo.png',
            height: 152,
          )
        ],
      ),
    );
  }
}
