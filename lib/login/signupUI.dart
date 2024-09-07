import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pradhangroup/login/loginUI.dart';
import 'package:pradhangroup/login/otpforsignup.dart';
import 'package:pradhangroup/main.dart';

import '../navigationmenu.dart';

class signupUI extends StatefulWidget {
  const signupUI({super.key});

  @override
  State<signupUI> createState() => _signupUIState();
}

class _signupUIState extends State<signupUI> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;
  String? verificationId;

  Future _verifyPhoneNumber() async {
    await _auth.verifyPhoneNumber(
      phoneNumber: "+91" + phoneController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        log("Failed to Verify Phone Number: ${e.message}");
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          this.verificationId = verificationId;
        });

        Fluttertoast.showToast(
              msg: "OTP sent",
              timeInSecForIosWeb: 4,
              gravity: ToastGravity.BOTTOM,
            ).whenComplete(() async {
              await Future.delayed(const Duration(milliseconds: 1000));
              setState(() {
                isLoading = false;
              });
              
              Get.to(() => OTPVerification(
                  name: nameController.text,
                  phone: phoneController.text,
                  verificationId: verificationId,
                  password: passwordController.text));
            });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        setState(() {
          this.verificationId = verificationId;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 69,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Stack(
                  children: [
                    Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(27.5),
                        color: 'F4F4F4'.toColor(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, top: 16),
                      child: Icon(
                        Icons.arrow_back_ios_new_sharp,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Text(
                'Register new account',
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w600,
                    color: '0095D9'.toColor()),
              ),
              SizedBox(height: 24),
              Text(
                'Enter your details to create an account',
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(height: 54),
              TextField(
                controller: nameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: 'Name',
                  filled: true,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/email.png',
                      height: 10,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  fillColor: 'F4F5FA'.toColor(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1, color: 'F4F5FA'.toColor()), //<-- SEE HERE
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: 'Phone number',
                  filled: true,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/email.png',
                      height: 10,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  fillColor: 'F4F5FA'.toColor(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1, color: 'F4F5FA'.toColor()), //<-- SEE HERE
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: 'Password',
                  filled: true,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/Lock.png',
                      height: 10,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  fillColor: 'F4F5FA'.toColor(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1, color: 'F4F5FA'.toColor()), //<-- SEE HERE
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              // SizedBox(height: 20),

              SizedBox(
                height: 10,
              ),
              // if user is not registered then it will show the register button as text button not yet registered?
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already registered ?',
                      style: TextStyle(
                          fontFamily: 'Lexend',
                          fontSize: 14,
                          color: 'A3A3A3'.toColor()),
                    ),
                    TextButton(
                        onPressed: () {
                          Get.to(() => loginui());
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontFamily: 'Lexend',
                              fontSize: 14,
                              color: '0095D9'.toColor()),
                        ))
                  ],
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () async {
                  // Navigator.push(
                  //   context,
                  //
                  //
                  //GMaterialPageRoute(builder: (context) => home()),
                  // );
                  await _verifyPhoneNumber();
          
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 25.0),
                  child: Container(
                    width: double.maxFinite,
                    height: 65,
                    decoration: BoxDecoration(
                        color: '262425'.toColor(),
                        borderRadius: BorderRadius.circular(25)),
                    child: Center(
                        child: Text(
                      'Sign Up',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Lexend'),
                    )),
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
