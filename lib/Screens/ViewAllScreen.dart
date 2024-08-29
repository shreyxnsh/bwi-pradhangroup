import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pradhangroup/Screens/Search.dart';
import 'package:pradhangroup/functions/firebase_functions.dart';
import 'package:pradhangroup/widgets/post_card_vertical.dart';

class ViewAllScreen extends StatefulWidget {
  const ViewAllScreen({super.key});

  @override
  State<ViewAllScreen> createState() => _ViewAllScreenState();
}

class _ViewAllScreenState extends State<ViewAllScreen> {
  FirebaseFunctions firebaseFunctions = FirebaseFunctions();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firebaseFunctions.fetchPostsFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Explore All",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Lexend',
                    fontSize: 18,
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      Get.to(() => Search() , transition: Transition.rightToLeftWithFade);
                    }, child: Icon(Icons.search, size: 27)),
              ],
            ),
            // const SizedBox(height: 20,),
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
          ],
        ),
      ),
    );
  }
}
