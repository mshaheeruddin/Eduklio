import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduklio/data/repositories/user_repository.dart';
import 'package:eduklio/presentation/pages/authentication_interface/signup_interface/signup_screen_teacher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import '../../presentation/pages/authentication_interface/signup_interface/signup_screen_teacher.dart';
import '../../presentation/pages/welcome_interface/home_screen.dart';

class SignUpUseCase  {

  UserRepository userRepository = UserRepository();


  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController= TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController schoolNameController = TextEditingController();
  TextEditingController teachingExperienceController = TextEditingController();
  TextEditingController qualificationController = TextEditingController();
  String genderTeacher = "";


  TextEditingController studentNameController = TextEditingController();
  TextEditingController studentEmailController = TextEditingController();
  TextEditingController studentPasswordController= TextEditingController();
  TextEditingController studentConfirmPasswordController = TextEditingController();
  TextEditingController studentInstitutionNameController = TextEditingController();
  TextEditingController studentGradeLevelController = TextEditingController();
  String userDocumentId = "";



  SignUpUseCase();


  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  SignupTeacher signupTeacher = SignupTeacher();
  void createTeacherAccount(BuildContext context, String selectedGender) async {

    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String cPassword = confirmPasswordController.text.trim();
    String fname = fNameController.text;
    String lname = lNameController.text;
    String schoolName = schoolNameController.text;
    String gender = selectedGender;
    String teachingExperience = teachingExperienceController.text.trim();
    String qualification = qualificationController.text;

    if (email == "" || password == "" || cPassword == "" ) {
      log("Please fill in all the fields");
    }
    else if(password != cPassword)  {
      log("Password do not match");
    }
    else {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      await _firestore
          .collection('users').doc(userCredential.user?.uid)
          .set({'first name': fname,'last Name: ': lname,'email': email, 'password': password, 'userType': 'Teacher', 'schoolName': schoolName,
        'gender':selectedGender,'teachingExperience':teachingExperience, 'qualification': qualification, 'students': []});
      userRepository.addTeacherUser(fname, email, userCredential.user!.uid, "local");
      log("User Created");
    }
  }


  String getDocumentId() {
    print(userDocumentId);
    return this.userDocumentId;
  }


  void createStudentAccount(BuildContext context, String selectedGender) async {

    String email = studentEmailController.text.trim();
    String password = studentPasswordController.text.trim();
    String cPassword = studentConfirmPasswordController.text.trim();
    String name = studentNameController.text.trim();
    String schoolName = studentInstitutionNameController.text;
    String gender = selectedGender;
    String gradeLevel = studentGradeLevelController.text;

    if (email == "" || password == "" || cPassword == "" ) {
      log("Please fill in all the fields");
    }
    else if(password != cPassword)  {
      log("Password do not match");
    }
    else {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        await _firestore
          .collection('users').doc(userCredential.user?.uid)
          .set({
        'name': name,
        'gender':selectedGender,
        'email': email,
        'password': password,
        'userType': 'Student',
        'schoolName': schoolName,
        'gradeLevel': gradeLevel,
          'teachers': [],
          'enrolledClasses':[]});
      log("Student User Created");
      userRepository.addStudentUser(name, email, userCredential.user!.uid, "local");
    }
  }




  //set gender
  void setGender(String gender) {
    this.genderTeacher = gender;
  }


  //fetching data
  Future<void> getData() async {
    //fetching all documents (only) not actual data
    QuerySnapshot snapshot = await _firestore.collection("users").get();
    log(snapshot.docs.toString());
    //get data in each doc in array
    for(var doc in snapshot.docs) {
      log(doc.data().toString());
    }
    /*
         * For specific document selection:
         * QuerySnapshot snapshot = await FirebaseFirestore.instance.collection
           ("users").doc('<ENTER DOCUMENT ID HERE>').get();
           log(snapshot.docs.toString());
           //get data from this document: no need for for-loop(only 1 data)
           snapshot.data().toString()
       */
  }
  //add data
  Future<void> addUser() async{
    /*
          * IMPORTANT: Whenever data is stored on fireStore, its MAP Data structure
          * Map is to be created whenever you add.
         */

    Map<String, dynamic> newUserData = {
      "name": "",
      "email": "",
    };
    await _firestore.collection("users").add(newUserData);
    log('New User Saved');

    /*
         * If you want to give your own doc ID:
         * await _firestore.collection("users").doc("your-doc-id-here").set(newUserData);
         * It will be created if doc doesn't exist.
       */
  }

  //updating data
  Future<void> updateUser(String docId) async{

    //If you want to update a doc
    await _firestore.collection("users").doc(docId).update({
      "email":"<updated email>",
    });

  }

  Future<void> addFieldInUserDocument(String userId) async {
    DocumentReference userRef = _firestore.collection("users").doc(userId);

    DocumentSnapshot userSnapshot = await userRef.get();

    if (userSnapshot.exists) {
      // User document already exists, update the email field if it exists or create it if it doesn't
      await userRef.set(
        {
          "userId": "${userId}",
        },
        SetOptions(merge: true),
      );
    } else {
      // User document doesn't exist, create a new document with the email field
      await userRef.set(
        {
          "userId": "${userId}",
        },
      );
    }
  }


  //deleting
  Future<void> deleteUser() async{
    await _firestore.collection("users").doc("your-doc-id-here").delete();
  }





}



