import 'dart:developer';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class FirebaseFunctions {
  Future<User?> fetchUserbyID(String authId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> startupSnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(authId)
              .get();

      if (startupSnapshot.exists) {
        Map<String, dynamic> data = startupSnapshot.data()!;

        print('Our Data: $data');
        log("User name is ${data['name']}");
        log("User phone is ${data['phone']}");
        log("User createdAt is ${data['createdAt']}");
        log("User isVerified is ${data['isVerified']}");

        // Map<String, dynamic>? detailsData = data['details'];
        // print('Details data: $detailsData');

        // Map<String, dynamic>? advanceData = detailsData?['advance'];

        // Map<String, dynamic>? detailsData = data['details'];
        // print('Details data: $detailsData');

        // Map<String, dynamic>? advanceData = detailsData?['advance'];

        return User(
          uid: authId,
          name: data['name'] ?? '',
          phoneNo: data['phone'] ?? '',
          createdAt: data['createdAt']?.toDate() ?? "",
          isVerified: data['isVerified'] ?? false,
        );
      }

      print('done fetch');
    } catch (e) {
      print('Error fetching startup by ID: $e');
    }
  }

  // List<Post> _posts = [];

  // List<Post> get posts => _posts;
  ValueNotifier<List<Post>> postsNotifier = ValueNotifier<List<Post>>([]);

  Future<void> fetchPostsFromFirestore() async {
    try {
      log("Started fetching posts");
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('posts').get();

      List<Post> posts = [];
      for (QueryDocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data();

        log("Posts Data : $data");

        posts.add(Post(
          id: doc.id,
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
          propertyOwnership:
              data['otherDetails']?['propertyOwnership'] ?? 'No Ownership Info',
          transactionType:
              data['otherDetails']?['transactionType'] ?? 'No Transaction Type',
          avgRating: data['ratings']?['average'].toString() ?? 'No Rating',
          totalRating:
              data['ratings']?['total'].toString() ?? 'No Total Rating',
          tags: data['tags'] != null ? List<String>.from(data['tags']) : [],
          keywords: data['keywords'] != null
              ? List<String>.from(data['keywords'])
              : [],
          createdAt:
              data['createdAt']?.toDate().toString() ?? 'No Creation Date',
          updatedAt: data['updatedAt'] ?? 'No Update Date',
          postBidDetails: PostBidDetails(
            totalBidCount: data['bidDetails']?['totalBidCount'] ?? 0,
            minimumBid: data['bidDetails']?['minimumBid'] ?? 0,
            currentBid: data['bidDetails']?['currentBid'] ?? 0,
            lastBidId: data['bidDetails']?['lastBidId'] ?? 'No Last Bid ID',
            lastBidAt: data['bidDetails']?['lastBidAt'] ?? 'No Last Bid At',
            startTime: data['bidDetails']?['startTime'] ?? 'No Start Time',
            endTime: data['bidDetails']?['endTime'] ?? 'No End Time',
            status: data['bidDetails']?['status'] ?? 'No Status',
            wonUserId: data['bidDetails']?['bidWonBy']?['userId'] ??
                'No Winner User ID',
            wonBidAmount: data['bidDetails']?['bidWonBy']?['bidAmount'] ?? 0,
            wonBidId:
                data['bidDetails']?['bidWonBy']?['bidId'] ?? 'No Winner Bid ID',
            wonAt:
                data['bidDetails']?['bidWonBy']?['wonAt'] ?? 'No Winner Bid At',
          ),
          categoryId: data['categoryId'] != null
              ? List<String>.from(data['categoryId'])
              : [],
          categoryName: data['categoryName'] != null
              ? List<String>.from(data['categoryName'])
              : [],
        ));
      }

      postsNotifier.value = posts;
      log('done fetch');
    } catch (e) {
      log('Error fetching posts: $e');
    }
  }

  Future<void> fetchPostsById (String docId){
    return FirebaseFirestore.instance.collection('posts').doc(docId).get();
  }

  Future<bool> checkUserExists(String phoneWithCountryCode) async {
    try {
      log("Phone number : " + phoneWithCountryCode);
      final userQuery = await FirebaseFirestore.instance
          .collection('users')
          .where('phone', isEqualTo: phoneWithCountryCode)
          .get();

      return userQuery.docs.isNotEmpty;
    } catch (e) {
      print("Error checking user existence: $e");
      return false;
    }
  }

  Future<void> logOutUser() async {
    // final prefs = await SharedPreferences.getInstance();
    final box = GetStorage();
    box.remove('name');
    box.remove('phoneNo');
    box.remove('createdAt');
    box.remove('isVerified');
    box.remove('uid');
    await FirebaseAuth.instance.signOut();

    // clear the user details in the get storage
  }

  // Future<void> googleSignOut() async {
  //   GoogleSignIn().signOut();
  // }

  // Future<bool> checkLogin() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String? uid;
  //   try {
  //     uid = FirebaseAuth.instance.currentUser!.uid;
  //     debugPrint("isAuthenticated : true");
  //   } catch (e) {
  //     debugPrint("isAuthenticated : false");
  //   }
  //   if (uid == null) {
  //     prefs.setBool('islogin', false);
  //     isLogin = false;
  //   } else {
  //     prefs.setBool('islogin', true);
  //     isLogin = true;
  //   }
  //   notifyListeners();

  //   return isLogin;
  // }
}

class Post {
  final String id;
  final String name;
  final String postType;
  final int price;
  final String propertyId;
  final String shortDescription;
  final String description;
  final String status;
  final String approvalStatus;
  final String email;
  final String phone;
  final String coverPic;
  final String latitute;
  final String longitude;
  final String area;
  final String propertyOwnership;
  final String transactionType;
  final String avgRating;
  final String totalRating;
  final List<String> tags;
  final List<String> keywords;
  final String createdAt;
  final String updatedAt;
  final PostBidDetails postBidDetails;
  final List<String> categoryId;
  final List<String> categoryName;

  Post({
    required this.id,
    required this.name,
    required this.postType,
    required this.price,
    required this.propertyId,
    required this.shortDescription,
    required this.description,
    required this.status,
    required this.approvalStatus,
    required this.email,
    required this.phone,
    required this.coverPic,
    required this.latitute,
    required this.longitude,
    required this.area,
    required this.propertyOwnership,
    required this.transactionType,
    required this.avgRating,
    required this.totalRating,
    required this.tags,
    required this.keywords,
    required this.createdAt,
    required this.updatedAt,
    required this.postBidDetails,
    required this.categoryId,
    required this.categoryName,
  });
}

class PostBidDetails {
  final int totalBidCount;
  final int minimumBid;
  final int currentBid;
  final String lastBidId;
  final String lastBidAt;
  final String startTime;
  final String endTime;
  final String status;
  final String wonUserId;
  final int wonBidAmount;
  final String wonBidId;
  final String wonAt;

  PostBidDetails({
    required this.totalBidCount,
    required this.minimumBid,
    required this.currentBid,
    required this.lastBidId,
    required this.lastBidAt,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.wonUserId,
    required this.wonBidAmount,
    required this.wonBidId,
    required this.wonAt,
  });
}

class User {
  final String uid;
  final String name;
  final String phoneNo;
  final DateTime createdAt;
  final bool isVerified;

  User({
    required this.uid,
    required this.name,
    required this.phoneNo,
    required this.createdAt,
    this.isVerified = false,
  });
}