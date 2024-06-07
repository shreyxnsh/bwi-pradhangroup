import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pradhangroup/main.dart';

class psetting extends StatefulWidget {
  const psetting({super.key});

  @override
  State<psetting> createState() => _psettingState();
}

class _psettingState extends State<psetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 60.0 , left: 20, right: 20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(

                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      Text('Profile' , style: TextStyle(fontFamily: 'Lexend' , fontSize: 18 , fontWeight: FontWeight.w500),),

                      Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(27.5),
                          color: 'F4F5FA'.toColor(),

                        ),
                        child: Icon(Icons.settings_outlined , size: 22,),
                      ),



                    ],
                  ),
                ),
                SizedBox(height: 30,),
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                        border: Border.all(color: 'F4F4F4'.toColor(), width: 8),
                      borderRadius: BorderRadius.circular(65),

                    ),
                    child: Image.asset('assets/Camera.png' , height: 44,),
                  ),
                ),
                SizedBox(height: 30,),
                Text('Name', style: TextStyle(fontSize: 14 ,fontWeight: FontWeight.w300 , fontFamily: 'Lexend'),),
                SizedBox(height: 20,),
                TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,


                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: 'Name',
                    filled: true,

                    fillColor: 'F4F5FA'.toColor(),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(width: 1, color: 'F4F5FA'.toColor()), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(10.0),
                    ),

                  ),
                ),
                SizedBox(height: 24,),
                Text('Email', style: TextStyle(fontSize: 14 ,fontWeight: FontWeight.w300 , fontFamily: 'Lexend'),),
                SizedBox(height: 20,),
                TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,


                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: 'Email',
                    filled: true,

                    fillColor: 'F4F5FA'.toColor(),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(width: 1, color: 'F4F5FA'.toColor()), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(10.0),
                    ),

                  ),
                ),
                SizedBox(height: 24,),
                Text('Password', style: TextStyle(fontSize: 14 ,fontWeight: FontWeight.w300 , fontFamily: 'Lexend'),),
                SizedBox(height: 20,),
                TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,


                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: 'Password',
                    filled: true,

                    fillColor: 'F4F5FA'.toColor(),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(width: 1, color: 'F4F5FA'.toColor()), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(10.0),
                    ),

                  ),
                ),
                SizedBox(height: 24,),
                Text('Contact Number', style: TextStyle(fontSize: 14 ,fontWeight: FontWeight.w300 , fontFamily: 'Lexend'),),
                SizedBox(height: 20,),
                TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,


                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: '',
                    filled: true,

                    fillColor: 'F4F5FA'.toColor(),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(width: 1, color: 'F4F5FA'.toColor()), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(10.0),
                    ),

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
