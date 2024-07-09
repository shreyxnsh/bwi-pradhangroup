import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pradhangroup/main.dart';

import '../FuncScreen/postDetails.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool all = true;
  bool top = false;
  bool manesar = false;
  bool price = false;
  refresh(){
    all = false;
    top = false;
    manesar = false;
    price = false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 60.0 , left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(

                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Container(
                    //   height: 55,
                    //   width: 55,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(27.5),
                    //     color: 'F4F5FA'.toColor(),

                    //   ),
                    //   child: Icon(Icons.arrow_back_ios_new , size: 16,),
                    // ),
                    Text('Search' , style: TextStyle(fontFamily: 'Lexend' , fontSize: 18 , fontWeight: FontWeight.w500),),
                    SizedBox(width: 55,)


                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(height: 56,
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,


                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: 'Search',
                    hintStyle: TextStyle(color: '737373'.toColor() , fontFamily: 'Lexend',fontWeight: FontWeight.w300),
                    filled: true,
                    prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.search ,size: 24,)
                    ),
                    fillColor: 'F4F5FA'.toColor(),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(width: 1, color: 'F4F5FA'.toColor()), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(10.0),
                    ),

                  ),
                ),
              ),
              SizedBox(height: 30,),
              Align(alignment: Alignment.topLeft,
                  child: Text('Explore Listings' , style: TextStyle(fontWeight: FontWeight.w500 , fontSize: 18, fontFamily: 'Lexend'),)),
              SizedBox(height: 22,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap:(){
                        setState(() {
                          refresh();
                          all = true;
                        });
                      },
                      child: Container(
                        height: 50,
                        width: 102,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color:(all == true)?'262425'.toColor():'F4F5FA'.toColor()
                        ),
                        child: Center(child: Text('All', style: TextStyle(fontSize: 12 , fontWeight: (all == true)?FontWeight.w700:FontWeight.w300 , color: (all == true)?Colors.white:Colors.black),)),
                      ),
                    ),
                    SizedBox(width: 14,),
                    GestureDetector(
                      onTap:(){
                        setState(() {
                          refresh();
                          top = true;
                        });
                      },
                      child: Container(
                        height: 50,
                        width: 102,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color:(top == true)?'262425'.toColor():'F4F5FA'.toColor()
                        ),
                        child: Center(child: Text('Top Rated', style: TextStyle(fontSize: 12 , fontWeight: (top == true)?FontWeight.w700:FontWeight.w300 , color: (top == true)?Colors.white:Colors.black),)),
                      ),
                    ),
                    SizedBox(width: 14,),
                    GestureDetector(
                      onTap:(){
                        setState(() { 
                          refresh();
                          manesar = true;
                        });
                      },
                      child: Container(
                        height: 50,
                        width: 102,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color:(manesar == true)?'262425'.toColor():'F4F5FA'.toColor()
                        ),
                        child: Center(child: Text('Manesar', style: TextStyle(fontSize: 12 , fontWeight: (manesar == true)?FontWeight.w700:FontWeight.w300 , color: (manesar == true)?Colors.white:Colors.black),)),
                      ),
                    ),
                    SizedBox(width: 14,),
                    GestureDetector(
                      onTap:(){
                        setState(() {
                          refresh();
                          price = true;
                        });
                      },
                      child: Container(
                        height: 50,
                        width: 122,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color:(price == true)?'262425'.toColor():'F4F5FA'.toColor()
                        ),
                        child: Center(child: Text('Price-Low to High', style: TextStyle(fontSize: 12 , fontWeight: (price == true)?FontWeight.w700:FontWeight.w300 , color: (price == true)?Colors.white:Colors.black),)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 28),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap:(){
                        // Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context) => details()),);
                      },
                      child: Container(
                        height: 254,
                        decoration: BoxDecoration(
                          color: 'F4F5FA'.toColor(),
                          borderRadius: BorderRadius.circular(25)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset('assets/ex1.png' , height: 164,),
                              SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.only(left:8.0),
                                child: Text('203, Farakh Nagar  ' , style: TextStyle(fontSize: 15, fontFamily: 'Lexend' , fontWeight: FontWeight.w400),),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left:5.0, top: 4),
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Image.asset('assets/bloc.png' , height: 16,),
                                        Text('0.2 Km away')
                                      ],
                                    ),
                                    SizedBox(width: 23),
                                    Image.asset('assets/rate.png',height: 18,)
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    GestureDetector(
                      onTap:(){
                        // Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context) => details()),);
                      },
                      child: Container(
                        height: 254,
                        decoration: BoxDecoration(
                            color: 'F4F5FA'.toColor(),
                            borderRadius: BorderRadius.circular(25)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset('assets/ex3.png' , height: 164,),
                              SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.only(left:8.0),
                                child: Text('Manesar , 1202 ' , style: TextStyle(fontSize: 15, fontFamily: 'Lexend' , fontWeight: FontWeight.w400),),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left:5.0, top: 4),
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Image.asset('assets/bloc.png' , height: 16,),
                                        Text('0.2 Km away')
                                      ],
                                    ),
                                    SizedBox(width: 23),
                                    Image.asset('assets/rate.png',height: 18,)
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    GestureDetector(
                      onTap:(){
                        // Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context) => details()),);
                      },
                      child: Container(
                        height: 254,
                        decoration: BoxDecoration(
                            color: 'F4F5FA'.toColor(),
                            borderRadius: BorderRadius.circular(25)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset('assets/ex2.png' , height: 164,),
                              SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.only(left:8.0),
                                child: Text('26, Sultanpur  ' , style: TextStyle(fontSize: 15, fontFamily: 'Lexend' , fontWeight: FontWeight.w400),),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left:5.0, top: 4),
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Image.asset('assets/bloc.png' , height: 16,),
                                        Text('0.2 Km away')
                                      ],
                                    ),
                                    SizedBox(width: 23),
                                    Image.asset('assets/rate.png',height: 18,)
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 50,)

            ],
          ),
        ),
      ),
    );
  }
}
