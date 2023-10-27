import 'package:cloud_firestore/cloud_firestore.dart';

class userModel {
  final String name;
  final String email;
  final String password;
  final String bio;
  final String profilePhotoUrl;
  final List followers;
  final List following;

  userModel({
    required this.name,
    required this.email,
    required this.password,
    required this.bio,
    required this.profilePhotoUrl,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'bio': bio,
        'password': password,
        'profilePhoto': profilePhotoUrl,
        'followers': followers,
        'following': following,
      };

  static userModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return userModel(
      name: snapshot['name'],
      email: snapshot['email'],
      bio: snapshot['bio'],
      password: snapshot['password'],
      profilePhotoUrl: snapshot['profilePhoto'],
      followers: snapshot['followers'],
      following: snapshot['following'],
    );
  }
}
