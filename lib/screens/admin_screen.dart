import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/screens/add_new_content_screen.dart';
import 'package:netflix_clone/screens/search_content_screen.dart';
import 'package:netflix_clone/screens/update_content_screen.dart';
import 'package:netflix_clone/widgets/custom_app_bar.dart';

class AdminScreen extends StatefulWidget {



  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {



  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _MobileAdminScreen();
  }
}

class _MobileAdminScreen extends StatefulWidget {




  @override
  __MobileAdminScreenState createState() => __MobileAdminScreenState();
}

class __MobileAdminScreenState extends State<_MobileAdminScreen> {



  @override
  Widget build(BuildContext context) {
    return SafeArea(


      child: Stack(
        children: [

          Image.asset(
            "assets/images/background.jpg",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),

          Scaffold(
            extendBodyBehindAppBar: false,

              appBar: PreferredSize(
                  preferredSize: Size(MediaQuery.of(context).size.width, 50.0),
                  child: CustomAppBar2()

              ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Welcome to Admin Panel',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w300,
                          ),
                        ),

                      ],
                    ),

                    SizedBox(height: 40.0,),

                    Align(
                      alignment: Alignment.center,
                      child: Wrap(

                        children: [

                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: FlatButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => AddNewContentScreen()),
                                );
                              },
                              child: Container(
                                height: 250.0,
                                width: 250.0,

                                decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    'Add new content',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: FlatButton(
                              onPressed: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => SearchContentScreen()));
                              },
                              child: Container(
                                height: 250.0,
                                width: 250.0,

                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    'Update content',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),








                        ],
                      ),
                    ),


                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

