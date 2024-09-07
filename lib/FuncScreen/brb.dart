import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pradhangroup/Screens/Search.dart';
import 'package:pradhangroup/functions/firebase_functions.dart';
import 'package:pradhangroup/main.dart';
import 'package:pradhangroup/widgets/post_card.dart';

import 'postDetails.dart';

class buy extends StatefulWidget {
  const buy({super.key});

  @override
  State<buy> createState() => _buyState();
}

class _buyState extends State<buy> {
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
                    "Buy Property",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Lexend',
                        fontSize: 18),
                  ),
                  GestureDetector(
                     onTap: () {
                      Get.to(() => Search() , transition: Transition.rightToLeftWithFade);
                    },
                    child: Container(
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
                  ),
                ],
              ),
              // SizedBox(height: 25,),
              // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Row(
              //       children: [
              //         GestureDetector(
              //           onTap: () {
              //             setState(() {
              //               all = true;
              //               ongoing = false;
              //               upcoming = false;
              //             });
              //           },
              //           child: Container(
              //             height: 50,
              //             width: 65,
              //             decoration: BoxDecoration(
              //               color: (all == true) ? '262425'.toColor() : 'F4F5FA'.toColor(),
              //               borderRadius: BorderRadius.circular(20),
              //             ),
              //             child: Center(
              //               child: Text('All', style: TextStyle(fontSize: 12, fontWeight: (all == true) ? FontWeight.w700 : FontWeight.w300, color: (all == true) ? Colors.white : Colors.black)),
              //             ),
              //           ),
              //         ),
              //         SizedBox(width: 12),
              //         GestureDetector(
              //           onTap: () {
              //             setState(() {
              //               all = false;
              //               ongoing = true;
              //               upcoming = false;
              //             });
              //           },
              //           child: Container(
              //             height: 50,
              //             width: 65,
              //             decoration: BoxDecoration(
              //               color: (ongoing == true) ? '262425'.toColor() : 'F4F5FA'.toColor(),
              //               borderRadius: BorderRadius.circular(20),
              //             ),
              //             child: Center(
              //               child: Text('Ongoing', style: TextStyle(fontSize: 12, fontWeight: (ongoing == true) ? FontWeight.w700 : FontWeight.w300, color: (ongoing == true) ? Colors.white : Colors.black)),
              //             ),
              //           ),
              //         ),
              //         SizedBox(width: 12),
              //         GestureDetector(
              //           onTap: () {
              //             setState(() {
              //               all = false;
              //               ongoing = false;
              //               upcoming = true;
              //             });
              //           },
              //           child: Container(
              //             height: 50,
              //             width: 75,
              //             decoration: BoxDecoration(
              //               color: (upcoming == true) ? '262425'.toColor() : 'F4F5FA'.toColor(),
              //               borderRadius: BorderRadius.circular(20),
              //             ),
              //             child: Center(
              //               child: Text('Upcoming', style: TextStyle(fontSize: 12, fontWeight: (upcoming == true) ? FontWeight.w700 : FontWeight.w300, color: (upcoming == true) ? Colors.white : Colors.black)),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //     Image.asset('assets/options.png', height: 47),
              //   ],
              // ),
              // SizedBox(height: 11),
              ValueListenableBuilder<List<Post>>(
                valueListenable: firebaseFunctions.postsNotifier,
                builder: (context, posts, _) {
                  // Filter posts to include only those with transactionType as "sale"
                  final salePosts =
                      posts.where((post) => post.postType == 'buy').toList();

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: salePosts.length,
                    itemBuilder: (context, index) {
                      return PostCard(post: salePosts[index]);
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
}
