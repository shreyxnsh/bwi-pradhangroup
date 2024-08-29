import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pradhangroup/functions/firebase_functions.dart';
import 'package:pradhangroup/main.dart';
import 'package:pradhangroup/widgets/post_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BidScreen extends StatefulWidget {
  const BidScreen({super.key});

  @override
  State<BidScreen> createState() => _BidScreenState();
}

class _BidScreenState extends State<BidScreen> {
  bool all = true;
  bool ongoing = false;
  bool upcoming = false;

  FirebaseFunctions firebaseFunctions = FirebaseFunctions();

  @override
  void initState() {
    super.initState();
    firebaseFunctions.fetchPostsFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20, top: 76),
          child: Column(
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
                    "Bid Property",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Lexend',
                        fontSize: 18),
                  ),
                  Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(27.5),
                      color: 'F4F5FA'.toColor(),
                    ),
                    child: Icon(
                      Icons.search_outlined,
                      size: 18,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            all = true;
                            ongoing = false;
                            upcoming = false;
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 65,
                          decoration: BoxDecoration(
                            color: (all == true)
                                ? '262425'.toColor()
                                : 'F4F5FA'.toColor(),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text('All',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: (all == true)
                                        ? FontWeight.w700
                                        : FontWeight.w300,
                                    color: (all == true)
                                        ? Colors.white
                                        : Colors.black)),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            all = false;
                            ongoing = true;
                            upcoming = false;
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 65,
                          decoration: BoxDecoration(
                            color: (ongoing == true)
                                ? '262425'.toColor()
                                : 'F4F5FA'.toColor(),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text('Ongoing',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: (ongoing == true)
                                        ? FontWeight.w700
                                        : FontWeight.w300,
                                    color: (ongoing == true)
                                        ? Colors.white
                                        : Colors.black)),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            all = false;
                            ongoing = false;
                            upcoming = true;
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 75,
                          decoration: BoxDecoration(
                            color: (upcoming == true)
                                ? '262425'.toColor()
                                : 'F4F5FA'.toColor(),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text('Upcoming',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: (upcoming == true)
                                        ? FontWeight.w700
                                        : FontWeight.w300,
                                    color: (upcoming == true)
                                        ? Colors.white
                                        : Colors.black)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              ValueListenableBuilder<List<Post>>(
                valueListenable: firebaseFunctions.postsNotifier,
                builder: (context, posts, _) {
                  // Filter posts based on the selected tab
                  final filteredPosts = _filterPosts(posts.where((post) => post.postType == 'bid').toList());

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredPosts.length,
                    itemBuilder: (context, index) {
                      return PostCard(post: filteredPosts[index]);
                    },
                  );
                },
              ),
              SizedBox(
                height: 60,
              ),
            ],
          ),
        ),
      ),
    );
  }

    int extractSeconds(String timestamp) {
    RegExp regex = RegExp(r"seconds=(\d+),");
    Match? match = regex.firstMatch(timestamp);
    if (match != null) {
      return int.parse(match.group(1)!);
    }
    throw Exception("Invalid Timestamp format");
  }

  List<Post> _filterPosts(List<Post> posts) {
     final DateTime currentTime = DateTime.now();
     log("Posts : ${posts.toString()}" , name: "TABS");

    if (all) {
      return posts.where((post) => post.postType == 'bid').toList();
    } else if (ongoing) {
      return posts.where((post) {
        log("Start Time : ${post.postBidDetails.startTime}" , name: "TABS");
        log("End Time : ${post.postBidDetails.endTime}" , name: "TABS");
        log("End Time : ${post.postBidDetails.toString()}" , name: "TABS");

        
        final DateTime startTime =  DateTime.fromMillisecondsSinceEpoch(
                          extractSeconds(post.postBidDetails.startTime) *
                              1000);
        final DateTime endTime = DateTime.fromMillisecondsSinceEpoch(
                          extractSeconds(post.postBidDetails.endTime) *
                              1000);

                              log("Start Time after conversion : ${startTime.toString()}" , name: "TABS");
                              log("End Time after conversion : ${endTime.toString()}" , name: "TABS");
        return post.postType == 'bid' &&
            currentTime.isAfter(startTime) &&
                      currentTime.isBefore(endTime);

            // currentTime.isAfter(startTime)
      }).toList();
    } else if (upcoming) {
      return posts.where((post) {
        final DateTime startTime =  DateTime.fromMillisecondsSinceEpoch(
                          extractSeconds(post.postBidDetails.startTime) *
                              1000);
        return post.postType == 'bid' && currentTime.isBefore(startTime);
      }).toList();
    }
    return [];
  }
}

