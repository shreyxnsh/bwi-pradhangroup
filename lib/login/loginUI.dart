

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pradhangroup/functions/firebase_functions.dart';
import 'package:pradhangroup/login/otpforlogin.dart';
import 'package:pradhangroup/login/signupUI.dart';
import 'package:pradhangroup/main.dart';
import 'package:pradhangroup/widgets/loginTextField.dart';

import '../Home.dart';

class loginui extends StatefulWidget {
  const loginui({super.key});

  @override
  State<loginui> createState() => _loginuiState();
}

class _loginuiState extends State<loginui> {

  TextEditingController phoneController = TextEditingController();

  bool isLoading = false;
  String? _verificationCode;

  
  handlePhoneSubmit() async {
    String phoneNumber = phoneController.text;
    String phoneWithCountryCode = "+91$phoneNumber";

    log("Phone number : "+phoneWithCountryCode);
    

    if (phoneNumber == "" || phoneNumber.length > 10) {
      Fluttertoast.showToast(msg: "Invalid Phone Number");
      return;
    }

    setState(() {
      isLoading = true;
    });
    bool userExists = await FirebaseFunctions().checkUserExists(phoneController.text);

    if (userExists) {
      try {
        setState(() {
          isLoading = true;
        });

        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phoneWithCountryCode,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await FirebaseAuth.instance.signInWithCredential(credential);
          },
          verificationFailed: (FirebaseAuthException e) {
            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(
              msg: "${e.message}",
              timeInSecForIosWeb: 4,
              gravity: ToastGravity.BOTTOM,
            );
          },
          codeSent: (String verificationId, int? resendToken) async {
            setState(() {
              _verificationCode = verificationId;
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
              // Navigator.of(context, rootNavigator: true).push(
              //   MaterialPageRoute(
              //     builder: (context) => OtpScreen(
              //       isSignup: false,
              //       name: '',
              //       phoneNumber: phoneWithCountryCode,
              //       verificationId: _verificationCode!,
              //     ),
              //   ),
              // );
              Get.to(() => OTPVerificationLogin(phone: phoneController.text, verificationId: verificationId));
            });
          },
          codeAutoRetrievalTimeout: (String verificationID) {
            _verificationCode = verificationID;
            print('timeout');
          },
          timeout: const Duration(minutes: 1),
        );
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: '$e');
      }
    } else {
      Fluttertoast.showToast(
        msg: "User doesn't exist, Signup first",
        timeInSecForIosWeb: 4,
        gravity: ToastGravity.BOTTOM,
      );

      setState(() {
        isLoading = false;
      });
    }
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
              Stack(
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
              SizedBox(height: 40),
              Text(
                'Log in',
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w600,
                    color: '0095D9'.toColor()),
              ),
              SizedBox(height: 24),
              Text(
                'Enter User ID and Password provided by admin',
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(height: 20),

              LoginScreenTextFeild(
                keyboardType: TextInputType.phone,
                controller: phoneController,
                labelText: "Phone number",
                prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/email.png',
                      height: 10,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  // fillColor: 'F4F5FA'.toColor(),
                  // enabledBorder: OutlineInputBorder(
                  //   borderSide: BorderSide(
                  //       width: 1, color: 'F4F5FA'.toColor()), //<-- SEE HERE
                  //   borderRadius: BorderRadius.circular(10.0),
                  // ),
              ),
              
              SizedBox(height: 20),
             
              // Align(
              //     alignment: Alignment.bottomRight,
              //     child: Text(
              //       'Forget Password ?',
              //       style: TextStyle(
              //           fontFamily: 'Lexend',
              //           fontSize: 14,
              //           color: '0095D9'.toColor()),
              //     )),
              // SizedBox(
              //   height: 10,
              // ),
              // // if user is not registered then it will show the register button as text button not yet registered?
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not yet registered ?',
                      style: TextStyle(
                          fontFamily: 'Lexend',
                          fontSize: 14,
                          color: 'A3A3A3'.toColor()),
                    ),
                    TextButton(
                        onPressed: () {
                          Get.to(() => signupUI());
                        },
                        child: Text(
                          'Register',
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
                onTap: () {


                  handlePhoneSubmit();
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => home()),
                  // );
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
                      isLoading ? "Verifying..." : "Login",
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
