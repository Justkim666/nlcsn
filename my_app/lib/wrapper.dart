import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/screens/register.dart';
import 'package:my_app/screens/signin.dart';
import 'package:my_app/screens/verification.dart';
import 'package:provider/provider.dart';

import 'screens/home.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool showSignIn = false;
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    if (user == null) {
      if (showSignIn) {
        return SignIn(toggleView: toggleView);
      } else {
        return Register(toggleView: toggleView);
      }
    } else {
      if (!user.emailVerified) {
        return Verification(toggleView: toggleView);
      }
      return const Home();
    }
  }
}