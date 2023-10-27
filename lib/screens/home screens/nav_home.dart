import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/ui/post_card.dart';
import 'package:instagram_clone/utills/colors.dart';

class NavHomeScreen extends StatelessWidget {
  const NavHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //user_model.userModel user = Provider.of<UserProivder>(context).getUser;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        //toolbarHeight: 140,
        backgroundColor: mobileBackgroundColor,
        automaticallyImplyLeading: false,
        title: SvgPicture.asset(
          "assets/images/ic_instagram.svg",
          color: primaryColor,
          width: 150,
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.chat_bubble_outline))
        ],
        // bottom: PreferredSize(
        //     preferredSize: const Size.fromHeight(0),
        //     child: SizedBox(
        //       height: 60,
        //       child: ListView.builder(
        //           scrollDirection: Axis.horizontal,
        //           itemCount: user.name.length,
        //           itemBuilder: (context, index) {
        //             return Row(
        //               children: [
        //                 Container(
        //                   decoration: BoxDecoration(
        //                       gradient: const LinearGradient(colors: [
        //                         Color.fromARGB(255, 190, 11, 11),
        //                         Color.fromARGB(255, 180, 10, 124),
        //                         Color.fromARGB(255, 194, 176, 16),
        //                       ]),
        //                       borderRadius: BorderRadius.circular(100)),
        //                   height: 60,
        //                   width: 60,
        //                   child: Center(
        //                     child: Text(
        //                       user.bio,
        //                       style: TextStyle(fontSize: 8),
        //                     ),
        //                   ),
        //                 ),
        //               ],
        //             );
        //           }),
        //     )),
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
            } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    //print(snapshot.data!.docs[index].data());
                    return PostCard(
                      snap: snapshot.data!.docs[index].data(),
                    );
                  });
            } else {
              return const Center(
                child: Text(
                  "No post yet\nPlease add post first",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: primaryColor, fontSize: 25),
                ),
              );
            }
          }),
    ));
  }
}
