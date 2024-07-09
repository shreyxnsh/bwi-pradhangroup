import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<void> saveLikedPost(String postId) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> likedPosts = prefs.getStringList('likedPosts') ?? [];
    if (!likedPosts.contains(postId)) {
      likedPosts.add(postId);
    }
    await prefs.setStringList('likedPosts', likedPosts);
  }

  static Future<void> removeLikedPost(String postId) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> likedPosts = prefs.getStringList('likedPosts') ?? [];
    if (likedPosts.contains(postId)) {
      likedPosts.remove(postId);
    }
    await prefs.setStringList('likedPosts', likedPosts);
  }

  static Future<List<String>> getLikedPosts() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('likedPosts') ?? [];
  }

  static Future<bool> isPostLiked(String postId) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> likedPosts = prefs.getStringList('likedPosts') ?? [];
    return likedPosts.contains(postId);
  }
}
