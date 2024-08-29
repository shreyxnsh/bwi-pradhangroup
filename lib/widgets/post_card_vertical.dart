import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pradhangroup/FuncScreen/postDetails.dart';
import 'package:pradhangroup/functions/firebase_functions.dart';
import 'package:pradhangroup/main.dart';

class PostCardVertical extends StatefulWidget {
  final Post post;

  const PostCardVertical({Key? key, required this.post}) : super(key: key);

  @override
  State<PostCardVertical> createState() => _PostCardVerticalState();
}

class _PostCardVerticalState extends State<PostCardVertical> {
  bool like = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(
              builder: (context) => PostDetailScreen(
                    post: widget.post,
                  )),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.42,
        height: MediaQuery.of(context).size.height * 0.3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: CachedNetworkImage(
                    imageUrl: widget.post.coverPic,
                    height: 164,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      like = !like;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.center,
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(27.5),
                        color:
                            (like == true) ? '0095D9'.toColor() : Colors.white,
                      ),
                      child: (like == true)
                          ? Image.asset(
                              'assets/whiteheart.png',
                              height: 14,
                            )
                          : Image.asset(
                              'assets/bheart.png',
                              height: 14,
                            ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Text(
                  widget.post.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w400),
                ),
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
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.21,
                          child: Text(
                            widget.post.city,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w400),
                          ))
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
                      Text(widget.post.avgRating.toString())
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
