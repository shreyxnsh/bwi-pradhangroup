import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pradhangroup/navigationmenu.dart';
import 'package:pradhangroup/main.dart';

class biddone extends StatefulWidget {
  const biddone({super.key});

  @override
  State<biddone> createState() => _biddoneState();
}

class _biddoneState extends State<biddone> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0 , right: 20 , top: 200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/done.png' , height: 150,),
                SizedBox(height: 58,),
                Text('Bid Placed Successfully!' , style: TextStyle(fontWeight: FontWeight.w500 , fontSize: 24, fontFamily: 'Lexend'),),
                SizedBox(height: 25,),
                Text('Your Bid has been placed successfully. \nYou will be notified on result declaration' , style: TextStyle(fontWeight: FontWeight.w300 , fontSize: 13, fontFamily: 'Lexend'),),
                Spacer(),
               /* GestureDetector(
                  onTap: (){
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder:
                            (context) =>
                         home()
                        )
                    );
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
                ),*/
                SizedBox(height: 40,),
                GestureDetector(
                  onTap: (){
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder:
                    (context) =>
                        NavigationMenu()
                    ));
                  },
                    child: Text('Go to Home' , style: TextStyle(fontSize: 16 , fontFamily: 'Lexend' , fontWeight: FontWeight.w400 ,color: '0095D9'.toColor()),)),
                SizedBox(height: 40,)

              ],
            ),
          ),
        ),
      ),
    );
  }
}
