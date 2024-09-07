import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pradhangroup/functions/firebase_functions.dart';
import 'package:pradhangroup/functions/userdata_service.dart';
import 'package:pradhangroup/main.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});



  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  bool isQuerying = false;
  TextEditingController queryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(14.0),
        child: GestureDetector(
          onTap: () async {
            if (queryController.text.isEmpty) {
              Fluttertoast.showToast(msg: 'Please enter am issue to submit');
              return;
            }

            setState(() {
              isQuerying = true;
            });

            // Data to be stored in Firebase
            Map<String, dynamic> queryData = {
              'createdAt': Timestamp.fromDate(
                  DateTime.now()), // Using Firestore Timestamp
              
              'query': queryController.text,
              'userDetails': {
                'name': UserDataService.getUserName(),
                'userId': FirebaseAuth.instance.currentUser!.uid,
              }
            };

            log("Query Data ${queryData}");

            try {
              // Adding the data to the 'queries' collection
              await FirebaseFirestore.instance
                  .collection('helpcenter')
                  .add(queryData);

              // Show success toast and clear the text field
              Fluttertoast.showToast(msg: 'Issue submitted successfully!');
              queryController.clear();
              Get.back();
            } catch (e) {
              // Handle error
              Fluttertoast.showToast(msg: 'Failed to submit issue: $e');
            } finally {
              setState(() {
                isQuerying = false;
              });
            }
          },
          child: Container(
            height: 60,
            width: double.maxFinite,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(20)),
            child: Center(
                child: isQuerying
                    ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Text(
                        'Submit Issue',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            fontFamily: 'Lexend',
                            color: Colors.white),
                      )),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 76, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(27.5),
                        color: 'F4F5FA'.toColor(),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        size: 16,
                      ),
                    ),
                  ),
                  Text(
                    'Help Center',
                    style: TextStyle(
                        fontFamily: 'Lexend',
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: 55,
                  )
                ],
              ),
              SizedBox(
                height: 25,
              ),
             
              Text(
                  "Please write your issues and concerns here and we will try to resolve them at the earliest.",
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'Lexend')),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: queryController,
                keyboardType: TextInputType.multiline,
                minLines: 3,
                maxLines: 5,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: 'Write an issue',
                  filled: true,
                  // prefixIcon: Icon(Icons.currency_rupee),
                  fillColor: 'F4F5FA'.toColor(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1, color: 'F4F5FA'.toColor()), //<-- SEE HERE
                    borderRadius: BorderRadius.circular(10.0),
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
