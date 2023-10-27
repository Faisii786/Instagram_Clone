import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/Firebase_Auth/storage_methods.dart';
import 'package:instagram_clone/screens/home%20screens/home_screen.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/ui/snackbar.dart';
import 'package:instagram_clone/model/user_model.dart' as user_model;

class AuthMethods {
  // firebase instances
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get the user details
  Future<user_model.userModel> getUserDetails() async {
    User _currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection("users").doc(_currentUser.uid).get();

    return user_model.userModel.fromSnap(snap);
  }

  // sign up / create user / registration
  Future signUpUser({
    required String name,
    required String email,
    required String password,
    required String bio,
    required Uint8List profilePhoto,
    // required Uint8List file,
  }) async {
    if (name.isEmpty) {
      showSnackbar("Name cannot be empty");
    } else if (name.isNum) {
      showSnackbar("Name not contain number");
    } else if (email.isEmpty) {
      showSnackbar("Email cannot be empty");
    } else if (password.isEmpty) {
      showSnackbar("Password cannot be empty");
    } else if (password.length < 6) {
      showSnackbar("Password must be at least 6");
    } else if (bio.isEmpty) {
      showSnackbar("Bio cannot be empty");
    } else if (bio.isNum) {
      showSnackbar("Bio not contain number");
    } else {
      try {
        // create the user with email and password
        UserCredential _cred = await _auth.createUserWithEmailAndPassword(
            email: email.toString(), password: password.toString());

        // upload image to firebase
        String profilePhotoUrl = await StorageMethods()
            .uploadImageFirebase("profilePictures", profilePhoto, true);

        // store use data to cloud firestore database
        user_model.userModel _usermodel = user_model.userModel(
            name: name,
            email: email,
            password: password,
            bio: bio,
            profilePhotoUrl: profilePhotoUrl,
            followers: [],
            following: []);

        await _firestore
            .collection('users')
            .doc(_cred.user!.uid)
            .set(_usermodel.toJson());

        // then navigate to login screen if successfull
        Get.to(
          () => const LoginScreen(),
          transition: Transition.fade,
          duration: const Duration(seconds: 1),
        );
      } on FirebaseAuthException catch (e) {
        showSnackbar("An error occurred: ${e.message}");
      } catch (e) {
        showSnackbar(e.toString());
      }
    }
  }

  // login user
  Future userlogin({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty) {
      showSnackbar("Email cannot be empty");
    } else if (password.isEmpty) {
      showSnackbar("Password cannot be empty");
    } else if (password.length < 6) {
      showSnackbar("Password must be at least 6");
    } else {
      try {
        await _auth
            .signInWithEmailAndPassword(
                email: email.toString(), password: password.toString())
            .then((value) {
          Get.to(
            () => const HomeScreen(),
            transition: Transition.fade,
            duration: const Duration(seconds: 1),
          );
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
          showSnackbar("No user found with this address");
        } else if (e.code == 'wrong-password') {
          showSnackbar("Wrong password");
        } else if (e.code == 'invalid-email') {
          showSnackbar("Invalid email address");
        } else {
          showSnackbar("An error occurred: ${e.message}");
        }
      } catch (e) {
        showSnackbar(e.toString());
      }
    }
  }
}
