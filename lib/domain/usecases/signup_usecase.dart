import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduklio/presentation/pages/authentication_interface/signup_interface/signup_screen_teacher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import '../../presentation/pages/authentication_interface/signup_interface/signup_screen_teacher.dart';
import '../../presentation/pages/welcome_interface/home_screen.dart';

class SignUpUseCase  {

  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController= TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController schoolNameController = TextEditingController();
  TextEditingController teachingExperienceController = TextEditingController();
  TextEditingController qualificationController = TextEditingController();
  String gender = "";



  SignUpUseCase();


  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  SignupTeacher signupTeacher = SignupTeacher();
  void createAccount(BuildContext context, bool isTeacher) async {

    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String cPassword = confirmPasswordController.text.trim();
    String fname = fNameController.text;
    String lname = lNameController.text;
    String schoolName = schoolNameController.text;
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
          .collection('users')
          .add({'first name': fname,'last Name: ': lname,'email': email, 'password': password, 'userType': isTeacher ? 'Teacher' : 'Student', 'schoolName': schoolName,
        'gender':gender,'teachingExperience':teachingExperience, 'qualification': qualification});

      log("User Created");
      }
    }



    //set gender
    void setGender(String gender) {
         this.gender = gender;
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
  Future<void> updateUser() async{
    /*
          * IMPORTANT: Whenever data is stored on fireStore, its MAP Data structure
          * Map is to be created whenever you add.
         */

    Map<String, dynamic> newUserData = {
      "name": "",
      "email": "",
    };

    //If you want to update a doc
          await _firestore.collection("users").doc("your-doc-id-here").update({
            "email":"<updated email>",
          });

  }

  //deleting
  Future<void> deleteUser() async{
         await _firestore.collection("users").doc("your-doc-id-here").delete();
  }
  //streambuilder to get
  void realTimeDisplayOfAdding(BuildContext context) {
          StreamBuilder<QuerySnapshot>(
            //subscribed to firestore collection called users
            //so whenever doc is added/changed, we get 'notification'
            stream: _firestore.collection("users").snapshots(),
            //snapshot is real time data we will get
            builder: (context, snapshot) {
              //if connection (With firestore) is established then.....
              if (snapshot.connectionState == ConnectionState.active) {
              if(snapshot.hasData && snapshot.data != null) {
                return Expanded(
                  child: ListView.builder(
                    //length as much as doc we have
                      itemCount:snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        //from docs array we are now selecting a doc
                        Map<String, dynamic> userMap = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                        return ListTile(
                           title: Text(userMap["name"]),
                          subtitle: Text(userMap["email"]),
                          trailing: IconButton(onPressed: () {
                            //delete with specific document function comes here
                          },
                            icon: Icon(Icons.delete),
                          ),
                        );
                      },),
                );
              }
              else {
                return Text("No Data");
              }}
              else {
                return Center(
                  child: CircularProgressIndicator(),
                );
            }}, 
          );
  }




  }



