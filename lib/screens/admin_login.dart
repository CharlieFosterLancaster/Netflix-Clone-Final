import 'package:flutter/material.dart';
import 'package:netflix_clone/screens/login_screen.dart';
import 'package:netflix_clone/widgets/responsive.dart';

class AdminLogin extends StatefulWidget {


  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: _MobileLoginScreen(
          backgroundColor1: Color(0xFF000000),
          backgroundColor2: Color(0xFF000000),
          highlightColor: Color(0xFF1DB954),
          foregroundColor: Colors.white,
          logo: AssetImage('assets/images/netflix_logo0.png'),
        ),
        desktop: _DesktopLoginScreen(
          background_image_url: 'assets/images/admin_login_background.jpg',
        )
    );
  }
}

class _MobileLoginScreen extends StatelessWidget {
  final Color backgroundColor1;
  final Color backgroundColor2;
  final Color highlightColor;
  final Color foregroundColor;
  final AssetImage logo;

  const _MobileLoginScreen({Key? key, required this.backgroundColor1, required this.backgroundColor2, required this.highlightColor, required this.foregroundColor, required this.logo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              begin: Alignment.centerLeft,
              end: new Alignment(1.0, 0.0), // 10% of the width, so there are ten blinds.
              colors: [this.backgroundColor1, this.backgroundColor2], // whitish to gray
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
                          "ADMIN LOGIN",
                          style: TextStyle(
                            color: this.foregroundColor,
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
                        color: this.foregroundColor,
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
                        color: this.foregroundColor,
                      ),
                    ),
                    new Expanded(
                      child: TextField(
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                          hintStyle: TextStyle(color: this.foregroundColor),

                        ),
                      ),
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
                        color: this.foregroundColor,
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
                        color: this.foregroundColor,
                      ),
                    ),
                    new Expanded(
                      child: TextField(
                        obscureText: true,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                          hintStyle: TextStyle(color: this.foregroundColor),
                        ),
                      ),
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
                    new Expanded(
                      child: new FlatButton(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20.0),
                        color: this.highlightColor,
                        onPressed: () => {},
                        child: Text(
                          "Log In",
                          style: TextStyle(color: this.foregroundColor),
                        ),
                      ),
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
                    new Expanded(
                      child: new FlatButton(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20.0),
                        color: Colors.blueAccent,
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                          );
                        },
                        child: Text(
                          "Go to Customer Log In",
                          style: TextStyle(color: this.foregroundColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),



              new Expanded(child: Divider(),),


            ],
          ),
        ),
      ),
    );;
  }
}




class _DesktopLoginScreen extends StatefulWidget {
  final String background_image_url;

  const _DesktopLoginScreen({Key? key, required this.background_image_url}) : super(key: key);


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
                    image: AssetImage(this.widget.background_image_url),
                    fit: BoxFit.cover,
                  ),

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
                logo: AssetImage('assets/images/netflix_logo0.png'),

              ),
            )
          ],
        ),
      ),
    );
  }
}
