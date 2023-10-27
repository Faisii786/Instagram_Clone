// ignore_for_file: prefer_final_fields

import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/Firebase_Auth/post_method.dart';
import 'package:instagram_clone/model/user_model.dart' as user_model;
import 'package:instagram_clone/provider/user_provider.dart';
import 'package:instagram_clone/utills/colors.dart';
import 'package:instagram_clone/utills/image_picker.dart';
import 'package:instagram_clone/ui/snackbar.dart';
import 'package:provider/provider.dart';

class SelectImage extends StatefulWidget {
  const SelectImage({super.key});

  @override
  State<SelectImage> createState() => _SelectImageState();
}

class _SelectImageState extends State<SelectImage> {
  // linear progress indicator
  bool isloading = false;

  // global variable for image picker
  Uint8List? _galleryImage;

  // select image from gallery
  void selectImageFromGallery() async {
    Uint8List? img = await pickImage(ImageSource.gallery);
    setState(() {
      _galleryImage = img;
    });
  }

  // select image from camera
  void selectImageFromCamera() async {
    Uint8List? img = await pickImage(ImageSource.camera);
    setState(() {
      _galleryImage = img;
    });
  }

  // Dialog box
  void _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text(
              "Create a Post",
              style: TextStyle(fontSize: 20),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: SimpleDialogOption(
                  child: const Text(
                    "Take a photo",
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    selectImageFromCamera();
                  },
                ),
              ),
              SimpleDialogOption(
                child: const Text(
                  "Choose from Gallery",
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  selectImageFromGallery();
                },
              ),
            ],
          );
        });
  }

  TextEditingController _postController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _postController.dispose();
  }

  void addPostAndImageToFireBase(
      String uid, String username, String postProfile) async {
    setState(() {
      isloading = true;
    });
    String res = await AddPostClass().postAddToCloud(
        description: _postController.text,
        postImage: _galleryImage!,
        uid: uid,
        username: username,
        postProfile: postProfile);

    if (res == 'success') {
      showSnackbar("Post Added Successfully");
    } else {
      showSnackbar(res); // Show the error message
    }

    setState(() {
      isloading = false;
    });
  }

  // use ternary operator
  // when image == null > show the upload icon
  // when image !=null > show the post screen
  @override
  Widget build(BuildContext context) {
    user_model.userModel user = Provider.of<UserProivder>(context).getUser;
    return _galleryImage == null
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  _selectImage(context);
                },
                child: Image.asset(
                  'assets/images/add_post.png',
                  width: 80,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Add Post",
                style: GoogleFonts.alatsi(fontSize: 18),
              ),
            ],
          )
        : SafeArea(
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: mobileBackgroundColor,
                  title: const Text("Post to"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          addPostAndImageToFireBase(
                            FirebaseAuth.instance.currentUser!.uid,
                            user.name,
                            user.profilePhotoUrl,
                          );
                        },
                        child: const Text(
                          "Post",
                          style: TextStyle(fontSize: 16),
                        ))
                  ],
                ),
                body: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        isloading
                            ? const LinearProgressIndicator(
                                color: Colors.green,
                                minHeight: 2,
                              )
                            : Container(),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: greyColor,
                              backgroundImage:
                                  NetworkImage(user.profilePhotoUrl),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextField(
                                maxLength: 100,
                                controller: _postController,
                                decoration: InputDecoration(
                                  hintText: 'Write a caption...',
                                  //filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide.none),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Image(
                          image: MemoryImage(_galleryImage!),
                        ),
                      ],
                    ),
                  ),
                )));
  }
}
