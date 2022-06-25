import 'dart:typed_data';

import 'package:instagram_flutter/models/user_model.dart' as model;
import 'package:instagram_flutter/resources/storage_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //sign up the user
  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();
    return model.User.fromSnap(snap);
  }

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file, //img
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          username.isNotEmpty &&
          file != null) {
        // file != null) {
        //add user to database

        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);
        model.User user = model.User(
            username: username,
            uid: cred.user!.uid,
            bio: bio,
            email: email,
            followers: [],
            following: [],
            photoUrl: photoUrl);
        _firestore.collection('users').doc(cred.user!.uid).set(user.toJson());
        print(cred.user!.uid);
        res = "success";
      } else {
        res = 'Missing information';
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = 'Enter a valid email';
      } else if (err.code == 'email-already-in-use') {
        res = 'This email has is already in use by another account';
      } else if (err.code == 'weak-password') {
        res = 'Please enter a strong password';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> LoginUser(
      {required String email, required String password}) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      } else {
        res = "please enter all the fields";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
