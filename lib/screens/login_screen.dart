import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/progress_indicators/color_loader_4.dart';
import 'package:netflix_clone/provider/auth_provider.dart';
import 'package:netflix_clone/screens/admin_login.dart';
import 'package:netflix_clone/screens/nav_screen.dart';
import 'package:netflix_clone/screens/signUp_screen.dart';
import 'package:netflix_clone/widgets/responsive.dart';

class LoginScreen extends StatefulWidget {


  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: _MobileLoginScreen(
          backgroundColor1: Color(0xFF000000),
          backgroundColor2: Color(0xFF000000),
          highlightColor: Color(0xFF1DB954),
          foregroundColor: Colors.white,
        ),
        desktop: _DesktopLoginScreen(
          backgroundImgUrl: 'assets/images/login_background_image.jpg',
        )
    );
  }
}

class _MobileLoginScreen extends StatefulWidget {
  final Color backgroundColor1;
  final Color backgroundColor2;
  final Color highlightColor;
  final Color foregroundColor;


  const _MobileLoginScreen({Key? key, required this.backgroundColor1, required this.backgroundColor2, required this.highlightColor, required this.foregroundColor, }) : super(key: key);

  @override
  __MobileLoginScreenState createState() => __MobileLoginScreenState();
}

class __MobileLoginScreenState extends State<_MobileLoginScreen> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  FocusNode _emailTextFieldFocus = FocusNode();
  FocusNode _passwordTextFieldFocus = FocusNode();

  String _emailLabel = "Email";
  String _passwordLabel = "Password";

  bool isLoading = false;
  bool gotError = false;

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
                padding: const EdgeInsets.only(top: 110.0, bottom: 50.0),
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
                          "LOGIN",
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
              new Container(
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
                    new Padding(
                      padding:
                      EdgeInsets.only(top: 10.0, bottom: 10.0, right: 00.0),
                      child: Icon(
                        Icons.alternate_email,
                        color: this.widget.foregroundColor,
                      ),
                    ),
                    new Expanded(
                      child: authTextField(focusNode: _emailTextFieldFocus, label: _emailLabel, controller: _email, ),
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
                    new Padding(
                      padding:
                      EdgeInsets.only(top: 10.0, bottom: 10.0, right: 00.0),
                      child: Icon(
                        Icons.lock_open,
                        color: this.widget.foregroundColor,
                      ),
                    ),
                    new Expanded(
                      child: authTextField(focusNode: _passwordTextFieldFocus, label: _passwordLabel, controller: _password, obscureText: true,),
                    ),
                  ],
                ),
              ),
              (isLoading == true) ? Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Center(child: ColorLoader4(
                  dotOneColor: Colors.pink,
                  dotTwoColor: Colors.amber,
                  dotThreeColor: Colors.deepOrange,
                  duration: Duration(seconds: 1),
                ),),
              ) : Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 30.0),
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
                          AuthClass().signIn(email: _email.text.trim(), password: _password.text.trim()).then((value) {
                            if(value == 'Welcome'){
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => NavScreen()),
                              );
                            }else{
                              setState(() {
                                isLoading = false;

                              });
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid credentials. Check again.'),));

                            }
                          });
                        },
                        child: Text(
                          "Log In",
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
                              MaterialPageRoute(builder: (context) => SignUp()),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account? ",
                                style: TextStyle(color: this.widget.foregroundColor.withOpacity(0.5)),
                              ),
                              Text(
                                'Create One',
                                style: TextStyle(color: this.widget.foregroundColor),
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

class authTextField extends StatelessWidget {


  final FocusNode focusNode;
  final TextEditingController controller;
  final String label;
  final bool obscureText;

  const authTextField({Key? key, required this.focusNode, required this.controller, required this.label, this.obscureText = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      controller: controller,
      obscureText: obscureText, // by default its false
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: label,
        hintStyle: TextStyle(color: Colors.white),
      ),
    );
  }
}




class _DesktopLoginScreen extends StatefulWidget {
  final String backgroundImgUrl;

  const _DesktopLoginScreen({Key? key, required this.backgroundImgUrl}) : super(key: key);


  @override
  __DesktopLoginScreenState createState() => __DesktopLoginScreenState();
}

class __DesktopLoginScreenState extends State<_DesktopLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Row(

          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * 0.7,
              color: Colors.black,
              child: Stack(
                fit: StackFit.expand,
                alignment: Alignment.center,
                children: [
                  Image(
                      image: AssetImage(this.widget.backgroundImgUrl),
                    fit: BoxFit.cover,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'See whats next...',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 48.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * 0.3,
              child: _MobileLoginScreen(
                backgroundColor1: Color(0xFF000000),
                backgroundColor2: Color(0xFF000000),
                highlightColor: Color(0xFF1DB954),
                foregroundColor: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}


