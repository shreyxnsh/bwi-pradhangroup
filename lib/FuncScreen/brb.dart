import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pradhangroup/main.dart';

import '../FuncScreen/Details.dart';

class buy extends StatefulWidget {
  const buy({super.key});

  @override
  State<buy> createState() => _buyState();
}

class _buyState extends State<buy> {
  bool all = true;
  bool ongoing = false;
  bool upcoming = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0 , right: 20 , top: 76),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap:(){
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
                  Text("Buy Property", style: TextStyle(fontWeight: FontWeight.w500 , fontFamily: 'Lexend', fontSize: 18),),
                  Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(27.5),
                      color: 'F4F5FA'.toColor(),

                    ),
                    child: Icon(Icons.search_outlined , size: 18,),
                  ),
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
                            ongoing = false;
                            upcoming = false;
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
                            ongoing = true;
                            upcoming = false;
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 65,
                          decoration: BoxDecoration(
                              color: (ongoing == true)?'262425'.toColor():'F4F5FA'.toColor(),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Center(child: Text('Ongoing' , style: TextStyle(fontSize: 12, fontWeight: (ongoing == true)?FontWeight.w700:FontWeight.w300 , color: (ongoing == true)?Colors.white:Colors.black),)),
                        ),
                      ),
                      SizedBox(width: 12,),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            all = false;
                            ongoing = false;
                            upcoming = true;
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 75,
                          decoration: BoxDecoration(
                              color: (upcoming == true)?'262425'.toColor():'F4F5FA'.toColor(),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Center(child: Text('Upcoming' , style: TextStyle(fontSize: 12, fontWeight: (upcoming == true)?FontWeight.w700:FontWeight.w300 , color: (upcoming == true)?Colors.white:Colors.black),)),
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
                      decoration: BoxDecoration(
                          color: 'F4F5FA'.toColor(),
                          borderRadius: BorderRadius.circular(25)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top:10, left: 10 , bottom: 10),
                        child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset('assets/ex1.png' , height: 160,),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0, bottom: 20 , left: 16),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('2011, Sultanpur,\nManesar',style: TextStyle(fontSize: 14, fontFamily: 'Lexend'),),
                                  SizedBox(height: 10,),
                                  Image.asset('assets/rate.png' , height: 18,),
                                  SizedBox(height: 10,),
                                  Text('Available for Rent', style: TextStyle(fontSize: 13 ,fontFamily: 'Lexend' ,fontWeight: FontWeight.w300),),
                                  SizedBox(height: 18),
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
                      decoration: BoxDecoration(
                          color: 'F4F5FA'.toColor(),
                          borderRadius: BorderRadius.circular(25)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top:10, left: 10 , bottom: 10),
                        child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset('assets/ex2.png' , height: 160,),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0, bottom: 20 , left: 16),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('1451, IIMT,\nGurgaon',style: TextStyle(fontSize: 14, fontFamily: 'Lexend'),),
                                  SizedBox(height: 10,),
                                  Image.asset('assets/rate.png' , height: 18,),
                                  SizedBox(height: 10,),
                                  Text('Available for Rent', style: TextStyle(fontSize: 13 ,fontFamily: 'Lexend' ,fontWeight: FontWeight.w300),),
                                  SizedBox(height: 18),
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
                      decoration: BoxDecoration(
                          color: 'F4F5FA'.toColor(),
                          borderRadius: BorderRadius.circular(25)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top:10, left: 10 , bottom: 10),
                        child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset('assets/ex3.png' , height: 160,),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0, bottom: 20 , left: 16),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('900, Pace city,\nGurgaon',style: TextStyle(fontSize: 14, fontFamily: 'Lexend'),),
                                  SizedBox(height: 10,),
                                  Image.asset('assets/rate.png' , height: 18,),
                                  SizedBox(height: 10,),
                                  Text('Available for Rent', style: TextStyle(fontSize: 13 ,fontFamily: 'Lexend' ,fontWeight: FontWeight.w300),),
                                  SizedBox(height: 18),
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
                      decoration: BoxDecoration(
                          color: 'F4F5FA'.toColor(),
                          borderRadius: BorderRadius.circular(25)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top:10, left: 10 , bottom: 10),
                        child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset('assets/ex4.png' , height: 160,),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0, bottom: 20 , left: 16),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('1202, Sultanpur,\nManesar',style: TextStyle(fontSize: 14, fontFamily: 'Lexend'),),
                                  SizedBox(height: 10,),
                                  Image.asset('assets/rate.png' , height: 18,),
                                  SizedBox(height: 10,),
                                  Text('Available for Rent', style: TextStyle(fontSize: 13 ,fontFamily: 'Lexend' ,fontWeight: FontWeight.w300),),
                                  SizedBox(height: 18),
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
                      decoration: BoxDecoration(
                          color: 'F4F5FA'.toColor(),
                          borderRadius: BorderRadius.circular(25)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top:10, left: 10 , bottom: 10),
                        child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset('assets/ex1.png' , height: 160,),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0, bottom: 20 , left: 16),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('2011, Sultanpur,\nManesar',style: TextStyle(fontSize: 14, fontFamily: 'Lexend'),),
                                  SizedBox(height: 10,),
                                  Image.asset('assets/rate.png' , height: 18,),
                                  SizedBox(height: 10,),
                                  Text('Available for Rent', style: TextStyle(fontSize: 13 ,fontFamily: 'Lexend' ,fontWeight: FontWeight.w300),),
                                  SizedBox(height: 18),
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
