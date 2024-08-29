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

class QueryScreen extends StatefulWidget {
  const QueryScreen({super.key, required this.post});

  final Post post;

  @override
  State<QueryScreen> createState() => _QueryScreenState();
}

class _QueryScreenState extends State<QueryScreen> {
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
              Fluttertoast.showToast(msg: 'Please enter a query to submit');
              return;
            }

            setState(() {
              isQuerying = true;
            });

            // Data to be stored in Firebase
            Map<String, dynamic> queryData = {
              'createdAt': Timestamp.fromDate(
                  DateTime.now()), // Using Firestore Timestamp
              'postDetails': {
                'name': widget.post.name,
                'postId': widget.post.id,
              },
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
                  .collection('queries')
                  .add(queryData);

              // Show success toast and clear the text field
              Fluttertoast.showToast(msg: 'Query submitted successfully!');
              queryController.clear();
              Get.back();
            } catch (e) {
              // Handle error
              Fluttertoast.showToast(msg: 'Failed to submit query: $e');
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
                        'Submit Query',
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
                    'Submit a Query',
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
              Container(
                decoration: BoxDecoration(
                    color: 'F4F5FA'.toColor(),
                    borderRadius: BorderRadius.circular(25)),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: CachedNetworkImage(
                          imageUrl: widget.post.coverPic,
                          height: 160,
                          width: MediaQuery.of(context).size.width * 0.37,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                      // Image.asset('assets/dpic.png' , height: 160,),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, bottom: 20, left: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                                width: size.width * 0.4,
                                child: Text(
                                  widget.post.name,
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontSize: 14, fontFamily: 'Lexend'),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Image.asset(
                              'assets/rate.png',
                              height: 18,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Available for ${widget.post.postType}',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'Lexend',
                                  fontWeight: FontWeight.w300),
                            ),
                            SizedBox(height: 18),
                            Row(
                              children: [
                                Image.asset(
                                  'assets/bloc.png',
                                  height: 18,
                                ),
                                Text(
                                  widget.post.city,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Query',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Lexend'),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                  "You may write a query if you're interested in the property and we will contact you soon.",
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
                  hintText: 'Write a query ',
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
