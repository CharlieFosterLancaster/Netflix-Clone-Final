import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/screens/nav_screen.dart';

import '../assets.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {


  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  FirebaseAuth auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {

    Future.delayed(const Duration(seconds: 2), (){

      if(auth.currentUser == null){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      } else{
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NavScreen()),
        );
      }

    });


    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
      body: Center(
        child: Image.asset(Assets.netflixLogo1,),

      ),
    ));
  }
}
