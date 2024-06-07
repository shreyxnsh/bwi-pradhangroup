import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pradhangroup/FuncScreen/Details.dart';
import 'package:pradhangroup/functions/firebase_functions.dart';
import 'package:pradhangroup/main.dart';

class PostCard extends StatelessWidget {
  final Post post;

  PostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context) => details(post: post,)));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: Color(0xFFF4F5FA),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: CachedNetworkImage(
                  imageUrl: post.coverPic,
                  height: 160,
                  width: 120,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 20, left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Text(
                        post.name,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Lexend',
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    // Use any placeholder for the rating image if needed
                    Image.asset('assets/rate.png', height: 18),
                    SizedBox(height: 10),
                    Text(
                      post.status,
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(height: 18),
                    Row(
                      children: [
                        Image.asset('assets/bloc.png', height: 18),
                        Text(
                          post.latitute ?? 'Unknown Location',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 8.0),
              //   child: Align(
              //     child: Icon(Icons.delete_outline),
              //     alignment: Alignment.topRight,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
