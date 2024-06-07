import 'package:get_storage/get_storage.dart';

class UserDataService {
  static String getUserUID() {
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

  static DateTime getUserCreatedAt() {
    final userTime = GetStorage().read('createdAt');
    if (userTime != null) {
      return userTime;
    }
    return DateTime.now();
  }

  static bool getUserIsVerified() {
    final isVerified = GetStorage().read('isVerified');
    if (isVerified != null) {
      return isVerified;
    }
    return false;
  }
}
