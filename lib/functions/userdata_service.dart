import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';

class UserDataService {
   String getUserUID() {
    final storedToken = GetStorage().read('uid');
    if (storedToken != null) {
      return storedToken;
    }
    return '';
  }

   static String getUserName() {
    final userName = GetStorage().read('name');
    if (userName != null) {
      return userName;
    }
    return '';
  }

   static String getUserPhoneNo() {
    final userPhone = GetStorage().read('phoneNo');
    if (userPhone != null) {
      return userPhone;
    }
    return '';
  }

   Timestamp getUserCreatedAt() {
    final userTime = GetStorage().read('createdAt');
    if (userTime != null) {
      return userTime;
    }
    return userTime;
  }

   bool getUserIsVerified() {
    final isVerified = GetStorage().read('isVerified');
    if (isVerified != null) {
      return isVerified;
    }
    return false;
  }
}
