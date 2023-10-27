import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/screens/comment_screen.dart';
import 'package:instagram_clone/utills/colors.dart';
import 'package:intl/intl.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({super.key, required this.snap});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool fav = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              CircleAvatar(
                radius: 20,
                backgroundColor: greyColor,
                backgroundImage: NetworkImage(
                  widget.snap['postProfile'] ?? "",
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                widget.snap['username'] ?? "",
                style: const TextStyle(fontSize: 18),
              ),
              Flexible(
                flex: 2,
                child: Container(),
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          // Image(
          //     image: NetworkImage(widget.snap['postImage']
          //         // "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg"
          //         )),
          SizedBox(
            width: double.infinity,
            //height: MediaQuery.of(context).size.height * 0.32,
            child: Image.network(
              widget.snap['postImage'],
              fit: BoxFit.cover,
            ),
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                  onTap: () {
                    fav = true;
                    setState(() {});
                  },
                  child: fav
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : const Icon(
                          Icons.favorite_outline_outlined,
                        )),
              const SizedBox(
                width: 30,
              ),
              GestureDetector(
                  onTap: () {
                    Get.to(() => const CommentScreen());
                  },
                  child: const Icon(Icons.comment)),
              const SizedBox(
                width: 30,
              ),
              GestureDetector(onTap: () {}, child: const Icon(Icons.send)),
              Flexible(
                flex: 2,
                child: Container(),
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.bookmark_border_outlined)),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              '${widget.snap['likes'].length} likes',
              style: const TextStyle(color: greyColor),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: RichText(
                text: TextSpan(
              children: [
                TextSpan(
                  text: widget.snap['username'] ?? "",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                TextSpan(
                  text: " " + widget.snap['description'],
                  style: const TextStyle(fontSize: 17),
                ),
              ],
            )),
          ),
          const SizedBox(
            height: 8,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
                width: double.infinity,
                child: Text(
                  "View all 200 comments",
                  style: TextStyle(color: greyColor),
                )),
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
                width: double.infinity,
                child: Text(
                  DateFormat.yMMMd().format(widget.snap['datetime'].toDate()),
                  style: const TextStyle(color: greyColor),
                )),
          ),
        ],
      ),
    );
  }
}
