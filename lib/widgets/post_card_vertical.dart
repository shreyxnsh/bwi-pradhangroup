import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pradhangroup/FuncScreen/Details.dart';
import 'package:pradhangroup/functions/firebase_functions.dart';
import 'package:pradhangroup/main.dart';

class PostCardVertical extends StatelessWidget {
  final Post post;

  const PostCardVertical({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context) => details(post: post,)),);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: CachedNetworkImage(
                  imageUrl: post.coverPic,
                  height: 164,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  alignment: Alignment.center,
                  height: 28,
                  width: 28,
                  decoration: BoxDecoration(
                      color: '0095D9'.toColor(),
                      borderRadius: BorderRadius.circular(14)),
                  child: Image.asset(
                    'assets/whiteheart.png',
                    height: 14,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              post.name,
              style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w400),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0, top: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/bloc.png',
                      height: 16,
                    ),
                    Text(post.latitute)
                  ],
                ),
                SizedBox(width: 23),
                Row(
                  children: [
                    Image.asset(
                      'assets/star.png',
                      height: 16,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(post.avgRating.toString())
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
