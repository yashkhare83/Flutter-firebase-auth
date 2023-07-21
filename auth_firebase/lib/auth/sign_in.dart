// Copyright 2022, the Chromium project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignIn extends StatefulWidget {
  SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // ignore: avoid_init_to_null
  String? mytext = null;

  final DocumentReference documentReference =
      FirebaseFirestore.instance.doc('myData/dummy');

  final FirebaseAuth_auth = FirebaseAuth.instance;

  final GoogleSignIn googleSignIn = new GoogleSignIn();

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    print(credential);
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void _signOut() {
    googleSignIn.signOut();
    print("User Signed out");
  }

  void _add() {
    Map<String, String> data = <String, String>{"name": 'Yash K', "age": '24'};
    documentReference
        .set(data)
        .whenComplete(() => print(data))
        .catchError((err) => print(err));
  }

  void _update() {
    Map<String, String> data = <String, String>{
      "name": 'Yash Khare',
      "Company": 'Dew Solutions'
    };
    documentReference
        .update(data)
        .whenComplete(() => print(data))
        .catchError((err) => print(err));
  }

  void _delete() {
    documentReference.delete().whenComplete(() => {
          setState(() {
            print("Document Deleted");
          })
        });
  }

  void _fetch() {
    documentReference.get().then((datasnapshot) => {
          if (datasnapshot.exists)
            {
              setState(() {
                mytext = (datasnapshot.data() as Map<String, dynamic>)["name"];
              })
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFE1D3FA),
          title: Container(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Text(
              'Flutter Google Authentication',
              style: TextStyle(
                  fontFamily: 'Roboto', fontSize: 24, color: Color(0xFF000000)),
            ),
          ),
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.all(16.0),
          color: Color.fromARGB(255, 214, 250, 211),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 60,
                margin: EdgeInsetsDirectional.only(bottom: 16),
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.green),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                    ),
                    overlayColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.focused))
                        return Color(0xFFE0B6FF);
                      if (states.contains(MaterialState.hovered))
                        return Color(0xFFE0B6FF);
                      if (states.contains(MaterialState.pressed))
                        return Color(0xFFE0B6FF);
                      return null; // Defer to the widget's default.
                    }),
                  ),
                  onPressed: () {
                    // ignore: non_constant_identifier_names
                    signInWithGoogle()
                        .then((UserCredential Credential) => print(Credential));
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
                    child: Text(
                      ' Google Sign In',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 60,
                margin: EdgeInsetsDirectional.only(bottom: 16),
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.red),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                    ),
                    overlayColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.focused))
                        return Color(0xFFE0B6FF);
                      if (states.contains(MaterialState.hovered))
                        return Color(0xFFE0B6FF);
                      if (states.contains(MaterialState.pressed))
                        return Color(0xFFE0B6FF);
                      return null; // Defer to the widget's default.
                    }),
                  ),
                  onPressed: () {
                    _signOut();
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
                    child: Text(
                      'Sign Out',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 60,
                margin: EdgeInsetsDirectional.only(bottom: 16),
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.yellow),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                    ),
                    overlayColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.focused))
                        return Color(0xFFE0B6FF);
                      if (states.contains(MaterialState.hovered))
                        return Color(0xFFE0B6FF);
                      if (states.contains(MaterialState.pressed))
                        return Color(0xFFE0B6FF);
                      return null; // Defer to the widget's default.
                    }),
                  ),
                  onPressed: () {
                    _add();
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
                    child: Text(
                      'Add',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 60,
                margin: EdgeInsetsDirectional.only(bottom: 16),
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                        Color.fromARGB(255, 126, 194, 238)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                    ),
                    overlayColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.focused))
                        return Color(0xFFE0B6FF);
                      if (states.contains(MaterialState.hovered))
                        return Color(0xFFE0B6FF);
                      if (states.contains(MaterialState.pressed))
                        return Color(0xFFE0B6FF);
                      return null; // Defer to the widget's default.
                    }),
                  ),
                  onPressed: () {
                    _update();
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
                    child: Text(
                      'Update',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 60,
                margin: EdgeInsetsDirectional.only(bottom: 16),
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                        Color.fromARGB(255, 224, 116, 21)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                    ),
                    overlayColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.focused))
                        return Color(0xFFE0B6FF);
                      if (states.contains(MaterialState.hovered))
                        return Color(0xFFE0B6FF);
                      if (states.contains(MaterialState.pressed))
                        return Color(0xFFE0B6FF);
                      return null; // Defer to the widget's default.
                    }),
                  ),
                  onPressed: () {
                    _delete();
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
                    child: Text(
                      'Delete',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 60,
                margin: EdgeInsetsDirectional.only(bottom: 16),
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                        Color.fromARGB(255, 247, 57, 175)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                    ),
                    overlayColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.focused))
                        return Color(0xFFE0B6FF);
                      if (states.contains(MaterialState.hovered))
                        return Color(0xFFE0B6FF);
                      if (states.contains(MaterialState.pressed))
                        return Color(0xFFE0B6FF);
                      return null; // Defer to the widget's default.
                    }),
                  ),
                  onPressed: () {
                    _fetch();
                  },
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
                    child: Text(
                      'Fetch',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              mytext == null ? Container() : Text(mytext!),
            ],
          ),
        ));
  }
}
