import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

User? currUser = FirebaseAuth.instance.currentUser;
signupUser(
    String email, String password, String name, BuildContext context) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    Navigator.pop(context);
    await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
    await FirebaseAuth.instance.currentUser!.updateEmail(email);
    await saveuserdata(email, password, name);

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Registration Successful')));
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Password Provided is too weak')));
    } else if (e.code == 'email-already-in-use') {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Email Provided already Exists')));
    }
  } catch (e) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(e.toString())));
  }
}

signinUser(String email, String password, BuildContext context) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    Navigator.pop(context);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('You are Logged in')));
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No user Found with this Email')));
    } else if (e.code == 'wrong-password') {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Password did not match')));
    }
  }
}

saveuserdata(
  String email,
  String password,
  String name,
) async {
  await FirebaseFirestore.instance.collection('users').doc(currUser!.uid).set({
    'email': email,
    'username': name,
    'uid': currUser!.uid,
  });
}

submitDecision(String title, Map pollWeights) async {
  await FirebaseFirestore.instance.collection('decisions').add({
    'uid': currUser!.uid,
    'title': title,
    'usersWhoVoted': {},
    'pollWeights': pollWeights
  });
}
