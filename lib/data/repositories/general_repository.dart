import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduklio/domain/usecases/signin_usecase.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class Repository {

  static final Repository _singleton = Repository._internal();
  factory Repository() {
    return _singleton;
  }
  Repository._internal();


  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  SignInUseCase signInUseCase = SignInUseCase();

  //get data
  Future<void> getAllDocuments(String collectionName) async {
    //fetching all documents (only) not actual data
    //QuerySnapshot is a container for documents[Collection] (it contains it)
    QuerySnapshot snapshot = await _firestore.collection(collectionName).get();

    //get data from snapshot that holds the document
    //so do doc.data() to get data inside document
    for(var doc in snapshot.docs) {

    }
  }


  Future<String> getSingleDocument(String collectionName, String docId) async {
    DocumentSnapshot snapshot =
    await _firestore.collection(collectionName).doc(docId).get();

    if (snapshot.exists) {
      // Document exists
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      return data.toString();
    } else {
      // Document does not exist
      return "Document not found";
    }
  }


}