import 'dart:developer';
import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduklio/data/repositories/user_repository.dart';
import 'package:eduklio/presentation/components/MyGoogleButton.dart';
import 'package:eduklio/presentation/pages/authentication_interface/signin_interface/signin_as_screen.dart';
import 'package:eduklio/presentation/pages/student_interface/student_homescreen.dart';
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
  UserRepository userRepository =  UserRepository();





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

    final user = await FirebaseAuth.instance.signInWithCredential(credential);

    // Check if the user is already added in Firestore
    final userDoc = await userRepository.getUserById(user.user!.uid);
    bool isUserDocNull = userDoc == null;
    log(isUserDocNull.toString());
    if (isUserDocNull) {
      // User is not yet added, so add the user to Firestore
      userRepository.addUser(
        googleUser!.displayName!,
        googleUser!.email,
        FirebaseAuth.instance.currentUser!.uid,
        "Google",
      );
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(builder: (context) => SignInAs()),
      );
    } else {
      String text = await userRepository.getFieldFromDocument(FirebaseAuth.instance.currentUser!.uid, "userType");
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(builder: (context) =>  text == 'Teacher' ? TeacherHomeScreen() : StudentHomeScreen(),
      ));
    }
  }


  //add to field to doc


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


