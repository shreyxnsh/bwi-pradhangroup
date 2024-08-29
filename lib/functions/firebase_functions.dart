import 'dart:developer';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';

class FirebaseFunctions {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
          createdAt: data['createdAt'] ?? "",
          isVerified: data['isVerified'] ?? false,
          profilePic: data['profilePic']['url'] ?? '',
          email: data['email'] ?? '',
          password: data['password'] ?? '',
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

      data.forEach((key, value) {
          log("Key: $key, Value Type: ${value.runtimeType}");
      });


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
        city: data['address']?['city'] ?? '',
              address: data['address']?['completeAddress'] ?? '',
              pinCode: data['address']?['pincode'] ?? '',
              state: data['address']?['state'] ?? '',
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
        // createdAt: data['createdAt'] ,
        // updatedAt: data['updatedAt'],
        postBidDetails: PostBidDetails(
          totalBidCount: data['bidDetails']?['totalBidCount'] ?? 0,
          minimumBid: data['bidDetails']?['minimumBid'] ?? 0,
          currentBid: data['bidDetails']?['currentBid'] ?? 0,
          lastBidId: data['bidDetails']?['lastBidId'] ?? 'No Last Bid ID',
          // lastBidAt: data['bidDetails']?['lastBidAt'] ?? 'No Last Bid At',
          startTime: data['bidDetails']?['startTime'] .toString() ?? '',
          endTime: data['bidDetails']?['endTime'].toString() ?? '',
          status: data['bidDetails']?['status'] ?? 'No Status',
          wonUserId: data['bidDetails']?['bidWonBy']?['userId'] ??
              'No Winner User ID',
          wonBidAmount: data['bidDetails']?['bidWonBy']?['bidAmount'] ?? 0,
          wonBidId:
              data['bidDetails']?['bidWonBy']?['bidId'] ?? 'No Winner Bid ID',
          // wonAt:
          //     data['bidDetails']?['bidWonBy']?['wonAt'] ?? 'No Winner Bid At',
        ),
        categoryId: data['categories'] != null
            ? List<dynamic>.from(data['categories'])
            : [],
        categoryName: data['categoryName'] != null
            ? List<dynamic>.from(data['categoryName'])
            : [],
      ));
    }

    postsNotifier.value = posts;
    log('done fetch');
  } catch (e) {
    log('Error fetching posts: $e');
  }
}


  ValueNotifier<List<Post>> favoritePostsNotifier =
      ValueNotifier<List<Post>>([]);

  Future<void> getFavoritePosts() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final favoritesCollection = FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('favourites');

        final favoriteDocs = await favoritesCollection.get();

        List<String> favoritePostIds = [];
        for (var doc in favoriteDocs.docs) {
          favoritePostIds.add(doc.id);
        }

        if (favoritePostIds.isNotEmpty) {
          final postsSnapshot = await FirebaseFirestore.instance
              .collection('posts')
              .where(FieldPath.documentId, whereIn: favoritePostIds)
              .get();

          List<Post> favoritePosts = [];
          for (var doc in postsSnapshot.docs) {
            Map<String, dynamic> data = doc.data();

            log('Favourite Posts : ${data.toString()}');
            log("got data");

            favoritePosts.add(Post(
              id: doc.id,
              name: data['name'] ?? 'Unknown Name',
              postType: data['postType'] ?? 'Unknown Type',
              price: data['price'] ?? 0,
              propertyId: data['propertyId'] ?? 'Unknown Property ID',
              shortDescription: data['shortDescription'] ?? 'No Description',
              description: data['description'] ?? 'No Description',
              status: data['status'] ?? 'Unknown Status',
              approvalStatus:
                  data['approvalStatus'] ?? 'Unknown Approval Status',
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
              propertyOwnership: data['otherDetails']?['propertyOwnership'] ??
                  'No Ownership Info',
              transactionType: data['otherDetails']?['transactionType'] ??
                  'No Transaction Type',
              avgRating: data['ratings']?['average'].toString() ?? 'No Rating',
              totalRating:
                  data['ratings']?['total'].toString() ?? 'No Total Rating',
              tags: data['tags'] != null ? List<String>.from(data['tags']) : [],
              keywords: data['keywords'] != null
                  ? List<String>.from(data['keywords'])
                  : [],
              // createdAt: data['createdAt']?.toDate() ?? 'No Creation Date',
              // updatedAt: data['updatedAt'] ?? 'No Update Date',
              postBidDetails: PostBidDetails(
                totalBidCount: data['bidDetails']?['totalBidCount'] ?? 0,
                minimumBid: data['bidDetails']?['minimumBid'] ?? 0,
                currentBid: data['bidDetails']?['currentBid'] ?? 0,
                lastBidId: data['bidDetails']?['lastBidId'] ?? 'No Last Bid ID',
                // lastBidAt: data['bidDetails']?['lastBidAt'] ?? 'No Last Bid At',
                startTime: data['bidDetails']?['startTime'].toString() ?? '',
                endTime: data['bidDetails']?['endTime'].toString() ?? '',
                status: data['bidDetails']?['status'] ?? 'No Status',
                wonUserId: data['bidDetails']?['bidWonBy']?['userId'] ??
                    'No Winner User ID',
                wonBidAmount:
                    data['bidDetails']?['bidWonBy']?['bidAmount'] ?? 0,
                wonBidId: data['bidDetails']?['bidWonBy']?['bidId'] ??
                    'No Winner Bid ID',
                // wonAt: data['bidDetails']?['bidWonBy']?['wonAt'] ??
                //     'No Winner Bid At',
              ),
              categoryId: data['categories'] != null
                  ? List<dynamic>.from(data['categories'])
                  : [],
              categoryName: data['categoryName'] != null
                  ? List<dynamic>.from(data['categoryName'])
                  : [],
            ));
          }

          favoritePostsNotifier.value = favoritePosts;
          log("Fetched favorite posts");
        } else {
          favoritePostsNotifier.value = [];
          log("No favorite posts found");
        }
      } else {
        log("No user is signed in.");
      }
    } catch (e) {
      log("Error fetching favorite posts: $e");
    }
  }

  // Add a post to favorites
  Future<void> addPostToFavorites(String postId) async {
    try {
      String uid = _auth.currentUser!.uid;
      DocumentReference userRef = _firestore.collection('users').doc(uid);
      CollectionReference favoritesRef = userRef.collection('favourites');

      await favoritesRef.doc(postId).set({
        'postId': postId,
        'createdAt': DateTime.now().toString(),
      }).whenComplete(
          () => Fluttertoast.showToast(msg: "Post added to favorites"));

      print('Post added to favorites');
    } catch (e) {
      print('Error adding post to favorites: $e');
    }
  }

  // Remove a post from favorites
  Future<void> removePostFromFavorites(String postId) async {
    try {
      String uid = _auth.currentUser!.uid;
      DocumentReference userRef = _firestore.collection('users').doc(uid);
      CollectionReference favoritesRef = userRef.collection('favourites');

      await favoritesRef.doc(postId).delete().whenComplete(
          () => Fluttertoast.showToast(msg: "Post removed from favorites"));
      ;

      print('Post removed from favorites');
    } catch (e) {
      print('Error removing post from favorites: $e');
    }
  }

  Future<void> fetchPostsById(String docId) {
    return FirebaseFirestore.instance.collection('posts').doc(docId).get();
  }

    Future<void> updateProfileData(String authId, String imagePath, String name, String email, String password, String phone) async {
    try {
      // Update the profile picture URL in the database
      Map<String, dynamic> updatedData = {
     
        'profilePic': {'url': imagePath},
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
        'phoneNo': "+91$phone",
      };

      log("Updated Data : $updatedData");

      // Update the document in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(authId)
          .update(updatedData);

      // Fetch the updated startups data
      // await fetchStartupsFromFirestore();
    } catch (e) {
      print('Error updating profile picture: $e');
    }
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
    box.erase();
    await FirebaseAuth.instance.signOut();

  }
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
  final String city;
  final String address;
  final String pinCode;
  final String state;
  final String propertyOwnership;
  final String transactionType;
  final String avgRating;
  final String totalRating;
  final List<String> tags;
  final List<String> keywords;
  // final String createdAt;
  // final String updatedAt;
  final PostBidDetails postBidDetails;
  final List<dynamic> categoryId;
  final List<dynamic> categoryName;

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
    required this.city,
    required this.address,
    required this.pinCode,
    required this.state,
    
    required this.propertyOwnership,
    required this.transactionType,
    required this.avgRating,
    required this.totalRating,
    required this.tags,
    required this.keywords,
    // required this.createdAt,
    // required this.updatedAt,
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
  // final String lastBidAt;
  final String startTime;
  final String endTime;
  final String status;
  final String wonUserId;
  final int wonBidAmount;
  final String wonBidId;
  // final String wonAt;

  PostBidDetails({
    required this.totalBidCount,
    required this.minimumBid,
    required this.currentBid,
    required this.lastBidId,
    // required this.lastBidAt,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.wonUserId,
    required this.wonBidAmount,
    required this.wonBidId,
    // required this.wonAt,
  });
}

class User {
  final String uid;
  final String name;
  final String phoneNo;
  final Timestamp createdAt;
  final bool isVerified;
  final String profilePic;
  final String email;
  final String password;

  User({
    required this.uid,
    required this.name,
    required this.phoneNo,
    required this.createdAt,
    required this.profilePic,
    required this.email,
    required this.password,
    this.isVerified = false,
  });
}
