import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pradhangroup/functions/firebase_functions.dart';
import 'package:pradhangroup/main.dart';
import 'package:pradhangroup/widgets/post_card.dart';

import '../FuncScreen/postDetails.dart';
class Listing extends StatefulWidget {
  const Listing({super.key});

  @override
  State<Listing> createState() => _ListingState();
}

class _ListingState extends State<Listing> {
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
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Listing", style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Lexend', fontSize: 18)),
                  Icon(Icons.search, size: 27)
                ],
              ),
              SizedBox(height: 35),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            color: (all == true) ? '262425'.toColor() : 'F4F5FA'.toColor(),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text('All', style: TextStyle(fontSize: 12, fontWeight: (all == true) ? FontWeight.w700 : FontWeight.w300, color: (all == true) ? Colors.white : Colors.black)),
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
                            color: (ongoing == true) ? '262425'.toColor() : 'F4F5FA'.toColor(),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text('Ongoing', style: TextStyle(fontSize: 12, fontWeight: (ongoing == true) ? FontWeight.w700 : FontWeight.w300, color: (ongoing == true) ? Colors.white : Colors.black)),
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
                            color: (upcoming == true) ? '262425'.toColor() : 'F4F5FA'.toColor(),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text('Upcoming', style: TextStyle(fontSize: 12, fontWeight: (upcoming == true) ? FontWeight.w700 : FontWeight.w300, color: (upcoming == true) ? Colors.white : Colors.black)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Image.asset('assets/options.png', height: 47),
                ],
              ),
              SizedBox(height: 11),
              ValueListenableBuilder<List<Post>>(
                valueListenable: firebaseFunctions.postsNotifier,
                builder: (context, posts, _) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      return PostCard(post: posts[index]);
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
