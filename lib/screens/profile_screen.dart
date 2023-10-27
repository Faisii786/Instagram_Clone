import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/model/user_model.dart' as user_model;
import 'package:instagram_clone/provider/user_provider.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/utills/colors.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    user_model.userModel user = Provider.of<UserProivder>(context).getUser;

    String currentUserId = FirebaseAuth.instance.currentUser!.uid;

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        toolbarHeight: 230,
        backgroundColor: mobileBackgroundColor,
        automaticallyImplyLeading: false,
        title: Text(
          user.name,
          style: const TextStyle(fontSize: 20),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: const Icon(Icons.add_box_outlined),
          ),
          const SizedBox(
            width: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Get.to(() => const LoginScreen());
              },
              child: const Icon(Icons.logout),
            ),
          ),
        ],
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundColor: greyColor,
                        backgroundImage: NetworkImage(user.profilePhotoUrl),
                        radius: 30,
                      ),
                      const Column(
                        children: [
                          Text(
                            "35",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text("Posts"),
                        ],
                      ),
                      const Column(
                        children: [
                          Text(
                            "454",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text("Followers"),
                        ],
                      ),
                      const Column(
                        children: [
                          Text(
                            "134",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text("Following"),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Mr.Editor",
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      const Text(
                        "Kashmiri Boy",
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      const Text(
                        "Photography",
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        user.email,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("posts")
              .where('uid', isEqualTo: currentUserId)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: primaryColor,
                ),
              );
            } else {
              return SizedBox(
                height: double
                    .infinity, // Set a fixed height or use another value that suits your layout
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        snapshot.data!.docs[index]['postImage'],
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              );
            }
          }),
    ));
  }
}
