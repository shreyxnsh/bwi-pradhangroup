import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pradhangroup/main.dart';

class AddReviewWidget extends StatefulWidget {
  final String postId;
  final String userId;
  final String userName;

  const AddReviewWidget({
    Key? key,
    required this.postId,
    required this.userId,
    required this.userName,
  }) : super(key: key);

  @override
  _AddReviewWidgetState createState() => _AddReviewWidgetState();
}

class _AddReviewWidgetState extends State<AddReviewWidget> {
  int _rating = 0; // Holds the selected star rating
  TextEditingController _reviewController = TextEditingController();

  // Function to add the review to Firestore
  Future<void> _submitReview() async {
    if (_rating == 0 || _reviewController.text.isEmpty) {
      // Show error if rating or review is empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please provide a rating and review')),
      );
      return;
    }

    final reviewId = FirebaseFirestore.instance.collection('posts').doc().id;
    final reviewData = {
      'postId': widget.postId,
      'msg': _reviewController.text,
      'reviewedBy': {
        'name': widget.userName,
        'id': widget.userId,
      },
      'createdAt': DateTime.now(),
      'rating': _rating,
    };

    await FirebaseFirestore.instance
        .collection('posts')
        .doc(widget.postId)
        .collection('reviews')
        .doc(reviewId)
        .set(reviewData);

    // Clear input after submitting
    setState(() {
      _rating = 0;
      _reviewController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Review submitted!')),
    );
  }

  // Function to open the bottom sheet showing all reviews
  void _showAllReviews(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allow full-height scrollable bottom sheet
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.9, // Takes 90% of the screen height
          child: AllReviewsBottomSheet(postId: widget.postId),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Rating Stars
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return IconButton(
                icon: Icon(
                  index < _rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                ),
                onPressed: () {
                  setState(() {
                    _rating = index + 1;
                  });
                },
              );
            }),
          ),
        ),

        // Review Text Box
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            controller: _reviewController,
            decoration: InputDecoration(
              labelText: 'Write your review...',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _submitReview,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 20),
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width / 2.5,
                  decoration: BoxDecoration(
                      color: 'F4F5FA'.toColor(),
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      'Submit Review',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          fontFamily: 'Lexend'),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => _showAllReviews(context), // Show all reviews bottom sheet
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width / 2.5,
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
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class AllReviewsBottomSheet extends StatelessWidget {
  final String postId;

  const AllReviewsBottomSheet({Key? key, required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text(
            'All Reviews',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: 'Lexend',
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('posts')
                  .doc(postId)
                  .collection('reviews')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text('No reviews available'),
                  );
                }

                var reviews = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: reviews.length,
                  itemBuilder: (context, index) {
                    var reviewData = reviews[index].data() as Map<String, dynamic>;
                    return Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Container(
                        width: double.maxFinite,
                        height: 122,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: 'F4F5FA'.toColor(),
                        ),
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
                                      Text(reviewData['reviewedBy']['name'] ?? 'Unknown'),
                                      SizedBox(height: 6),
                                      Row(
                                        children: List.generate(
                                          5,
                                          (index) => Icon(
                                            index < reviewData['rating']
                                                ? Icons.star
                                                : Icons.star_border,
                                            size: 10,
                                            color: index < reviewData['rating']
                                                ? Colors.yellow
                                                : Colors.grey,
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
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
