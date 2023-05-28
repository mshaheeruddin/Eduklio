import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageRepository {

  //upload File
  String downloadURL = "";
  Future uploadFile(PlatformFile? pickedFile) async {
    final path = 'files/${Uuid().v1()}/${pickedFile!.name}';
    final file = File(pickedFile!.path!);
    final ref = FirebaseStorage.instance.ref().child(path);
    UploadTask uploadTask = ref.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask;
    downloadURL = await taskSnapshot.ref.getDownloadURL();
  }

}