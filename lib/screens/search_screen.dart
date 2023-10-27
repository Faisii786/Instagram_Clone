import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/utills/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: mobileBackgroundColor,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextFormField(
            decoration: const InputDecoration(
              filled: false,
              hintText: 'Search for a user',
              hintStyle: TextStyle(fontSize: 18),
              fillColor: mobileBackgroundColor,
              border: InputBorder.none,
            ),
          ),
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("posts").snapshots(),
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
                    crossAxisCount: 2,
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
