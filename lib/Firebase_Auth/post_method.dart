import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/Firebase_Auth/storage_methods.dart';
import 'package:instagram_clone/model/post_model.dart';
import 'package:uuid/uuid.dart';

class AddPostClass {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future postAddToCloud({
    required String description,
    required Uint8List postImage,
    required String uid,
    required String username,
    required String postProfile,
  }) async {
    try {
      if (description != "") {
        // upload post image to firebase
        String postUrl = await StorageMethods()
            .uploadImageFirebase("Post Images", postImage, true);

        // model
        String postid = const Uuid().v1(); // import from pub.dev uui id package
        postModel postmodel = postModel(
          description: description,
          uid: uid,
          postId: postid,
          postImage: postUrl,
          datetime: DateTime.now(),
          likes: [],
          username: username,
          postProfile: postProfile,
        );
        // add post to firebaseFirestore
        await _firestore.collection("posts").add(postmodel.toJson());
        return 'success';
      } else {
        return 'Please write a caption';
      }
    } on FirebaseAuthException catch (ex) {
      return ex.toString(); // Return the exception message as an error
    } catch (e) {
      return e.toString(); // Return the error message
    }
  }
}
