import 'package:flutter/material.dart';
import 'package:instagram_clone/model/user_model.dart' as user_model;
import 'package:instagram_clone/provider/user_provider.dart';
import 'package:provider/provider.dart';

class CommentCard extends StatefulWidget {
  const CommentCard({super.key});

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    user_model.userModel _user = Provider.of<UserProivder>(context).getUser;
    return Container(
      padding:
          const EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage("assets/images/profile.jpg"),
                radius: 20,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'usernmae ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: 'Some Description to',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  )),
                  const Text("21/12/18"),
                ],
              ),
              Flexible(
                flex: 2,
                child: Container(),
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite_border_outlined,
                    size: 30,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
