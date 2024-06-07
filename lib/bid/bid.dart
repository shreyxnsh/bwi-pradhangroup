import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pradhangroup/bid/biddone.dart';
import 'package:pradhangroup/main.dart';

class bid extends StatefulWidget {
  const bid({super.key});

  @override
  State<bid> createState() => _bidState();
}

class _bidState extends State<bid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top:76 , left: 20 , right: 20),
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
                    Text('Place Bid' , style: TextStyle(fontFamily: 'Lexend' , fontSize: 18 , fontWeight: FontWeight.w500),),
                    SizedBox(width: 55,)
                  ],
                ),
                SizedBox(height: 40,),
                Container(
                  decoration: BoxDecoration(
                      color: 'F4F5FA'.toColor(),
                      borderRadius: BorderRadius.circular(25)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top:10, bottom: 10),
                    child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset('assets/dpic.png' , height: 160,),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 20 , left: 16),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('2011, Sultanpur,\nManesar',style: TextStyle(fontSize: 14, fontFamily: 'Lexend'),),
                              SizedBox(height: 10,),
                              Image.asset('assets/rate.png' , height: 18,),
                              SizedBox(height: 10,),
                              Text('Available for Sale', style: TextStyle(fontSize: 13 ,fontFamily: 'Lexend' ,fontWeight: FontWeight.w300),),
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

                      ],
                    ),
                  ),
                ),
                SizedBox(height: 45,),
                Text('Place your Bid' , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.w500 , fontFamily: 'Lexend'),),
                SizedBox(height: 15,),
                Text('You can place your Bid on this property, you will be notified on result declaration.'
                    , style: TextStyle(fontSize: 13 , fontWeight: FontWeight.w300 , fontFamily: 'Lexend')),
                SizedBox(height: 45,),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,


                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: 'Amount',
                    filled: true,
                    prefixIcon: Icon(Icons.currency_rupee),
                    fillColor: 'F4F5FA'.toColor(),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(width: 1, color: 'F4F5FA'.toColor()), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(10.0),
                    ),

                  ),
                ),
                SizedBox(height: 90,),

                GestureDetector(
                  onTap: (){

                    Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context) => biddone()),);
                  },
                  child: Container(
                    height: 60,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Center(child: Text('Place Bid' , style: TextStyle(fontWeight: FontWeight.w400 , fontSize: 15 , fontFamily: 'Lexend' , color: Colors.white),)),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
