import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:project_nlcsn/screens/home_page.dart';
// import 'package:project_nlcsn/screens/login.dart';
import 'package:project_nlcsn/screens/splash_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFFFFFFF),
      ),
      home: const LoadingScreen(),
    );
  }
}