import 'dart:developer';
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twitter_login/twitter_login.dart';

import '../../presentation/pages/welcome_interface/home_screen.dart';
import '../../presentation/pages/teacher_interface/teacher_homescreen.dart';

class SignInUseCase  {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController= TextEditingController();

  SignInUseCase();


  void login(BuildContext context) async {

    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email == "" || password == "") {
      log("Please fill in all the fields");
    }
    else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email,
            password: password);
        if (userCredential.user != null) {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacement(context,
              CupertinoPageRoute(builder: (context) => TeacherHomeScreen()));
        }
      } on FirebaseAuthException catch (ex) {
        log(ex.code.toString());
      }
    }
  }




  Future<void> loginWithFacebook(BuildContext context) async {
    final LoginResult result = await FacebookAuth.instance.login();

    switch (result.status) {
      case LoginStatus.success:
      // User is logged in with Facebook, handle the user data
        final AccessToken accessToken = result.accessToken!;
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacement(context,
            CupertinoPageRoute(builder: (context) => HomeScreen()));
        // Use the accessToken to get user data or make API calls to Facebook
        break;
      case LoginStatus.cancelled:
      // User cancelled the login process
        break;
      case LoginStatus.failed:
      // Error occurred during login process
        break;
    }
  }

  Future<String?> getUserEmailFromFacebook() async {
    final userData = await FacebookAuth.instance.getUserData(
      fields: 'email',
    );

    if (userData != null && userData.containsKey('email')) {
      return userData['email'];
    }

    return null; // User email not available
  }


  Future<UserCredential> signInWithTwitter(BuildContext context) async {
    // Create a TwitterLogin instance
    final twitterLogin = new TwitterLogin(
        apiKey: 'FHaeA8AwISJVp3wcbiogIrcoG',
        apiSecretKey:'hzakLRvVTVFIUbtdtZwVwWcEzhefqLdsRxQaOZ5OpQ1PQyKYEn',
        redirectURI: 'flutter-twitter-login://'
    );

    // Trigger the sign-in flow
    final authResult = await twitterLogin.login();

    // Create a credential from the access token
    final twitterAuthCredential = TwitterAuthProvider.credential(
      accessToken: authResult.authToken!,
      secret: authResult.authTokenSecret!,
    );
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => HomeScreen()));

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);


  }



  Future<void> loginGoogle(BuildContext context) async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(context,
        CupertinoPageRoute(builder: (context) => TeacherHomeScreen()));

  }

  Future<String?> getGoogleUserEmail() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    if (googleAuth != null && googleAuth.idToken != null) {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        return currentUser.email;
      }
    }

    return null; // User email not available
  }
}


