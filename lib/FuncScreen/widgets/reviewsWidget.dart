import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pradhangroup/main.dart';

class ReviewsWidget extends StatelessWidget {
  final String postId;

  ReviewsWidget({required this.postId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .doc(postId)
            .collection('reviews')
            .orderBy('createdAt', descending: true)
            .limit(2)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.docs.isEmpty) {
            return Column(

              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child:
                Center(
                  child: Text(
                    'No reviews available',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Lexend'),
                  ),
                ),
                ),
              ],
            );
          }

          var reviews = snapshot.data!.docs;

          return Column(
            children: reviews.map((reviewDoc) {
              var reviewData = reviewDoc.data() as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  width: double.maxFinite,
                  height: 110,
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(reviewData['reviewedBy']['name'] ??
                                    'Unknown'),
                                SizedBox(height: 6),
                                Row(
                                  children: List.generate(
                                    5,
                                    (index) => SizedBox(
                                      child: index < reviewData['rating']
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 2.0),
                                              child: Image.asset(
                                                'assets/star.png',
                                                height: 15,
                                              ),
                                            )
                                          : Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 2.0),
                                              child: Image.asset(
                                                'assets/gstar.png',
                                                height: 15,
                                              ),
                                            ),
                                      // size: 10,
                                      // color: index < reviewData['rating']
                                      //     ? Colors.yellow
                                      //     : Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          reviewData['msg'] ?? '',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Lexend',
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
