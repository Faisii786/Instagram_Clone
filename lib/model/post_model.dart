import 'package:cloud_firestore/cloud_firestore.dart';

class postModel {
  final String description;
  final String uid;
  final String postId;
  final String postImage;
  final datetime;
  final likes;
  final String username;
  final String postProfile;

  postModel({
    required this.description,
    required this.uid,
    required this.postId,
    required this.postImage,
    required this.datetime,
    required this.likes,
    required this.username,
    required this.postProfile,
  });

  Map<String, dynamic> toJson() => {
        'description': description,
        'uid': uid,
        'postId': postId,
        'postImage': postImage,
        'datetime': datetime,
        'likes': likes,
        'username' : username,
        'postProfile' : postProfile,
      };

  static postModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return postModel(
        description: snapshot['description'],
        uid: snapshot['uid'],
        postId: snapshot['postId'],
        postImage: snapshot['postImage'],
        datetime: snapshot['datetime'],
        likes: snapshot['likes'],
        username: snapshot['username'],
        postProfile: snapshot['postProfile']
        );
  }
}
