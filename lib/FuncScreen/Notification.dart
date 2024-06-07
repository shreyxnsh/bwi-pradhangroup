import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pradhangroup/main.dart';

class Notificationj extends StatefulWidget {
  const Notificationj({super.key});

  @override
  State<Notificationj> createState() => _NotificationState();
}

class _NotificationState extends State<Notificationj> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top:76 , left: 20 , right: 20),
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(27.5),
                        color: 'F4F5FA'.toColor(),

                      ),
                      child: Icon(Icons.arrow_back_ios_new , size: 16,),
                    ),
                  ),
                  Text('Notification' , style: TextStyle(fontFamily: 'Lexend' , fontSize: 18 , fontWeight: FontWeight.w500),),
                  SizedBox(width: 55,)
                ],
              ),
              SizedBox(height: 20,),
              Text('New' , style: TextStyle(fontFamily: 'Lexend' , fontSize: 16 , fontWeight: FontWeight.w500) ),
              SizedBox(height: 15,),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 142,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: 'F4F5FA'.toColor()
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 14.0 , top: 14 , right: 14 ),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('assets/bprofile.png' , width: 45,),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Theresa Webb', style: TextStyle(fontSize: 16 , fontWeight: FontWeight.w400 , fontFamily: 'Lexend'),),
                            Text('Lorem ipsum dolor sit amet, consectetur', style: TextStyle(fontSize: 13 , fontWeight: FontWeight.w400 , fontFamily: 'Lexend'),),
                            Row(
                              children: [
                                Text('adipiscing elit, sed do ', style: TextStyle(fontSize: 13 , fontWeight: FontWeight.w400 , fontFamily: 'Lexend'),),
                                Text('eiusmod tempor', style: TextStyle(fontSize: 13 , fontWeight: FontWeight.w400 , fontFamily: 'Lexend' , color: '0095D9'.toColor()),),
                              ],
                            ),
                            Text('incididunt ut labore ', style: TextStyle(fontSize: 13 , fontWeight: FontWeight.w400 , fontFamily: 'Lexend'),),
                            SizedBox(height: 12,),
                            Text('2 mins ago', style: TextStyle(fontSize: 13 , fontWeight: FontWeight.w300 , fontFamily: 'Lexend' , color: '0095D9'.toColor()),),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 142,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: 'F4F5FA'.toColor()
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 14.0 , top: 14 , right: 14 ),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('assets/n2.png' , width: 45,),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('New Properties', style: TextStyle(fontSize: 16 , fontWeight: FontWeight.w400 , fontFamily: 'Lexend'),),
                            SizedBox(height: 10,),
                            Text('Lorem ipsum dolor sit amet, consectetur', style: TextStyle(fontSize: 13 , fontWeight: FontWeight.w400 , fontFamily: 'Lexend'),),
                            Row(
                              children: [
                                Text('adipiscing elit, sed do ', style: TextStyle(fontSize: 13 , fontWeight: FontWeight.w400 , fontFamily: 'Lexend'),),
                                Text('eiusmod tempor', style: TextStyle(fontSize: 13 , fontWeight: FontWeight.w400 , fontFamily: 'Lexend' , color: '0095D9'.toColor()),),
                              ],
                            ),
                            Text('incididunt ut labore ', style: TextStyle(fontSize: 13 , fontWeight: FontWeight.w400 , fontFamily: 'Lexend'),),
                            SizedBox(height: 12,),
                            Text('2 mins ago', style: TextStyle(fontSize: 13 , fontWeight: FontWeight.w300 , fontFamily: 'Lexend' , color: '0095D9'.toColor()),),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 142,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: 'F4F5FA'.toColor()
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 14.0 , top: 14 , right: 14 ),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('assets/n3.png' , width: 45,),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Trending Commercials', style: TextStyle(fontSize: 16 , fontWeight: FontWeight.w400 , fontFamily: 'Lexend'),),
                            SizedBox(height: 10,),
                            Text('Lorem ipsum dolor sit amet, consectetur', style: TextStyle(fontSize: 13 , fontWeight: FontWeight.w400 , fontFamily: 'Lexend'),),
                            Row(
                              children: [
                                Text('adipiscing elit, sed do ', style: TextStyle(fontSize: 13 , fontWeight: FontWeight.w400 , fontFamily: 'Lexend'),),
                                Text('eiusmod tempor', style: TextStyle(fontSize: 13 , fontWeight: FontWeight.w400 , fontFamily: 'Lexend' , color: '0095D9'.toColor()),),
                              ],
                            ),
                            Text('incididunt ut labore ', style: TextStyle(fontSize: 13 , fontWeight: FontWeight.w400 , fontFamily: 'Lexend'),),
                            SizedBox(height: 12,),
                            Text('3 mins ago', style: TextStyle(fontSize: 13 , fontWeight: FontWeight.w300 , fontFamily: 'Lexend' , color: '0095D9'.toColor()),),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 142,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: 'F4F5FA'.toColor()
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 14.0 , top: 14 , right: 14 ),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('assets/bprofile.png' , width: 45,),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Theresa Webb', style: TextStyle(fontSize: 16 , fontWeight: FontWeight.w400 , fontFamily: 'Lexend'),),
                            SizedBox(height: 10,),
                            Text('Lorem ipsum dolor sit amet, consectetur', style: TextStyle(fontSize: 13 , fontWeight: FontWeight.w400 , fontFamily: 'Lexend'),),
                            Row(
                              children: [
                                Text('adipiscing elit, sed do ', style: TextStyle(fontSize: 13 , fontWeight: FontWeight.w400 , fontFamily: 'Lexend'),),
                                Text('eiusmod tempor', style: TextStyle(fontSize: 13 , fontWeight: FontWeight.w400 , fontFamily: 'Lexend' , color: '0095D9'.toColor()),),
                              ],
                            ),
                            Text('incididunt ut labore ', style: TextStyle(fontSize: 13 , fontWeight: FontWeight.w400 , fontFamily: 'Lexend'),),
                            SizedBox(height: 12,),
                            Text('5 mins ago', style: TextStyle(fontSize: 13 , fontWeight: FontWeight.w300 , fontFamily: 'Lexend' , color: '0095D9'.toColor()),),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
