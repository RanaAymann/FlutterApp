import 'dart:convert';
import 'dart:math';
import 'package:FlutterApp/app_cache.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:crypto/crypto.dart';

class Login {
  // client number from fb developer account
  // String client = "";
  // String url = "https://www.facebook.com/connect/login_success.html";
  static final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    hostedDomain: "",
    clientId: "",
  );
  static String userName = "";
  static String userEmail = "";

  // loginWithFacebook(BuildContext context) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var storedFbUser = prefs.getString('fbToken');
  //   if (storedFbUser != "") {
  //     await prefs.setBool('isLoggedIn', true);
  //     // Navigator.push(context,
  //     //     MaterialPageRoute(builder: (BuildContext context) => Home));
  //   } else {
  //     String result = await Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (BuildContext context) => FbWebView(
  //           selectedUrl:
  //               "https://www.facebook.com/dialog/oauth?client_id=$client&redirect_uri=$url&response_type=token&scope=email,public_profile,",
  //         ),
  //       ),
  //     );
  //     if (result != null) {
  //       try {
  //         final facebookAuthCred = FacebookAuthProvider.credential(result);
  //         final fbUser = await FirebaseAuth.instance
  //             .signInWithCredential(facebookAuthCred);
  //         // save fb user credentials
  //         prefs.setString('fbToken', facebookAuthCred.accessToken);
  //         userName = fbUser.user.displayName;
  //         AppCache.saveUserName(userName);
  //         userEmail = fbUser.user?.providerData[0]?.email;
  //         AppCache.saveUserEmail(userEmail);
  //         if (fbUser.credential != null) {
  //           await prefs.setBool('isLoggedIn', true);
  //           // Navigator.push(context,
  //           //     MaterialPageRoute(builder: (BuildContext context) => Home));
  //         }
  //       } catch (e) {
  //         print(e);
  //       }
  //     }
  //   }
  // }

  // for apple login
  static String generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  // Returns the sha256 hash of [input] in hex notation for apple login
  static String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  static loginWithApple(BuildContext context) async {
    // apple login saves user data in the first login only , so it should be stored to retrieve it
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var storedAppleUser = prefs.getString('appleToken');
    print(storedAppleUser);
    if (storedAppleUser != "") {
      await prefs.setBool('isLoggedIn', true);
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (BuildContext context) => Home));
    } else {
      try {
        final rawNonce = generateNonce();
        final nonce = sha256ofString(rawNonce);

        final appleCredential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
          nonce: nonce,
        );
        print(appleCredential.authorizationCode);
        if (appleCredential.email != null) {
          userName =
              appleCredential.givenName + " " + appleCredential.familyName;
          userEmail = appleCredential.email;
          AppCache.saveAppleUserName(userName);
          AppCache.saveAppleEmail(userEmail);
        } else {
          userName = await AppCache.getSavedAppleUserName();
          userEmail = await AppCache.getSavedAppleEmail();
          await prefs.setString("email", userEmail);
          await prefs.setString("username", userName);
        }
        final oauthCredential = OAuthProvider("apple.com").credential(
          idToken: appleCredential.identityToken,
          rawNonce: rawNonce,
        );
        var firebaseUser =
            await FirebaseAuth.instance.signInWithCredential(oauthCredential);
        await prefs.setString('appleToken', appleCredential.identityToken);
        print(firebaseUser);
        if (appleCredential != null) {
          await prefs.setBool('isLoggedIn', true);
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (BuildContext context) => Home));
        }
        return firebaseUser;
      } catch (error) {
        Exception(error);
      }
    }
  }

  static loginWithGoogle() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var storedGmailUser = prefs.getString('gmailToken');
    print(storedGmailUser);
    if (storedGmailUser != "") {
      await prefs.setBool('isLoggedIn', true);
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (BuildContext context) => Home));
    } else {
      GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      userName = googleSignInAccount.displayName;
      userEmail = googleSignInAccount.email;
      AppCache.saveUserName(userName);
      AppCache.saveAppleEmail(userEmail);
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      var gmailUser =
          await FirebaseAuth.instance.signInWithCredential(credential);
      // save gmail user credentials
      await prefs.setString('gmailToken', credential.accessToken);
      if (gmailUser.credential != null) {
        await prefs.setBool('isLoggedIn', true);
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (BuildContext context) => Home));
      }
    }
  }
}
