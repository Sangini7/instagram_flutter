import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String username;
  final String uid;
  final String email;
  final String bio;
  final List followers;
  final List following;
  final String photoUrl;
  const User(
      {required this.username,
      required this.uid,
      required this.bio,
      required this.email,
      required this.followers,
      required this.following,
      required this.photoUrl});

  Map<String, dynamic> toJson() => {
        'username': username,
        'uid': uid,
        'email': email,
        'bio': bio,
        'followers': followers,
        'following': following,
        'url': photoUrl,
      };
  //converts document snapshot to user model
  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      username: snapshot['username'],
      uid: snapshot['uid'],
      following: snapshot['following'],
      email: snapshot['email'],
      bio: snapshot['bio'],
      followers: snapshot['followers'],
      photoUrl: snapshot['url'],
    );
  }
}
