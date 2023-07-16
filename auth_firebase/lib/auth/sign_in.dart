// Copyright 2022, the Chromium project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
// import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});
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
          color: Color(0xFFE1D3FA),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 60,
                margin: EdgeInsetsDirectional.only(bottom: 16),
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.white),
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
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 60,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.white),
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
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
