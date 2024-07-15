import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instaudemy/models/user.dart' as model;
import 'package:instaudemy/resources/storage_methods.dart';
//import 'package:firebase_storage/firebase_storage.dart';
//import 'package:flutter/material.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Future<model.User> getUserdetails() async {
  //   User currentUser = _auth.currentUser!;

  //   DocumentSnapshot snap =
  //       await _firestore.collection('users').doc(_auth.currentUser!.uid).get();
  //   return model.User.fromsnap(snap);
  // }

//Sign Up
  Future<String> signUpUser(
      {required String email,
      required String password,
      required String username,
      required String bio,
      required Uint8List file}) async {
    String res = "success";
    try {
      //registration of user
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          username.isNotEmpty &&
          bio.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        String picurl = await StorageMethods()
            .uploadImageToStorage('profilepics', file, false);

        model.User user = model.User(
            email: email,
            uid: cred.user!.uid,
            photourl: picurl,
            username: username,
            bio: bio,
            followers: [],
            following: [],
            posts: []);
        //add data in cloud firestore
        await _firestore
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .set(user.toJson());
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //sign in
  Future<String> LogInUser(
      {required String email, required String password}) async {
    String res = "Some error occurred";
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //signout
  Future<String> signout() async {
    String res = "error";
    await FirebaseAuth.instance.signOut();
    res = "success";
    return res;
  }
}
