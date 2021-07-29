import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/Database/DatabaseManager.dart';
import 'package:netflix_clone/provider/auth_provider.dart';
import 'package:netflix_clone/screens/home_screen.dart';
import 'package:netflix_clone/screens/login_screen.dart';
import 'package:netflix_clone/screens/nav_screen.dart';
import 'package:netflix_clone/widgets/responsive.dart';

import 'admin_login.dart';

class SignUp extends StatefulWidget {


  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {

    return Responsive(
        mobile: _MobileSignUpScreen(
          backgroundColor1: Color(0xFF000000),
          backgroundColor2: Color(0xFF000000),
          highlightColor: Color(0xFF1DB954),
          foregroundColor: Colors.white,
        ),
        desktop: _DesktopSignUpScreen(
          backgroundImgUrl: 'assets/images/admin_login_background.jpg',
          backgroundColor1: Color(0xFF000000),
          backgroundColor2: Color(0xFF000000),
          highlightColor: Color(0xFF1DB954),
          foregroundColor: Colors.white,
          textFieldBackground: Color(0xFF3A3737),
        )
    );
  }
}


class _MobileSignUpScreen extends StatefulWidget {
  final Color backgroundColor1;
  final Color backgroundColor2;
  final Color highlightColor;
  final Color foregroundColor;


  const _MobileSignUpScreen({Key? key, required this.backgroundColor1, required this.backgroundColor2, required this.highlightColor, required this.foregroundColor}) : super(key: key);



  @override
  __MobileSignUpScreenState createState() => __MobileSignUpScreenState();
}

class __MobileSignUpScreenState extends State<_MobileSignUpScreen> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();
  TextEditingController _fullName = TextEditingController();
  TextEditingController _mobileNo = TextEditingController();

  FocusNode _emailTextFieldFocus = FocusNode();
  FocusNode _passwordTextFieldFocus = FocusNode();
  FocusNode _confirmPasswordTextFieldFocus = FocusNode();
  FocusNode _fullNameTextFieldFocus = FocusNode();
  FocusNode _mobileNoTextFieldFocus = FocusNode();

  String _emailLabel = "Email";
  String _passwordLabel = "Password";
  String _confirmPasswordLabel = "Confirm Password";
  String _fullNameLabel = "Full Name";
  String _mobileNoLabel = "Mobile No";



  bool isLoading = false;

  @override
  void initState() {
    _emailTextFieldFocus.addListener((){
      if(_emailTextFieldFocus.hasFocus){
        setState(() {
          _emailLabel = "";
        });
      }else{
        setState(() {
          _emailLabel = "Email";
        });
      }
    });

    _passwordTextFieldFocus.addListener((){
      if(_passwordTextFieldFocus.hasFocus){
        setState(() {
          _passwordLabel = "";
        });
      }else{
        setState(() {
          _passwordLabel = "Password";
        });
      }
    });

    _confirmPasswordTextFieldFocus.addListener((){
      if(_confirmPasswordTextFieldFocus.hasFocus){
        setState(() {
          _confirmPasswordLabel = "";
        });
      }else{
        setState(() {
          _confirmPasswordLabel = "Confirm Password";
        });
      }
    });

    _fullNameTextFieldFocus.addListener((){
      if(_fullNameTextFieldFocus.hasFocus){
        setState(() {
          _fullNameLabel = "";
        });
      }else{
        setState(() {
          _fullNameLabel = "Full Name";
        });
      }
    });

    _mobileNoTextFieldFocus.addListener((){
      if(_mobileNoTextFieldFocus.hasFocus){
        setState(() {
          _mobileNoLabel = "";
        });
      }else{
        setState(() {
          _mobileNoLabel = "Mobile No";
        });
      }
    });

    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              begin: Alignment.centerLeft,
              end: new Alignment(1.0, 0.0), // 10% of the width, so there are ten blinds.
              colors: [this.widget.backgroundColor1, this.widget.backgroundColor2], // whitish to gray
              tileMode: TileMode.repeated, // repeats the gradient over the canvas
            ),
          ),
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Center(
                  child: new Column(
                    children: <Widget>[
                      Container(
                          height: 120.0,
                          width: 200.0,
                          color: Colors.black.withOpacity(0.5),
                          child: Image(image: AssetImage('assets/images/netflix_logo1.png'))
                      ),
                      new Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: new Text(
                          "SIGN UP",
                          style: TextStyle(
                            color: this.widget.foregroundColor,
                            fontSize: 24.0,

                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 40.0, right: 40.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        color: this.widget.foregroundColor,
                        width: 0.5,
                        style: BorderStyle.solid),
                  ),
                ),
                padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[

                    new Expanded(
                      child: authTextField(focusNode: _fullNameTextFieldFocus, label: _fullNameLabel, controller: _fullName, ),
                    ),
                  ],
                ),
              ),

              new Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        color: this.widget.foregroundColor,
                        width: 0.5,
                        style: BorderStyle.solid),
                  ),
                ),
                padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[

                    new Expanded(
                      child: authTextField(focusNode: _mobileNoTextFieldFocus, label: _mobileNoLabel, controller: _mobileNo, ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 40.0, right: 40.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        color: this.widget.foregroundColor,
                        width: 0.5,
                        style: BorderStyle.solid),
                  ),
                ),
                padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[

                    new Expanded(
                      child: authTextField(focusNode: _emailTextFieldFocus, label: _emailLabel, controller: _email, ),                      
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 40.0, right: 40.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        color: this.widget.foregroundColor,
                        width: 0.5,
                        style: BorderStyle.solid),
                  ),
                ),
                padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[

                    new Expanded(
                      child: authTextField(focusNode: _passwordTextFieldFocus, label: _passwordLabel, controller: _password, obscureText: true,),                      
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 40.0, right: 40.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        color: this.widget.foregroundColor,
                        width: 0.5,
                        style: BorderStyle.solid),
                  ),
                ),
                padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[

                    new Expanded(
                      child: authTextField(focusNode: _confirmPasswordTextFieldFocus, label: _confirmPasswordLabel, controller: _confirmPassword, obscureText: true, ),                      
                    ),
                  ],
                ),
              ),
              new Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 30.0),
                alignment: Alignment.center,
                child: new Row(
                  children: <Widget>[
                    (isLoading == true) ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(child: CircularProgressIndicator(),),
                      ],
                    ) : Expanded(
                      child:  FlatButton(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20.0),
                        color: this.widget.highlightColor,
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                          });
                          if(_password.text.trim() == _confirmPassword.text.trim() && _fullName.text.trim() != '' && _mobileNo.text.trim() != '' && _email.text.trim() != '' && _password.text.trim() != ''){
                            AuthClass().createAccount(
                                email: _email.text.trim(),
                                password: _password.text.trim()
                            ).then((value) {
                              if(value == "Account created"){
                                setState(() {
                                  isLoading = false;
                                });
                                DatabaseManager().storeUserInfo(_fullName.text.trim(), _email.text.trim(), _mobileNo.text.trim());
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Account created.'),));
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => NavScreen()),
                                );
                              }else if(value == "The account already exists for that email."){
                                setState(() {
                                  isLoading = false;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Email already exists. Try again.'),));

                              } else{
                                setState(() {
                                  isLoading = false;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Some error occurred'),));

                              }
                            });
                          } else{
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please check details again'),));
                          }

                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(color: this.widget.foregroundColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),







              new Expanded(child: Divider(),),

              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: new Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0, bottom: 0.0),
                  alignment: Alignment.center,
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new FlatButton(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 20.0),
                          color: Colors.transparent,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LoginScreen()),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account? ",
                                style: TextStyle(color: this.widget.foregroundColor.withOpacity(0.5)),
                              ),
                              Text(
                                'Login',
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class _DesktopSignUpScreen extends StatefulWidget {
  final String backgroundImgUrl;
  final Color backgroundColor1;
  final Color backgroundColor2;
  final Color highlightColor;
  final Color foregroundColor;
  final Color textFieldBackground;

  const _DesktopSignUpScreen({Key? key, required this.backgroundImgUrl, required this.backgroundColor1, required this.backgroundColor2, required this.highlightColor, required this.foregroundColor, required this.textFieldBackground}) : super(key: key);





  @override
  __DesktopSignUpScreenState createState() => __DesktopSignUpScreenState();
}

class __DesktopSignUpScreenState extends State<_DesktopSignUpScreen> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();
  TextEditingController _fullName = TextEditingController();
  TextEditingController _mobileNo = TextEditingController();

  bool isLoading = false;





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( 
        child: Stack( 

          alignment: Alignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image(
                image: AssetImage(this.widget.backgroundImgUrl),
                fit: BoxFit.cover,
              ),
            ),
            Container( 
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.black.withOpacity(0.5),
            ),
            Container(
              height: 650.0,
              width: 900.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.8),
                    Colors.black.withOpacity(0.8),
                  ]

                )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40.0),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 48.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Row(

                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      Expanded(

                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                          child: TextField(
                            controller: _fullName,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: this.widget.textFieldBackground,
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(20.0),
                                ),
                              ),
                              hintText: 'Full Name',
                              hintStyle: TextStyle(color: this.widget.foregroundColor),

                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: 40.0,),

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                          child: TextField(
                            controller: _mobileNo,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: this.widget.textFieldBackground,
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(20.0),
                                ),
                              ),
                              hintText: 'Mobile No. ',
                              hintStyle: TextStyle(color: this.widget.foregroundColor),


                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Row(

                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      Expanded(

                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                          child: TextField(
                            controller: _password,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: this.widget.textFieldBackground,
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(20.0),
                                ),
                              ),
                              hintText: 'Password',
                              hintStyle: TextStyle(color: this.widget.foregroundColor),

                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: 40.0,),

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                          child: TextField(
                            controller: _confirmPassword,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: this.widget.textFieldBackground,
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(20.0),
                                ),
                              ),
                              hintText: 'Confirm Password',
                              hintStyle: TextStyle(color: this.widget.foregroundColor),


                            ),
                          ),
                        ),
                      ),
                    ],
                  ),


                  Row(

                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      Expanded(

                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                          child: TextField(
                            controller: _email,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: this.widget.textFieldBackground,
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(20.0),
                                ),
                              ),
                              hintText: 'Email Address',
                              hintStyle: TextStyle(color: this.widget.foregroundColor),

                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 20.0,),
                  (isLoading == true) ? Center(child: CircularProgressIndicator(),) : new Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 30.0,bottom: 20.0),
                    alignment: Alignment.center,
                    child: new Row(
                      children: <Widget>[
                        new Expanded(
                          child: new FlatButton(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 20.0),
                            color: this.widget.highlightColor,
                            onPressed: () {
                              setState(() {
                                isLoading = true;
                              });
                              if(_password.text.trim() == _confirmPassword.text.trim() && _fullName.text.trim() != '' && _mobileNo.text.trim() != '' && _email.text.trim() != '' && _password.text.trim() != ''){
                                AuthClass().createAccount(
                                    email: _email.text.trim(),
                                    password: _password.text.trim()
                                ).then((value) {
                                  if(value == "Account created"){
                                    setState(() {
                                      isLoading = false;
                                    });
                                    DatabaseManager().storeUserInfo(_fullName.text.trim(), _email.text.trim(), _mobileNo.text.trim());
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Account created.'),));
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => HomeScreen()),
                                    );
                                  } else if(value == "The account already exists for that email."){
                                    setState(() {
                                      isLoading = false;
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Email already exists. Try again.'),));

                                  } else{
                                    setState(() {
                                      isLoading = false;
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Some error occurred'),));

                                  }
                                });
                              } else{
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please check details again'),));
                              }

                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(color: this.widget.foregroundColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0, bottom: 0.0),
                    alignment: Alignment.center,
                    child: new Row(
                      children: <Widget>[
                        new Expanded(
                          child: new FlatButton(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 20.0),
                            color: Colors.transparent,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LoginScreen()),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account? ",
                                  style: TextStyle(color: this.widget.foregroundColor.withOpacity(0.5)),
                                ),
                                Text(
                                  'Login',
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),

            )
          ],
        )
      ),
    );
  }
}

