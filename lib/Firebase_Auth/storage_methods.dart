import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // add image to firebase storage
  Future<String> uploadImageFirebase(
      String folername, Uint8List file, bool isPost) async {
    Reference ref = _firebaseStorage
        .ref()
        .child(folername)
        .child(_firebaseAuth.currentUser!.uid);

    if (isPost) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }

    // Compress the image using flutter_image_compress
    List<int> compressedImage = await FlutterImageCompress.compressWithList(
      file,
      minHeight: 800,
      minWidth: 600,
      quality: 70,
    );

    UploadTask uploadTask = ref.putData(Uint8List.fromList(compressedImage));
    //UploadTask uploadtask = ref.putData(file);

    TaskSnapshot snapshot = await uploadTask;

    String dowunloadUrl = await snapshot.ref.getDownloadURL();

    return dowunloadUrl;
  }
}
