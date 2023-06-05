import 'dart:developer';
import 'dart:io';

import 'package:eduklio/data/repositories/user_repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

import 'package:path_provider/path_provider.dart';


class StorageRepository {
  UserRepository userRepository = UserRepository();
  //upload File
  String downloadURL = "";
  Future uploadFile(PlatformFile? pickedFile, String directoryName,bool isProfilePic) async {
    var path;
    if(isProfilePic) {
      path = '${directoryName}/${FirebaseAuth.instance.currentUser!.uid}/${pickedFile!.name}';
    }
    else {
    path = '${directoryName}/${Uuid().v1}/${pickedFile!.name}';
    }
    final file = File(pickedFile!.path!);
    log(file.toString());
    final ref = FirebaseStorage.instance.ref().child(path);
    log(ref.toString());
    UploadTask uploadTask = ref.putFile(file);
    log(uploadTask.toString());
    TaskSnapshot taskSnapshot = await uploadTask;
    log(taskSnapshot.toString());
    downloadURL = await taskSnapshot.ref.getDownloadURL();
    log(downloadURL.toString());
  }

  Future uploadDp(File? pickedFile, String directoryName) async {
    var path;

      path = '${directoryName}/${FirebaseAuth.instance.currentUser!.uid}/${Uuid().v1}/';

    final file = File(pickedFile!.path!);
    log(file.toString());
    final ref = FirebaseStorage.instance.ref().child(path);
    log(ref.toString());
    UploadTask uploadTask = ref.putFile(file);
    log(uploadTask.toString());
    TaskSnapshot taskSnapshot = await uploadTask;
    log(taskSnapshot.toString());
    downloadURL = await taskSnapshot.ref.getDownloadURL();
    log(downloadURL.toString());
    userRepository.addFieldToDocument("users", FirebaseAuth.instance.currentUser!.uid, "profilePic", downloadURL);

  }

  /*static Future<List<FirebaseFile>> listAll(String path) async {
          final ref = FirebaseStorage.instance.ref(path);
          final result = await ref.listAll();

          final urls = await _getDownloadLinks(result.items);

  }*/





}