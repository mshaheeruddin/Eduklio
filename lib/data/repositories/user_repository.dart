import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/usecases/signin_usecase.dart';


class UserRepository {


  static final UserRepository _singleton = UserRepository._internal();

  factory UserRepository() {
    return _singleton;
  }

  UserRepository._internal();




  //instances required

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //SignInUseCase signInUseCase = SignInUseCase();


  //methods

  Future getFieldFromDocument(String collectionName, String documentId, String fieldName) async {
    final documentSnapshot =
    await FirebaseFirestore.instance.collection(collectionName).doc(documentId).get();

    if (documentSnapshot.exists) {
      final data = documentSnapshot.data();
      if (data != null && data.containsKey(fieldName)) {
        return data[fieldName];
      }
    }

    return null; // Field not found or document does not exist
  }

  Future<void> addToArray(String userId,String collectionName, String fieldName,String valueToAdd) async {
    final userRef = FirebaseFirestore.instance.collection(collectionName).doc(userId);

    await userRef.update({
      fieldName: FieldValue.arrayUnion([valueToAdd]),
    });
  }


  Future<void> removeFromArray(String userId, String collectionName, String fieldName, String valueToRemove) async {
    final userRef = FirebaseFirestore.instance.collection(collectionName).doc(userId);

    await userRef.update({
      fieldName: FieldValue.arrayRemove([valueToRemove])
    });
  }



  //return id of user
  Future<DocumentSnapshot<Map<String, dynamic>>?> getUserById(String userId, String collectionName) async {
    final docSnapshot = await FirebaseFirestore.instance.collection(collectionName).doc(userId).get();
    if (docSnapshot.exists) {
      return docSnapshot;
    } else {
      return null;
    }
  }



  //add data
  Future<void> addUser(String name, String email,String userId, String authProvider) async{

    Map<String, dynamic> newUserData = {
      "name": name,
      "email": email,
      "userId": userId,
      "authProvider": authProvider,
    };
    await _firestore.collection("users").doc(userId).set(newUserData);


    /*
         * If you want to give your own doc ID:
         * HERE WE USE `set`
         * await _firestore.collection("users").doc("your-doc-id-here").set(newUserData);
         * It will be created if doc doesn't exist.
       */
  }

  //add teacher to teacher collection
  Future<void> addTeacherUser(String name, String email,String userId, String authProvider) async{

    Map<String, dynamic> newUserData = {
      "name": name,
      "email": email,
      "students": [],
      "classes": [],
      "userId": userId,
    };
    await _firestore.collection("teachers").doc(userId).set(newUserData);


    /*
         * If you want to give your own doc ID:
         * HERE WE USE `set`
         * await _firestore.collection("users").doc("your-doc-id-here").set(newUserData);
         * It will be created if doc doesn't exist.
       */
  }

  Future<void> addStudentUser(String name, String email,String userId, String authProvider) async{

    Map<String, dynamic> newUserData = {
      "name": name,
      "email": email,
      "teachers": [],
      "classes": [],
      "userId": userId,

    };
    await _firestore.collection("students").doc(userId).set(newUserData);


    /*
         * If you want to give your own doc ID:
         * HERE WE USE `set`
         * await _firestore.collection("users").doc("your-doc-id-here").set(newUserData);
         * It will be created if doc doesn't exist.
       */
  }

// get user type

  Future<String?> getUserType(String collectionName, String userName) async {
    QuerySnapshot snapshot = await _firestore.collection(collectionName).get();

    String userType = "";
    for (var doc in snapshot.docs) {
      Map<String, dynamic> userMap = doc.data() as Map<String, dynamic>;
      if (userMap["name"] == userName) {
        userType = userMap["userType"];
      }
      return userType;
    }
    /*if (snapshot) {
      // Document exists
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      return data.toString();
    } else {
      // Document does not exist
      return "Document not found";
    }*/
  }

  String? getGoogleUserUID() {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    }

    return null; // User UID not available
  }

  String? getUserUID() {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    }

    return null; // User UID not available
  }

  String? getUserName() {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.displayName;
    }
    return null; // User UID not available
  }
  Future<String?> getUserFirstName() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userId = user.uid;
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      if (userDoc.exists) {
        final name = userDoc.get('name');
        if (name != null) {
          return firstNameFormatter(name);
        }
      }
    }
    return null; // User UID not available or name field is not set
  }


  //updating teacher user credentials
  Future<void> updateTeacherUserCredentials(String name, String email) async {
    Map<String, dynamic> newUserData = {
      "name": "",
      "email": "",
    };

    //If you want to update a doc
    await _firestore.collection("users").doc("your-doc-id-here").update({
      "email": "<updated email>",
    });

    //updating student user credentials
    Future<void> updateStudentUserCredentials(String name, String email) async {
      Map<String, dynamic> newUserData = {
        "name": "",
        "email": "",
      };

      //If you want to update a doc
      await _firestore.collection("users").doc("your-doc-id-here").update({
        "email": "<updated email>",
      });
    }

  }
  //add a field to doc
  Future<void> addFieldToDocument(String collectionName, String documentId, String fieldName, dynamic fieldValue,) async {
    final documentReference = FirebaseFirestore.instance.collection(collectionName).doc(documentId);

    await documentReference.update({
      fieldName: fieldValue,
    });
  }

  //deleting
  Future<void> deleteSomethingFromCollection(String collectionName, String id) async {
    await _firestore.collection(collectionName).doc(id).delete();
  }

  //only first name
  String? firstNameFormatter(String name) {
    String fname = "";
    for(int i =0; i< name.length;i++) {
      if(!(name[i] == " ")) {
        fname = fname + name[i];
      }
      else break;
    }
    return fname;
  }
}