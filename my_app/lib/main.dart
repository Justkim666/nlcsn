import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/services/authentication_service.dart';
import 'package:my_app/wrapper.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      catchError: (_, __) => null,
      initialData: null,
      value: AuthenticationService().onAuthStateChanged,
      child: MaterialApp(
        title: "Sneaker Store",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ThemeData()
              .colorScheme
              .copyWith(primary: const Color(0xFFF68A0A)),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            color: Color(0xFFF4F5FC),
            centerTitle: true,
            iconTheme: IconThemeData(color: Colors.black),
            titleTextStyle: TextStyle(
                color: Color(0xFF1A191C),
                fontWeight: FontWeight.bold,
                fontSize: 22,
                fontFamily: "Futura"),
          ),
          scaffoldBackgroundColor: const Color(0xFFF4F5FC),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFFF4F5FC),
              )),
          primaryColor: const Color(0xFFF68A0A),
          fontFamily: "Futura",
        ),
        home: const Wrapper(),
      ),
    );
  }
}