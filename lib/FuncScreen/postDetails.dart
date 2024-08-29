import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_api/flutter_native_api.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pradhangroup/FuncScreen/query.dart';
import 'package:pradhangroup/FuncScreen/widgets/countdownTimer.dart';
import 'package:pradhangroup/Screens/ViewAllScreen.dart';
import 'package:pradhangroup/Screens/map.dart';
import 'package:pradhangroup/functions/firebase_functions.dart';
import 'package:pradhangroup/functions/localStorage.dart';
import 'package:pradhangroup/main.dart';
import 'package:pradhangroup/widgets/post_card_vertical.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:url_launcher/url_launcher.dart';

import '../bid/bid.dart';

class PostDetailScreen extends StatefulWidget {
  final Post post;
  PostDetailScreen({Key? key, required this.post}) : super(key: key);

  @override
  State<PostDetailScreen> createState() => _detailsState();
}

class _detailsState extends State<PostDetailScreen> {
  bool rent = true;
  bool buy = true;
  bool like = false;

  FirebaseFunctions firebaseFunctions = FirebaseFunctions();

  @override
  void initState() {
    super.initState();
    log("TYPE : ${widget.post.postType}");
    _checkIfLiked();
    firebaseFunctions.fetchPostsFromFirestore();
    log("Latitude : ${widget.post.latitute}", name: "ISSUES");
    log("Longitude : ${widget.post.longitude}", name: "ISSUES");
  }

  int extractSeconds(String timestamp) {
    RegExp regex = RegExp(r"seconds=(\d+),");
    Match? match = regex.firstMatch(timestamp);
    if (match != null) {
      return int.parse(match.group(1)!);
    }
    throw Exception("Invalid Timestamp format");
  }

  Future<void> _checkIfLiked() async {
    bool isLiked = await LocalStorage.isPostLiked(widget.post.id);
    setState(() {
      like = isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    double latitude =
        widget.post.latitute.isEmpty ? 0.0 : double.parse(widget.post.latitute);
    double longitude = widget.post.latitute.isEmpty
        ? 0.0
        : double.parse(widget.post.longitude);
    log("Latitude : ${widget.post.latitute}", name: "ISSUES 2");
    log("Longitude : ${widget.post.longitude}", name: "ISSUES 2");

    log("Start time : ${widget.post.postBidDetails.startTime}");
    log("End time : ${widget.post.postBidDetails.endTime}");
    return Scaffold(
      bottomNavigationBar: (buy == true)
          ? Padding(
              padding: const EdgeInsets.all(15),
              child: GestureDetector(
                onTap: () {
                  final DateTime currentTime = DateTime.now();
                  final DateTime startTime = widget
                          .post.postBidDetails.startTime.isNotEmpty
                      ? DateTime.fromMillisecondsSinceEpoch(
                          extractSeconds(widget.post.postBidDetails.startTime) *
                              1000)
                      : DateTime.now();
                  final DateTime endTime = widget
                          .post.postBidDetails.endTime.isNotEmpty
                      ? DateTime.fromMillisecondsSinceEpoch(
                          extractSeconds(widget.post.postBidDetails.endTime) *
                              1000)
                      : DateTime.now();

                  log("Start Time  ${startTime}");
                  log("End Time  ${endTime}");

                  if (currentTime.isAfter(startTime) &&
                      currentTime.isBefore(endTime)) {
                    Get.to(
                      () => bid(post: widget.post),
                      transition: Transition.rightToLeftWithFade,
                    );
                  } else if (
                      widget.post.postType == "rent") {
                    Get.to(
                      () =>
                          QueryScreen(post: widget.post), // Replace with your actual query screen widget
                      transition: Transition.rightToLeftWithFade,
                    );
                    log("Query");
                  } else if (currentTime.isAfter(endTime) || currentTime.isBefore(startTime)) {
                    Fluttertoast.showToast(
                      msg: "Bidding is not live right now!",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                    );
                  }
                },
                child: Container(
                  height: 60,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      widget.post.postType == "buy" || widget.post.postType == "bid" ? 'Place Bid' : "Submit Query",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        fontFamily: 'Lexend',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : SizedBox(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 37.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Stack(
                  children: [
                    // Image.asset(widget.post.coverPic , width: MediaQuery.of(context).size.width),
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: CachedNetworkImage(
                          imageUrl: widget.post.coverPic,
                          height: 400,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      color: Colors.white),
                                  child: Icon(
                                    Icons.arrow_back_ios_new,
                                    size: 17,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      FlutterNativeApi.shareText(
                                          "Install Pradhan Group");
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 55,
                                      width: 55,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(27.5),
                                          color: Colors.white),
                                      child: Image.asset(
                                        'assets/Upload.png',
                                        height: 27,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        like = !like;
                                      });

                                      if (like) {
                                        await FirebaseFunctions()
                                            .addPostToFavorites(widget.post.id);
                                        await LocalStorage.saveLikedPost(
                                            widget.post.id);
                                      } else {
                                        await FirebaseFunctions()
                                            .removePostFromFavorites(
                                                widget.post.id);
                                        await LocalStorage.removeLikedPost(
                                            widget.post.id);
                                      }
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 55,
                                      width: 55,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(27.5),
                                        color: (like == true)
                                            ? '0095D9'.toColor()
                                            : Colors.white,
                                      ),
                                      child: (like == true)
                                          ? Image.asset(
                                              'assets/whiteheart.png',
                                              height: 27,
                                            )
                                          : Image.asset(
                                              'assets/bheart.png',
                                              height: 27,
                                            ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              (widget.post.postType == "buy" || widget.post.postType == "bid")
                  ? Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20, top: 35, bottom: 15),
                      child: Container(
                          height: 70,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              color: 'EEEEEE'.toColor(),
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 13.0, left: 15, right: 15),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        'assets/clock.png',
                                        height: 20,
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text('Auction ends in',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w300,
                                              fontFamily: 'Lexend')),
                                    ],
                                  ),
                                  // if starttime and end time is not null or empty
                                  widget.post.postBidDetails.startTime
                                              .isNotEmpty &&
                                          widget.post.postBidDetails.endTime
                                              .isNotEmpty
                                      ? CountdownTimerWidget(
                                          startTime: DateTime
                                              .fromMillisecondsSinceEpoch(
                                                  extractSeconds(widget
                                                          .post
                                                          .postBidDetails
                                                          .startTime) *
                                                      1000),
                                          endTime: DateTime
                                              .fromMillisecondsSinceEpoch(
                                                  extractSeconds(widget
                                                          .post
                                                          .postBidDetails
                                                          .endTime) *
                                                      1000),
                                        )
                                      : Center(
                                          child: Text('Bidding not yet started',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w300,
                                                  fontFamily: 'Lexend',
                                                  color: Colors.red)),
                                        ),
                                ],
                              ),
                            ),
                          )),
                    )
                  :  Padding(
                      padding:
                          const EdgeInsets.only(left: 20.0, right: 20, top: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 12.3,
                                width: 12.3,
                                decoration: BoxDecoration(
                                    color: '78EB8F'.toColor(),
                                    borderRadius: BorderRadius.circular(6.15)),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                widget.post.status,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'Lexend'),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Rs. ${widget.post.price.toString()}",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Lexend',
                                    fontWeight: FontWeight.w500),
                              ),
                              // Align(
                              //     alignment: Alignment.topRight,
                              //     child: Text(
                              //       'per month',
                              //       style: TextStyle(
                              //           fontSize: 12,
                              //           fontFamily: 'Lexend',
                              //           fontWeight: FontWeight.w300),
                              //     )),
                            ],
                          )
                        ],
                      ),
                    ),
              
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20, top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.post.name,
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Lexend',
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/bloc.png',
                      height: 18,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      widget.post.city + ", " + widget.post.state,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Lexend'),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                child: Row(
                  children: [
                    widget.post.postType == "rent"
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                rent = true;
                                buy = false;
                              });
                            },
                            child: Container(
                              height: 50,
                              width: 76,
                              decoration: BoxDecoration(
                                  color: (rent == true)
                                      ? '0095D9'.toColor()
                                      : 'F4F5FA'.toColor(),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                  child: Text(
                                'Rent',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: (rent == true)
                                        ? FontWeight.w700
                                        : FontWeight.w300,
                                    fontFamily: 'Lexend',
                                    color: (rent == true)
                                        ? Colors.white
                                        : Colors.black),
                              )),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              setState(() {
                                buy = true;
                                rent = false;
                              });
                            },
                            child: Container(
                              height: 50,
                              width: 76,
                              decoration: BoxDecoration(
                                  color: (buy == true)
                                      ? '0095D9'.toColor()
                                      : 'F4F5FA'.toColor(),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                  child: Text(
                                'Buy',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: (buy == true)
                                        ? FontWeight.w700
                                        : FontWeight.w300,
                                    fontFamily: 'Lexend',
                                    color: (buy == true)
                                        ? Colors.white
                                        : Colors.black),
                              )),
                            ),
                          ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                child: Text(
                  widget.post.description,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'Lexend'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 28.0, right: 20, left: 20),
                child: Row(
                  children: [
                    Text(
                      'Transaction Type: ',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Lexend'),
                    ),
                    Text(
                      widget.post.transactionType,
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Lexend'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, right: 20, left: 20),
                child: Row(
                  children: [
                    Text(
                      'Property Ownership: ',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Lexend'),
                    ),
                    Text(
                      widget.post.propertyOwnership,
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Lexend'),
                    ),
                  ],
                ),
              ),
              (widget.post.postType == "buy")
                  ? Padding(
                      padding:
                          const EdgeInsets.only(top: 12.0, right: 20, left: 20),
                      child: Row(
                        children: [
                          Text(
                            'Current Bid: ',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w300,
                                fontFamily: 'Lexend'),
                          ),
                          Text(
                            widget.post.postBidDetails.currentBid.toString(),
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Lexend'),
                          ),
                        ],
                      ),
                    )
                  : SizedBox(),
              (widget.post.postType == "buy")
                  ? Padding(
                      padding:
                          const EdgeInsets.only(top: 12.0, right: 20, left: 20),
                      child: Row(
                        children: [
                          Text(
                            'Minimum Bid: ',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w300,
                                fontFamily: 'Lexend'),
                          ),
                          Text(
                            widget.post.postBidDetails.minimumBid.toString(),
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Lexend'),
                          ),
                        ],
                      ),
                    )
                  : SizedBox(),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20, top: 30),
                  child: Row(
                    children: [
                      Container(
                        height: 47,
                        width: 132,
                        decoration: BoxDecoration(
                            color: 'F4F5FA'.toColor(),
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              'assets/sqft.png',
                              height: 22,
                            ),
                            Text(
                              widget.post.area,
                              style: TextStyle(
                                  fontFamily: 'Lexend',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 47,
                        width: 132,
                        decoration: BoxDecoration(
                            color: 'F4F5FA'.toColor(),
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              'assets/government.png',
                              height: 22,
                            ),
                            Text(
                              widget.post.propertyOwnership,
                              style: TextStyle(
                                  fontFamily: 'Lexend',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 47,
                        width: 132,
                        decoration: BoxDecoration(
                            color: 'F4F5FA'.toColor(),
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              'assets/birthday.png',
                              height: 22,
                            ),
                            Text(
                              '1 year old',
                              style: TextStyle(
                                  fontFamily: 'Lexend',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Divider(
                  thickness: 2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Text(
                  'Location',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Lexend'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20, top: 25),
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: 'F4F5FA'.toColor(),
                          borderRadius: BorderRadius.circular(25)),
                      child: Image.asset(
                        'assets/blocb.png',
                        height: 24,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text(
                        widget.post.address,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Lexend'),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20, top: 30),
                child: MapScreen(
                  latitude: latitude,
                  longitude: longitude,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  final String googleMapsUrl =
                      "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";

                  log("URL : $googleMapsUrl");

                  launchUrl(Uri.parse(googleMapsUrl)).onError(
                    (error, stackTrace) {
                      print("Url is not valid! ${error.toString()}");
                      return false;
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Container(
                    width: double.maxFinite,
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25)),
                        color: 'F4F5FA'.toColor()),
                    child: Center(
                        child: Text(
                      'View on Maps',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Lexend'),
                    )),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20, top: 25),
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: 'F4F5FA'.toColor(),
                          borderRadius: BorderRadius.circular(25)),
                      child: Image.asset(
                        'assets/build.png',
                        height: 24,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.post.keywords.join(', '),
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Lexend'),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              // (buy == true)
              //     ? Padding(
              //         padding: const EdgeInsets.all(20.0),
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Divider(
              //               thickness: 2,
              //             ),
              //             SizedBox(
              //               height: 20,
              //             ),
              //             Text(
              //               'Top Bidders',
              //               style: TextStyle(
              //                   fontSize: 18,
              //                   fontWeight: FontWeight.w500,
              //                   fontFamily: 'Lexend'),
              //             ),
              //             SizedBox(
              //               height: 35,
              //             ),
              //             Container(
              //               height: 70,
              //               width: double.maxFinite,
              //               decoration: BoxDecoration(
              //                   color: Color.fromRGBO(239, 99, 86, 0.05),
              //                   borderRadius: BorderRadius.circular(12)),
              //               child: Row(
              //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                 children: [
              //                   Row(
              //                     children: [
              //                       Stack(
              //                         children: [
              //                           Padding(
              //                             padding: const EdgeInsets.all(12.0),
              //                             child: Image.asset('assets/bid1.png'),
              //                           ),
              //                           Padding(
              //                             padding: const EdgeInsets.all(8.0),
              //                             child: Container(
              //                               height: 18,
              //                               width: 18,
              //                               decoration: BoxDecoration(
              //                                   color: Colors.black,
              //                                   borderRadius:
              //                                       BorderRadius.circular(9)),
              //                               child: Center(
              //                                   child: Text(
              //                                 '1',
              //                                 style: TextStyle(
              //                                     fontSize: 10,
              //                                     color: Colors.white),
              //                               )),
              //                             ),
              //                           )
              //                         ],
              //                       ),
              //                       SizedBox(
              //                         width: 12,
              //                       ),
              //                       Text(
              //                         'Theresa Webb',
              //                         style: TextStyle(
              //                             fontSize: 15,
              //                             fontWeight: FontWeight.w500,
              //                             fontFamily: 'Lexend'),
              //                       )
              //                     ],
              //                   ),
              //                   Padding(
              //                     padding: const EdgeInsets.only(right: 17.0),
              //                     child: Row(
              //                       children: [
              //                         Image.asset(
              //                           'assets/fire.png',
              //                           height: 16,
              //                         ),
              //                         Text(
              //                           ' 42,00,000',
              //                           style: TextStyle(
              //                               fontSize: 15,
              //                               fontWeight: FontWeight.w500,
              //                               fontFamily: 'Lexend'),
              //                         )
              //                       ],
              //                     ),
              //                   )
              //                 ],
              //               ),
              //             ),
              //             SizedBox(
              //               height: 15,
              //             ),
              //             Container(
              //               height: 70,
              //               width: double.maxFinite,
              //               decoration: BoxDecoration(
              //                   color: Color.fromRGBO(0, 149, 217, 0.05),
              //                   borderRadius: BorderRadius.circular(12)),
              //               child: Row(
              //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                 children: [
              //                   Row(
              //                     children: [
              //                       Stack(
              //                         children: [
              //                           Padding(
              //                             padding: const EdgeInsets.all(12.0),
              //                             child: Image.asset('assets/bid2.png'),
              //                           ),
              //                           Padding(
              //                             padding: const EdgeInsets.all(8.0),
              //                             child: Container(
              //                               height: 18,
              //                               width: 18,
              //                               decoration: BoxDecoration(
              //                                   color: Colors.black,
              //                                   borderRadius:
              //                                       BorderRadius.circular(9)),
              //                               child: Center(
              //                                   child: Text(
              //                                 '2',
              //                                 style: TextStyle(
              //                                     fontSize: 10,
              //                                     color: Colors.white),
              //                               )),
              //                             ),
              //                           )
              //                         ],
              //                       ),
              //                       SizedBox(
              //                         width: 12,
              //                       ),
              //                       Text(
              //                         'Darell Steward',
              //                         style: TextStyle(
              //                             fontSize: 15,
              //                             fontWeight: FontWeight.w500,
              //                             fontFamily: 'Lexend'),
              //                       )
              //                     ],
              //                   ),
              //                   Padding(
              //                     padding: const EdgeInsets.only(right: 17.0),
              //                     child: Row(
              //                       children: [
              //                         Image.asset(
              //                           'assets/fire.png',
              //                           height: 16,
              //                         ),
              //                         Text(
              //                           ' 40,00,000',
              //                           style: TextStyle(
              //                               fontSize: 15,
              //                               fontWeight: FontWeight.w500,
              //                               fontFamily: 'Lexend'),
              //                         )
              //                       ],
              //                     ),
              //                   )
              //                 ],
              //               ),
              //             ),
              //             SizedBox(
              //               height: 15,
              //             ),
              //             Container(
              //               height: 70,
              //               width: double.maxFinite,
              //               decoration: BoxDecoration(
              //                   color: Color.fromRGBO(157, 188, 41, 0.05),
              //                   borderRadius: BorderRadius.circular(12)),
              //               child: Row(
              //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                 children: [
              //                   Row(
              //                     children: [
              //                       Stack(
              //                         children: [
              //                           Padding(
              //                             padding: const EdgeInsets.all(12.0),
              //                             child: Image.asset('assets/bid3.png'),
              //                           ),
              //                           Padding(
              //                             padding: const EdgeInsets.all(8.0),
              //                             child: Container(
              //                               height: 18,
              //                               width: 18,
              //                               decoration: BoxDecoration(
              //                                   color: Colors.black,
              //                                   borderRadius:
              //                                       BorderRadius.circular(9)),
              //                               child: Center(
              //                                   child: Text(
              //                                 '3',
              //                                 style: TextStyle(
              //                                     fontSize: 10,
              //                                     color: Colors.white),
              //                               )),
              //                             ),
              //                           )
              //                         ],
              //                       ),
              //                       SizedBox(
              //                         width: 12,
              //                       ),
              //                       Text(
              //                         'Mark Jack',
              //                         style: TextStyle(
              //                             fontSize: 15,
              //                             fontWeight: FontWeight.w500,
              //                             fontFamily: 'Lexend'),
              //                       )
              //                     ],
              //                   ),
              //                   Padding(
              //                     padding: const EdgeInsets.only(right: 17.0),
              //                     child: Row(
              //                       children: [
              //                         Image.asset(
              //                           'assets/fire.png',
              //                           height: 16,
              //                         ),
              //                         Text(
              //                           ' 39,00,000',
              //                           style: TextStyle(
              //                               fontSize: 15,
              //                               fontWeight: FontWeight.w500,
              //                               fontFamily: 'Lexend'),
              //                         )
              //                       ],
              //                     ),
              //                   )
              //                 ],
              //               ),
              //             ),
              //           ],
              //         ),
              //       )
              //     : SizedBox(),
              // Padding(
              //   padding:
              //       const EdgeInsets.only(bottom: 20.0, right: 20, left: 20),
              //   child: Divider(
              //     thickness: 2,
              //   ),
              // ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
                child: Text(
                  'Reviews',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Lexend'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Container(
                  height: 80,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 211, 1, 0.1),
                      borderRadius: BorderRadius.circular(25)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 12,
                      ),
                      Image.asset(
                        'assets/bstar.png',
                        height: 50,
                        width: 50,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0, left: 26),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/star.png',
                                  height: 15,
                                ),
                                SizedBox(
                                  width: 2.5,
                                ),
                                Image.asset(
                                  'assets/star.png',
                                  height: 15,
                                ),
                                SizedBox(
                                  width: 2.5,
                                ),
                                Image.asset(
                                  'assets/star.png',
                                  height: 15,
                                ),
                                SizedBox(
                                  width: 2.5,
                                ),
                                Image.asset(
                                  'assets/star.png',
                                  height: 15,
                                ),
                                SizedBox(
                                  width: 2.5,
                                ),
                                Image.asset(
                                  'assets/star.png',
                                  height: 15,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 26.0),
                            child: Text(
                              widget.post.avgRating,
                              style: TextStyle(
                                  fontFamily: 'Lexend',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24),
                            ),
                          )
                        ],
                      ),
                      Spacer(),
                      Image.asset(
                        'assets/ratepic.png',
                        height: 32,
                      ),
                      SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
                child: Container(
                  width: double.maxFinite,
                  height: 122,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: 'F4F5FA'.toColor()),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 16),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/profile.png',
                              height: 45,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Theresa Webb'),
                                SizedBox(
                                  height: 6,
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/star.png',
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: 2.5,
                                    ),
                                    Image.asset(
                                      'assets/star.png',
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: 2.5,
                                    ),
                                    Image.asset(
                                      'assets/star.png',
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: 2.5,
                                    ),
                                    Image.asset(
                                      'assets/star.png',
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: 2.5,
                                    ),
                                    Image.asset(
                                      'assets/gstar.png',
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          'Lorem ipsum dolor sit amet, adipiscing elit, \neiusmod tempor ut labore ',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'Lexend'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Container(
                  width: double.maxFinite,
                  height: 122,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: 'F4F5FA'.toColor()),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 16),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/user2.png',
                              height: 45,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Theresa Webb'),
                                SizedBox(
                                  height: 6,
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/star.png',
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: 2.5,
                                    ),
                                    Image.asset(
                                      'assets/star.png',
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: 2.5,
                                    ),
                                    Image.asset(
                                      'assets/star.png',
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: 2.5,
                                    ),
                                    Image.asset(
                                      'assets/star.png',
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: 2.5,
                                    ),
                                    Image.asset(
                                      'assets/gstar.png',
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          'Lorem ipsum dolor sit amet, adipiscing elit, \neiusmod tempor ut labore ',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'Lexend'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
                child: Container(
                  height: 60,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: 'F4F5FA'.toColor(),
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                      child: Text(
                    'View All',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        fontFamily: 'Lexend'),
                  )),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              widget.post.postType == "rent"
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Nearby Properties',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    fontFamily: 'Lexend'),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => ViewAllScreen(),
                                      transition:
                                          Transition.rightToLeftWithFade);
                                },
                                child: Text(
                                  'View all',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14,
                                    fontFamily: 'Lexend',
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        ValueListenableBuilder<List<Post>>(
                          valueListenable: firebaseFunctions.postsNotifier,
                          builder: (context, posts, _) {
                            // Filter posts to include only those with transactionType as "sale"
                            final salePosts = posts
                                .where((post) =>
                                    post.id != widget.post.id &&
                                    post.postType == "rent")
                                .toList();

                            log("Sale Posts : ${salePosts.toString()}");
                            return Padding(
                              padding: const EdgeInsets.all(16),
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.32,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  physics: AlwaysScrollableScrollPhysics(),
                                  itemCount: salePosts.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        PostCardVertical(
                                            post: salePosts[index]),
                                        SizedBox(
                                          width: 15,
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Nearby Properties',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    fontFamily: 'Lexend'),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => ViewAllScreen(),
                                      transition:
                                          Transition.rightToLeftWithFade);
                                },
                                child: Text(
                                  'View all',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14,
                                    fontFamily: 'Lexend',
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        ValueListenableBuilder<List<Post>>(
                          valueListenable: firebaseFunctions.postsNotifier,
                          builder: (context, posts, _) {
                            // Filter posts to include only those with transactionType as "sale"
                            final salePosts = posts
                                .where((post) =>
                                    post.id != widget.post.id &&
                                    post.postType == "buy")
                                .toList();

                            log("Sale Posts : ${salePosts.toString()}");
                            return Padding(
                              padding: const EdgeInsets.all(16),
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.32,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  physics: AlwaysScrollableScrollPhysics(),
                                  itemCount: salePosts.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        PostCardVertical(
                                            post: salePosts[index]),
                                        SizedBox(
                                          width: 15,
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
              SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}
