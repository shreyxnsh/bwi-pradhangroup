import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pradhangroup/functions/firebase_functions.dart';
import 'package:pradhangroup/main.dart';
import 'package:pradhangroup/widgets/post_card_vertical.dart';

import '../FuncScreen/postDetails.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool all = true;
  bool top = false;
  bool manesar = false;
  bool price = false;
  List<Post> _posts = [];

  refresh() {
    all = false;
    top = false;
    manesar = false;
    price = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 60.0, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Search',
                      style: TextStyle(
                          fontFamily: 'Lexend',
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: 55),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 56,
                child: TextField(
                  onChanged: (value) async {
                    final searchParameters = {
                      'q': value,
                      'query_by': 'name',
                    };

                    var snapshot = await client
                        .collection('bwi-pradhan-group-posts')
                        .documents
                        .search(searchParameters);

                    log('Snapshot: $snapshot');

                    // Extract posts from snapshot and map to a list of Post objects
                    _posts = snapshot['hits'].map<Post>((doc) {
                      Map<String, dynamic> data = doc['document'] as Map<String, dynamic>;

                      return Post(
                        id: data['id'] ?? 'Unknown ID',
                        name: data['name'] ?? 'Unknown Name',
                        postType: data['postType'] ?? 'Unknown Type',
                        price: data['price'] ?? 0,
                        propertyId: data['propertyId'] ?? 'Unknown Property ID',
                        shortDescription: data['shortDescription'] ?? 'No Description',
                        description: data['description'] ?? 'No Description',
                        status: data['status'] ?? 'Unknown Status',
                        approvalStatus: data['approvalStatus'] ?? 'Unknown Approval Status',
                        email: data['contactDetails']?['email'] ?? 'No Email',
                        phone: data['contactDetails']?['phoneNo'] ?? 'No Phone Number',
                        coverPic: data['coverPic']?['url'] ?? 'No Cover Pic URL',
                        latitute: data['location']?['lat'].toString() ?? 'No Latitude',
                        longitude: data['location']?['long'].toString() ?? 'No Longitude',
                        area: data['otherDetails']?['area'] ?? 'No Area',
                        city: data['address']?['city'] ?? '',
              address: data['address']?['completeAddress'] ?? '',
              pinCode: data['address']?['pincode'] ?? '',
              state: data['address']?['state'] ?? '',
                        propertyOwnership: data['otherDetails']?['propertyOwnership'] ?? 'No Ownership Info',
                        transactionType: data['otherDetails']?['transactionType'] ?? 'No Transaction Type',
                        avgRating: data['ratings']?['average'].toString() ?? 'No Rating',
                        totalRating: data['ratings']?['total'].toString() ?? 'No Total Rating',
                        tags: data['tags'] != null ? List<String>.from(data['tags']) : [],
                        keywords: data['keywords'] != null ? List<String>.from(data['keywords']) : [],
                        postBidDetails: PostBidDetails(
                          totalBidCount: data['bidDetails']?['totalBidCount'] ?? 0,
                          minimumBid: data['bidDetails']?['minimumBid'] ?? 0,
                          currentBid: data['bidDetails']?['currentBid'] ?? 0,
                          lastBidId: data['bidDetails']?['lastBidId'] ?? 'No Last Bid ID',
                          startTime: data['bidDetails']?['startTime']?.toString() ?? '',
                          endTime: data['bidDetails']?['endTime']?.toString() ?? '',
                          status: data['bidDetails']?['status'] ?? 'No Status',
                          wonUserId: data['bidDetails']?['bidWonBy']?['userId'] ?? 'No Winner User ID',
                          wonBidAmount: data['bidDetails']?['bidWonBy']?['bidAmount'] ?? 0,
                          wonBidId: data['bidDetails']?['bidWonBy']?['bidId'] ?? 'No Winner Bid ID',
                        ),
                        categoryId: data['categories'] != null ? List<dynamic>.from(data['categories']) : [],
                        categoryName: data['categoryName'] != null ? List<dynamic>.from(data['categoryName']) : [],
                      );
                    }).toList();

                    log('Posts: ${_posts.toString()}');

                    setState(() {
                      // Update the UI with the new posts
                    });
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: 'Search',
                    hintStyle: TextStyle(
                        color: '737373'.toColor(),
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w300),
                    filled: true,
                    prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.search,
                          size: 24,
                        )),
                    fillColor: 'F4F5FA'.toColor(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: 'F4F5FA'.toColor()), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              // SizedBox(height: 30),
              // Align(
              //     alignment: Alignment.topLeft,
              //     child: Text(
              //       'Explore Listings',
              //       style: TextStyle(
              //           fontWeight: FontWeight.w500,
              //           fontSize: 18,
              //           fontFamily: 'Lexend'),
              //     )),
              // SizedBox(height: 22),
              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: Row(
              //     children: [
              //       GestureDetector(
              //         onTap: () {
              //           setState(() {
              //             refresh();
              //             all = true;
              //           });
              //         },
              //         child: Container(
              //           height: 50,
              //           width: 102,
              //           decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(20),
              //               color: (all == true)
              //                   ? '262425'.toColor()
              //                   : 'F4F5FA'.toColor()),
              //           child: Center(
              //               child: Text(
              //             'All',
              //             style: TextStyle(
              //                 fontSize: 12,
              //                 fontWeight: (all == true)
              //                     ? FontWeight.w700
              //                     : FontWeight.w300,
              //                 color: (all == true) ? Colors.white : Colors.black),
              //           )),
              //         ),
              //       ),
              //       SizedBox(width: 14),
              //       GestureDetector(
              //         onTap: () {
              //           setState(() {
              //             refresh();
              //             top = true;
              //           });
              //         },
              //         child: Container(
              //           height: 50,
              //           width: 102,
              //           decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(20),
              //               color: (top == true)
              //                   ? '262425'.toColor()
              //                   : 'F4F5FA'.toColor()),
              //           child: Center(
              //               child: Text(
              //             'Top Rated',
              //             style: TextStyle(
              //                 fontSize: 12,
              //                 fontWeight: (top == true)
              //                     ? FontWeight.w700
              //                     : FontWeight.w300,
              //                 color: (top == true) ? Colors.white : Colors.black),
              //           )),
              //         ),
              //       ),
              //       SizedBox(width: 14),
              //       GestureDetector(
              //         onTap: () {
              //           setState(() {
              //             refresh();
              //             manesar = true;
              //           });
              //         },
              //         child: Container(
              //           height: 50,
              //           width: 102,
              //           decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(20),
              //               color: (manesar == true)
              //                   ? '262425'.toColor()
              //                   : 'F4F5FA'.toColor()),
              //           child: Center(
              //               child: Text(
              //             'Manesar',
              //             style: TextStyle(
              //                 fontSize: 12,
              //                 fontWeight: (manesar == true)
              //                     ? FontWeight.w700
              //                     : FontWeight.w300,
              //                 color: (manesar == true)
              //                     ? Colors.white
              //                     : Colors.black),
              //           )),
              //         ),
              //       ),
              //       SizedBox(width: 14),
              //     ],
              //   ),
              // ),
              // SizedBox(height: 22),
              // GridView builder to display the posts
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.62,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: _posts.length,
                itemBuilder: (context, index) {
                  return PostCardVertical(post: _posts[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
