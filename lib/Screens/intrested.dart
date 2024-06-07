import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pradhangroup/main.dart';

import '../FuncScreen/Details.dart';

class intrested extends StatefulWidget {
  const intrested({super.key});

  @override
  State<intrested> createState() => _intrestedState();
}

class _intrestedState extends State<intrested> {
  bool all = true ;
  bool recent = false;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0 , right: 20 , top: 76),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Favorites", style: TextStyle(fontWeight: FontWeight.w500 , fontFamily: 'Lexend', fontSize: 18),),
                  Icon(Icons.search , size: 27,)
                ],
              ),
              SizedBox(height: 35,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            all = true;
                            recent = false;
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 65,
                          decoration: BoxDecoration(
                              color: (all == true)?'262425'.toColor():'F4F5FA'.toColor(),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Center(child: Text('All' , style: TextStyle(fontSize: 12, fontWeight: (all == true)?FontWeight.w700:FontWeight.w300 , color: (all == true)?Colors.white:Colors.black),)),
                        ),
                      ),
                      SizedBox(width: 12,),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            all = false;
                            recent = true;
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 65,
                          decoration: BoxDecoration(
                              color: (recent == true)?'262425'.toColor():'F4F5FA'.toColor(),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Center(child: Text('Recent' , style: TextStyle(fontSize: 12, fontWeight: (recent == true)?FontWeight.w700:FontWeight.w300 , color: (recent == true)?Colors.white:Colors.black),)),
                        ),
                      ),
                    ],
                  ),
                  Image.asset('assets/options.png'  , height: 47,)
                ],
              ),
              SizedBox(height: 11,),
              Column(
                children: [
                  GestureDetector(
                    onTap:(){
                      // Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context) => details()),);
                    },
                    child: Container(
                      height: height*0.2,
                      decoration: BoxDecoration(
                        color: 'F4F5FA'.toColor(),
                        borderRadius: BorderRadius.circular(25)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top:10, left: 10 , bottom: 10),
                        child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset('assets/ex1.png' , height: 120,),
                            Padding(
                              padding: const EdgeInsets.only(top: 0, bottom: 20 , left: 16),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('2011, Sultanpur,\nManesar',style: TextStyle(fontSize: 14, fontFamily: 'Lexend'),),
                                  SizedBox(height: 10,),
                                  Image.asset('assets/rate.png' , height: 18,),
                                  SizedBox(height: 5,),
                                  Text('Available for Rent', style: TextStyle(fontSize: 11 ,fontFamily: 'Lexend' ,fontWeight: FontWeight.w300),),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Image.asset('assets/bloc.png' , height: 18,),
                                      Text('New Delhi', style: TextStyle(fontSize: 12 , fontWeight: FontWeight.w400),)
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0 , left: 25),
                              child: Align(child: Icon(Icons.delete_outline), alignment: Alignment.topRight,),
                            )
                          ],


                          
                        ),
                      ),
                    ),
                  ),
                   SizedBox(height: 15,), 
                  GestureDetector(
                    onTap:(){
                      // Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context) => details()),);
                    },
                    child: Container(
                      height: height*0.2,
                      decoration: BoxDecoration(
                        color: 'F4F5FA'.toColor(),
                        borderRadius: BorderRadius.circular(25)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top:10, left: 10 , bottom: 10),
                        child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset('assets/ex1.png' , height: 120,),
                            Padding(
                              padding: const EdgeInsets.only(top: 0, bottom: 20 , left: 16),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('2011, Sultanpur,\nManesar',style: TextStyle(fontSize: 14, fontFamily: 'Lexend'),),
                                  SizedBox(height: 10,),
                                  Image.asset('assets/rate.png' , height: 18,),
                                  SizedBox(height: 5,),
                                  Text('Available for Rent', style: TextStyle(fontSize: 11 ,fontFamily: 'Lexend' ,fontWeight: FontWeight.w300),),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Image.asset('assets/bloc.png' , height: 18,),
                                      Text('New Delhi', style: TextStyle(fontSize: 12 , fontWeight: FontWeight.w400),)
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0 , left: 25),
                              child: Align(child: Icon(Icons.delete_outline), alignment: Alignment.topRight,),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  GestureDetector(
                    onTap:(){
                      // Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context) => details()),);
                    },
                    child: Container(
                      height: height*0.2,
                      decoration: BoxDecoration(
                        color: 'F4F5FA'.toColor(),
                        borderRadius: BorderRadius.circular(25)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top:10, left: 10 , bottom: 10),
                        child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset('assets/ex1.png' , height: 120,),
                            Padding(
                              padding: const EdgeInsets.only(top: 0, bottom: 20 , left: 16),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('2011, Sultanpur,\nManesar',style: TextStyle(fontSize: 14, fontFamily: 'Lexend'),),
                                  SizedBox(height: 10,),
                                  Image.asset('assets/rate.png' , height: 18,),
                                  SizedBox(height: 5,),
                                  Text('Available for Rent', style: TextStyle(fontSize: 11 ,fontFamily: 'Lexend' ,fontWeight: FontWeight.w300),),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Image.asset('assets/bloc.png' , height: 18,),
                                      Text('New Delhi', style: TextStyle(fontSize: 12 , fontWeight: FontWeight.w400),)
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0 , left: 25),
                              child: Align(child: Icon(Icons.delete_outline), alignment: Alignment.topRight,),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}
