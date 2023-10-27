import 'package:flutter/material.dart';
import 'package:instagram_clone/model/user_model.dart' as user_model;
import 'package:instagram_clone/provider/user_provider.dart';
import 'package:instagram_clone/ui/comment_card.dart';
import 'package:instagram_clone/utills/colors.dart';
import 'package:provider/provider.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({super.key});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  @override
  Widget build(BuildContext context) {
    user_model.userModel user = Provider.of<UserProivder>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text("Comments"),
      ),
      body: const CommentCard(),
      bottomNavigationBar: BottomAppBar(
        color: mobileBackgroundColor,
        //   child: ListTile(
        //     leading: const CircleAvatar(
        //       backgroundColor: greyColor,
        //       radius: 20,
        //     ),
        //     title: Expanded(
        //       child: TextFormField(
        //         keyboardType: TextInputType.text,
        //         decoration: const InputDecoration(
        //           hintText: 'Comment as Faisal',
        //           border: InputBorder.none,
        //         ),
        //       ),
        //     ),
        //     trailing: TextButton(onPressed: () {}, child: const Text("Post")),
        //   ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  user.profilePhotoUrl,
                ),
                radius: 20,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: TextFormField(
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: 'Comment as Faisal',
                  border: InputBorder.none,
                ),
              )),
              TextButton(onPressed: () {}, child: const Text("Post")),
            ],
          ),
        ),
      ),
    );
  }
}
