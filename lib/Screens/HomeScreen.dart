import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pradhangroup/FuncScreen/Notification.dart';
import 'package:pradhangroup/FuncScreen/postDetails.dart';
import 'package:pradhangroup/FuncScreen/rent.dart';
import 'package:pradhangroup/Screens/Search.dart';
import 'package:pradhangroup/Screens/ViewAllScreen.dart';
import 'package:pradhangroup/Screens/profile.dart';
import 'package:pradhangroup/functions/firebase_functions.dart';
import 'package:pradhangroup/main.dart';
import 'package:pradhangroup/widgets/post_card.dart';
import 'package:pradhangroup/widgets/post_card_vertical.dart';

import '../FuncScreen/bidScreen.dart';
import '../FuncScreen/brb.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool all = true;
  bool top = false;
  bool manesar = false;
  bool price = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String pfpImageUrl = "";
  refresh() {
    all = false;
    top = false;
    manesar = false;
    price = false;
  }

  FirebaseFunctions firebaseFunctions = FirebaseFunctions();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadUserData(_auth.currentUser!.uid);
    firebaseFunctions.fetchPostsFromFirestore();
  }

  Future<void> loadUserData(String authId) async {
    var data = await FirebaseFunctions().fetchUserbyID(authId);
    log("User data loaded successfully : $data");
    log("User Name : ${data!.name}");
    log("User Email : ${data.email}");
    log("User Contact : ${data.phoneNo}");
    log("User PFP URL : ${data.profilePic}");
    setState(() {
      pfpImageUrl = data.profilePic;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 60.0, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/Location.png',
                            height: 18,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Delhi , India',
                            style:
                                TextStyle(fontSize: 14, fontFamily: 'Lexend'),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 3.0),
                            child: Image.asset(
                              'assets/down.png',
                              height: 6,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'South Delhi',
                        style: TextStyle(
                            fontFamily: 'Lexend',
                            fontSize: 12,
                            color: '737373'.toColor(),
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          Get.to(() => NotificationScreen(), transition: Transition.rightToLeftWithFade); 
                        },
                        child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: 'F0F0F0'.toColor())),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Image.asset(
                                'assets/noti.png',
                                height: 10,
                                width: 10,
                              ),
                            )),
                      ),
                      SizedBox(width: 15),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(builder: (context) => Profile()),
                          );
                        },
                        child: pfpImageUrl == ""
                            ? Image.asset(
                                'assets/profile.png',
                                height: 40,
                              )
                            : CircleAvatar(
                                radius: 20,
                                backgroundColor: 'F4F5FA'.toColor(),
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundImage: NetworkImage(pfpImageUrl),
                                ),
                              ),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Get.to(() => Search(),
                      transition: Transition.rightToLeftWithFade);
                },
                child: Container(
                  height: 56,
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => Search(),
                          transition: Transition.rightToLeftWithFade);
                    },
                    child: AbsorbPointer(
                      child: TextField(
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
                                width: 1,
                                color: 'F4F5FA'.toColor()), //<-- SEE HERE
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 28,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      height: 228,
                      width: 355,
                      child: Stack(
                        children: [
                          Image.asset('assets/vscroll.png'),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              height: 56,
                              width: 86,
                              decoration: BoxDecoration(
                                  color: '0095D9'.toColor(),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(25),
                                      bottomLeft: Radius.circular(25))),
                              child: Icon(
                                Icons.arrow_forward_outlined,
                                size: 27,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 23.0, left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'For you',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: 'A5E3FF'.toColor(),
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Lexend'),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  'Properties',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Lexend'),
                                ),
                                SizedBox(
                                  height: 26,
                                ),
                                Text(
                                  'Lorem ipsum dolor sit amet,\nconsectetur adipiscing elit',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300,
                                      fontFamily: 'Lexend'),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 228,
                      width: 355,
                      child: Stack(
                        children: [
                          Image.asset('assets/vscroll.png'),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              height: 56,
                              width: 86,
                              decoration: BoxDecoration(
                                  color: '0095D9'.toColor(),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(25),
                                      bottomLeft: Radius.circular(25))),
                              child: Icon(
                                Icons.arrow_forward_outlined,
                                size: 27,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 23.0, left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'For you',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: 'A5E3FF'.toColor(),
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Lexend'),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  'Properties',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Lexend'),
                                ),
                                SizedBox(
                                  height: 26,
                                ),
                                Text(
                                  'Lorem ipsum dolor sit amet,\nconsectetur adipiscing elit',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300,
                                      fontFamily: 'Lexend'),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(builder: (context) => buy()),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.width / 3.6,
                          width: MediaQuery.of(context).size.width / 3.6,
                          decoration: BoxDecoration(
                              color: 'F4F5FA'.toColor(),
                              borderRadius: BorderRadius.circular(25)),
                          child: Image.asset(
                            'assets/buy.png',
                            height: 55,
                            width: 55,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Buy',
                          style: TextStyle(
                              fontFamily: 'Lexend',
                              fontSize: 16,
                              fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(builder: (context) => rent()),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.width / 3.6,
                          width: MediaQuery.of(context).size.width / 3.6,
                          decoration: BoxDecoration(
                              color: 'F4F5FA'.toColor(),
                              borderRadius: BorderRadius.circular(25)),
                          child: Image.asset(
                            'assets/rent.png',
                            height: 55,
                            width: 55,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Rent',
                          style: TextStyle(
                              fontFamily: 'Lexend',
                              fontSize: 16,
                              fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(builder: (context) => BidScreen()),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.width / 3.6,
                          width: MediaQuery.of(context).size.width / 3.6,
                          decoration: BoxDecoration(
                              color: 'F4F5FA'.toColor(),
                              borderRadius: BorderRadius.circular(25)),
                          child: Image.asset(
                            'assets/bid.png',
                            height: 55,
                            width: 55,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Bid',
                          style: TextStyle(
                              fontFamily: 'Lexend',
                              fontSize: 16,
                              fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Featured Listings',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        fontFamily: 'Lexend'),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => ViewAllScreen(),
                          transition: Transition.rightToLeftWithFade);
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
              SizedBox(
                height: 22,
              ),
              ValueListenableBuilder<List<Post>>(
                valueListenable: firebaseFunctions.postsNotifier,
                builder: (context, posts, _) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.26,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        return PostCard(post: posts[index]);
                      },
                    ),
                  );
                },
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Explore Listings',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        fontFamily: 'Lexend'),
                  ),
                  GestureDetector(
                      onTap: () {
                        Get.to(() => ViewAllScreen(),
                            transition: Transition.rightToLeftWithFade);
                      },
                      child: Text(
                        'View all',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                          fontFamily: 'Lexend',
                          decoration: TextDecoration.underline,
                        ),
                      ))
                ],
              ),
              SizedBox(
                height: 22,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          refresh();
                          all = true;
                        });
                      },
                      child: Container(
                        height: 50,
                        width: 102,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: (all == true)
                                ? '262425'.toColor()
                                : 'F4F5FA'.toColor()),
                        child: Center(
                            child: Text(
                          'All',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: (all == true)
                                  ? FontWeight.w700
                                  : FontWeight.w300,
                              color:
                                  (all == true) ? Colors.white : Colors.black),
                        )),
                      ),
                    ),
                    SizedBox(
                      width: 14,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          refresh();
                          top = true;
                        });
                      },
                      child: Container(
                        height: 50,
                        width: 102,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: (top == true)
                                ? '262425'.toColor()
                                : 'F4F5FA'.toColor()),
                        child: Center(
                            child: Text(
                          'Top Rated',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: (top == true)
                                  ? FontWeight.w700
                                  : FontWeight.w300,
                              color:
                                  (top == true) ? Colors.white : Colors.black),
                        )),
                      ),
                    ),
                    SizedBox(
                      width: 14,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          refresh();
                          manesar = true;
                        });
                      },
                      child: Container(
                        height: 50,
                        width: 102,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: (manesar == true)
                                ? '262425'.toColor()
                                : 'F4F5FA'.toColor()),
                        child: Center(
                            child: Text(
                          'Manesar',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: (manesar == true)
                                  ? FontWeight.w700
                                  : FontWeight.w300,
                              color: (manesar == true)
                                  ? Colors.white
                                  : Colors.black),
                        )),
                      ),
                    ),
                    SizedBox(
                      width: 14,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          refresh();
                          price = true;
                        });
                      },
                      child: Container(
                        height: 50,
                        width: 122,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: (price == true)
                                ? '262425'.toColor()
                                : 'F4F5FA'.toColor()),
                        child: Center(
                            child: Text(
                          'Price-Low to High',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: (price == true)
                                  ? FontWeight.w700
                                  : FontWeight.w300,
                              color: (price == true)
                                  ? Colors.white
                                  : Colors.black),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 28),
              ValueListenableBuilder<List<Post>>(
                valueListenable: firebaseFunctions.postsNotifier,
                builder: (context, posts, _) {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.62,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      return PostCardVertical(post: posts[index]);
                    },
                  );
                },
              ),
              SizedBox(height: 50),
              // SizedBox(height: 50,)
            ],
          ),
        ),
      ),
    );
  }
}
