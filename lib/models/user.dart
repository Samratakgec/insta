//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String photourl;
  final String username;
  final String bio;
  final List followers;
  final List following;
  final List posts;

  const User(
      {required this.email,
      required this.uid,
      required this.photourl,
      required this.username,
      required this.bio,
      required this.followers,
      required this.following,
      required this.posts});

  Map<String, dynamic> toJson() => {
        'username': username,
        'uid': uid,
        'email': email,
        'bio': bio,
        'followers': [],
        'following': [],
        'photourl': photourl,
        'posts': []
      };
  // static User fromsnap(DocumentSnapshot snap) {
  //   var snapshot = snap.data() as Map<String, dynamic>;
  //   return User(
  //       email: snapshot['email'],
  //       uid: snapshot['uid'],
  //       photourl: snapshot['photourl'],
  //       username: snapshot['username'],
  //       bio: snapshot['bio'],
  //       followers: snapshot['followers'],
  //       following: snapshot['following']);
  // }
}
