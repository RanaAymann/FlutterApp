import 'package:shared_preferences/shared_preferences.dart';

class AppCache {
  // method to save username
  static saveUserName(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString("username", username);
  }

  static getSavedUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var username = prefs.getString("username");
    return username;
  }

  // method to save user email
  static saveUserEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString("email", email);
  }

  static getSavedEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString("email");
    return email;
  }

  // save apple username
  static saveAppleUserName(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('username ' + username);
    return await prefs.setString("appleUserame", username);
  }

// method to get saved apple username
  static getSavedAppleUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var username = prefs.getString("appleUserame");
    return username;
  }

  // save apple email
  static saveAppleEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('appleEmail ' + email);
    return await prefs.setString("appleEmail", email);
  }

  // method to get saved token
  static getSavedAppleEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString("appleEmail");
    return email;
  }
}
