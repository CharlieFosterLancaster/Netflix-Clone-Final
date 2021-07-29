import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/screens/admin_login.dart';
import 'package:netflix_clone/screens/home_screen.dart';
import 'package:netflix_clone/screens/login_screen.dart';
import 'package:netflix_clone/screens/nav_screen.dart';
import 'package:netflix_clone/screens/signUp_screen.dart';
import 'package:netflix_clone/screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Netflix UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.transparent,

        highlightColor: Colors.black,
      ),
      // home: NavScreen(),
      home: SplashScreen2(),
    );
  }
}

class SplashScreen2 extends StatefulWidget {


  @override
  _SplashScreen2State createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<SplashScreen2> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          print("Connection error");
          return Container(
            color: Colors.red,
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          print("Connection successful");
          return SplashScreen();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

