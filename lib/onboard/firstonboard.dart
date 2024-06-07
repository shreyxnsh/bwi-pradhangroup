import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pradhangroup/Home.dart';
import 'package:pradhangroup/login/loginUI.dart';
import 'package:pradhangroup/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoard extends StatefulWidget {
  @override
  _OnBoardState createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {

  @override
  void initState() {


  }
  setint() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    pre.setInt("onboardint", 1);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  Text('Find ', style: TextStyle(fontSize: 32 , fontFamily: 'Lexend' , fontWeight: FontWeight.w600),),
                  Text('Nearby', style: TextStyle(fontSize: 32 , fontFamily: 'Lexend' , fontWeight: FontWeight.w600 , color: '0095D9'.toColor()),),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text('Locations', style: TextStyle(fontSize: 32 , fontFamily: 'Lexend' , fontWeight: FontWeight.w600 , color: '0095D9'.toColor()),),
            ),
            SizedBox(height: 60),

           Stack(alignment: Alignment.bottomCenter,
             children: [

               Image.asset('assets/onboard.png'),
               GestureDetector(
                 onTap: ()  {
                   setint();
                   Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => loginui()),
                   );
                 },
                 child: Padding(
                   padding: const EdgeInsets.only(left: 20.0 , right: 20 , bottom: 25),
                   child: Container(
                     width: double.maxFinite,
                     height: 65,
                     decoration: BoxDecoration(
                     color: '262425'.toColor(),
                     borderRadius: BorderRadius.circular(25)
                   ),
                   child:Center(child: Text('Get Started', style: TextStyle(fontSize: 16,color: Colors.white , fontWeight: FontWeight.w500 , fontFamily: 'Lexend'),)),),
                 ),
               )
             ],
           )
          ],
        ),

      ),
    );

  }
}
