import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pradhangroup/bid/biddone.dart';
import 'package:pradhangroup/functions/firebase_functions.dart';
import 'package:pradhangroup/functions/userdata_service.dart';
import 'package:pradhangroup/main.dart';
import 'package:http/http.dart' as http;

class bid extends StatefulWidget {
  const bid({super.key, required this.post});

  final Post post;

  @override
  State<bid> createState() => _bidState();
}

class _bidState extends State<bid> {
  TextEditingController amountController = TextEditingController();
  UserDataService userDataService = UserDataService();
  String userName = UserDataService.getUserName();
  bool isBidding = false;

  Future<void> placeBid() async {
    String placeBidUrl =
        "https://us-central1-bwi-pradhan-group.cloudfunctions.net/post-add";
    try {
      setState(() {
        isBidding = true;
      });

      log("Post Bid URL : $placeBidUrl");

      var headers = {
        'Content-Type': 'application/json',
      };
      var request = http.Request('POST', Uri.parse(placeBidUrl));
      request.body = json.encode({
        "data": {
          "postId": widget.post.id,
          "userId": FirebaseAuth.instance.currentUser!.uid,
          "name": userName,
          "amount": int.parse(amountController.text),
        }
      });

      request.headers.addAll(headers);
      log("Request : ${request.body}");
      http.StreamedResponse response = await request.send();
      log("response : ${response.statusCode}");

      Map<String, dynamic> jsonResponse =
          jsonDecode(await response.stream.bytesToString());

      log("response : ${jsonResponse}");

      if (jsonResponse['result']['status'] == 'true') {
        log("Bid Placed Successfully");
        Fluttertoast.showToast(msg: jsonResponse['result']['msg']);
        Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(builder: (context) => biddone()),
        );
      } else {
        log("Error Placing Bid");
        Fluttertoast.showToast(msg: jsonResponse['result']['msg']);
      }

      setState(() {
        isBidding = false;
      });
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error bidding post : $e');
      print('Error adding post: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: SingleChildScrollView(
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
                      'Place Bid',
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
                  'Place your Bid',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Lexend'),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                    'You can place your Bid on this property, you will be notified on result declaration.',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Lexend')),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: amountController,
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
                      borderSide: BorderSide(
                          width: 1, color: 'F4F5FA'.toColor()), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 150,
                ),
                GestureDetector(
                  onTap: () {
                    if (amountController.text.isEmpty) {
                      // show get snackbar that amount needs to be added
                      Fluttertoast.showToast(
                          msg: 'Please enter the amount to place bid');
                      return;
                    }
                    // check if amount is greater than the current bid amount and minimum bid acount
                    // if not show toast that amount is less than the current bid amount
                    if (int.parse(amountController.text) <
                        widget.post.postBidDetails.minimumBid) {
                      Fluttertoast.showToast(
                          msg:
                              'Amount should be greater than the minimum bid amount');
                      return;
                    }

                    if (widget.post.postBidDetails.currentBid != null &&
                        int.parse(amountController.text) <
                            widget.post.postBidDetails.currentBid) {
                      Fluttertoast.showToast(
                          msg:
                              'Amount should be greater than the current bid amount');
                      return;
                    }

                    setState(() {
                      isBidding = true;
                    });
                    placeBid();
                    // show progress indicator while placing bid
                    // isBidding ? CircularProgressIndicator() : placeBid();
                    // if(amountController.text)
                  },
                  child: 
                
                  
                  Container(
                    height: 60,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                        child: 
                          isBidding
                      ? CircularProgressIndicator(color: Colors.white,)
                      :
                        Text(
                      'Place Bid',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          fontFamily: 'Lexend',
                          color: Colors.white),
                    )),
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
