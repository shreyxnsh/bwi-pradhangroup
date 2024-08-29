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
              // Text('New' , style: TextStyle(fontFamily: 'Lexend' , fontSize: 16 , fontWeight: FontWeight.w500) ),
              SizedBox(height: 15,),
              

            ],
          ),
        ),
      ),
    );
  }
}
