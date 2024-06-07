import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pinput/pinput.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pradhangroup/functions/firebase_functions.dart';
import 'package:pradhangroup/main.dart';
import '../Home.dart';
import 'signupUI.dart';

class OTPVerificationLogin extends StatefulWidget {
  OTPVerificationLogin({super.key, required this.phone, required this.verificationId});

  final String phone;
  final String verificationId;

  @override
  State<OTPVerificationLogin> createState() => _OTPVerificationLoginState();
}

class _OTPVerificationLoginState extends State<OTPVerificationLogin> {
  bool isLoading = false;
  bool isVerified = false;
  TextEditingController totpAuthController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // String verificationId = "";

  final defaultPinTheme = const PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(),
  );

  final cursor = Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
        width: 56,
        height: 3,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ],
  );

  final preFilledWidget = Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
        width: 56,
        height: 3,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ],
  );

  @override
  void initState() {
    super.initState();
    // _verifyPhoneNumber();
  }

  // void _verifyPhoneNumber() async {
  //   await _auth.verifyPhoneNumber(
  //     phoneNumber: "+91"+widget.phone,
  //     verificationCompleted: (PhoneAuthCredential credential) async {
  //       await _auth.signInWithCredential(credential);
  //     },
  //     verificationFailed: (FirebaseAuthException e) {
  //       log("Failed to Verify Phone Number: ${e.message}");
  //     },
  //     codeSent: (String verificationId, int? resendToken) {
  //       setState(() {
  //         this.verificationId = verificationId;
  //       });
  //     },
  //     codeAutoRetrievalTimeout: (String verificationId) {
  //       setState(() {
  //         this.verificationId = verificationId;
  //       });
  //     },
  //   );
  // }

    Future storeUser() async {
    final box = GetStorage();
    final user = FirebaseAuth.instance.currentUser;

    // fetch data from firebase and store it in get storage as this user uid exists in the users collection
    // so we can fetch the data from the users collection using this uid

   var userData = await FirebaseFunctions().fetchUserbyID(user!.uid);
    await box.write('name', userData!.name);
    await box.write('phoneNo', userData.phoneNo);
    await box.write('createdAt', userData.createdAt);
    await box.write('isVerified', userData.isVerified);
    await box.write('uid', userData.uid);
  }


    handleOtpSubmit() async {
    try {
      setState(() {
        isLoading = true;
      });
// Check if OTP has exactly 6 digits
      if (totpAuthController.text.length != 6) {
        Fluttertoast.showToast(
          msg: "Please enter a valid 6-digit OTP",
          timeInSecForIosWeb: 4,
          gravity: ToastGravity.BOTTOM,
        );
        setState(() {
          isLoading = false;
        });
        return;
      }
      // SharedPreferences _prefs = await SharedPreferences.getInstance();
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: widget.verificationId,
          smsCode: totpAuthController.text.toString().trim());

      await _auth.signInWithCredential(credential).then((value) async {
       
          // Navigator.pushReplacementNamed(context, AppRoutes.bottomContainer);
          // uploadDeviceToken();
          // Navigator.pushNamedAndRemoveUntil(
          //   context,
          //   AppRoutes.bottomContainer,
          //   (route) => false,
          // );

          
        await storeUser();
        Get.to(() => home());
      }).catchError((e) {
        if (FirebaseAuth.instance.currentUser?.uid != null) {
          Fluttertoast.showToast(msg: 'Invalid user Otp...');
        } else {
          Fluttertoast.showToast(msg: 'Invalid Otp...');
          setState(() {
            totpAuthController.clear();
            isLoading = false;
          });
        }
      });
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error during OTP submission: $e",
        timeInSecForIosWeb: 4,
        gravity: ToastGravity.BOTTOM,
      );
      setState(() {
        isLoading = false;
      });
    }
  }



  void _signInWithPhoneNumber(String smsCode) async {
    setState(() {
      isLoading = true;
    });

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: widget.verificationId, smsCode: smsCode);

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      if (userCredential.user != null) {
      


        Get.to(() => home());

        // Navigate to home
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => home()),
        // );
      }
    } catch (e) {
      log("Error: $e");
    } finally {
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
                'OTP Verification',
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w600,
                    color: '0095D9'.toColor()),
              ),
              SizedBox(height: 24),
              Text(
                'Enter the 6 digit OTP sent to your mobile number',
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(height: 54),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Pinput(
                    controller: totpAuthController,
                    defaultPinTheme: defaultPinTheme,
                    submittedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration?.copyWith(
                        color: isVerified
                            ? const Color.fromRGBO(206, 255, 210, 1)
                            : const Color.fromRGBO(234, 239, 243, 1),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    length: 6,
                    onChanged: (s) {
                      setState(() {
                        isVerified = s.length == 6;
                      });
                    },
                    cursor: cursor,
                    preFilledWidget: preFilledWidget,
                    pinAnimationType: PinAnimationType.slide,
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    showCursor: true,
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Center(
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Text(
              //         'Not yet registered ?',
              //         style: TextStyle(
              //             fontFamily: 'Lexend',
              //             fontSize: 14,
              //             color: 'A3A3A3'.toColor()),
              //       ),
              //       TextButton(
              //           onPressed: () {
              //             Get.to(() => signupUI());
              //           },
              //           child: Text(
              //             'Register',
              //             style: TextStyle(
              //                 fontFamily: 'Lexend',
              //                 fontSize: 14,
              //                 color: '0095D9'.toColor()),
              //           ))
              //     ],
              //   ),
              // ),
              Spacer(),
              GestureDetector(
                onTap:  () {
                        // _signInWithPhoneNumber(totpAuthController.text);
                        handleOtpSubmit();
                      },
                  
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 25.0),
                  child: Container(
                    width: double.maxFinite,
                    height: 65,
                    decoration: BoxDecoration(
                        color: isVerified
                            ? '262425'.toColor()
                            : Colors.grey,
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
