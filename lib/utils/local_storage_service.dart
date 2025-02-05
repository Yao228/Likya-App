import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static String userFullname = "USER_FULLNAME";
  static String userPhonenumber = "USER_NUMBER";
  static String userRole = "USER_ROLE";
  static String pingServer = "PING_SERVER";
  static String token = "TOKEN";
  static String userDetail = "USER_DETAIL";
  static String userId = "USER_ID";
  static String collectId = "COLLECT_ID";
  static String contributionId = "CONTRIBUTION_ID";
  static String walletId = "WALLET_ID";
  static String transactionId = "TRANSACTION_ID";
  static String payementUrl = "PAYMENT_URL";
  static String depositAmount = "DEPOSITAMOUNT";

  static Future<void> putString(String key, String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(key, value);
  }

  static Future<String?> getString(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key);
  }

  static Future<bool> deleteKey(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.remove(key);
  }
}
