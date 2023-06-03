import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

import 'package:path_provider/path_provider.dart';


class StorageRepository {

  //upload File
  String downloadURL = "";
  Future uploadFile(PlatformFile? pickedFile) async {
    final path = 'files/${Uuid().v1()}/${pickedFile!.name}';
    log(path.toString());
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


  /*static Future<List<FirebaseFile>> listAll(String path) async {
          final ref = FirebaseStorage.instance.ref(path);
          final result = await ref.listAll();

          final urls = await _getDownloadLinks(result.items);

  }*/





}