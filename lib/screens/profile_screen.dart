import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/progress_indicators/color_loader_4.dart';
import 'package:netflix_clone/provider/auth_provider.dart';
import 'package:netflix_clone/widgets/custom_app_bar.dart';

import '../assets.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {


  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return _MobileProfileScreen();
  }
}

class _MobileProfileScreen extends StatefulWidget {



  @override
  __MobileProfileScreenState createState() => __MobileProfileScreenState();
}

class __MobileProfileScreenState extends State<_MobileProfileScreen> {
  String dispName = "";
  String email = "";
  bool isAdmin = false;
  String mobileNo = "";
  bool userInfoLoaded = false;

  Future<void> getUserEmail() async{
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    FirebaseAuth auth = FirebaseAuth.instance;
    setState(() {
      email = auth.currentUser!.email.toString();
    });
  }


  Future<void> getUserInfo(String email) async{
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    var query = await users.where('email', isEqualTo: email).get();
    if(query != null){
      var snapshot = query.docs[0]['email'];
      setState(() {
        dispName = query.docs[0]['dispName'];
        isAdmin = query.docs[0]['isAdmin'];
        mobileNo = query.docs[0]['mobileNo'];
        userInfoLoaded = true;
      });
      print(dispName);
      print(isAdmin);
      print(mobileNo);


      }

    else{
      print("Data not found");
    }


  }

  @override
  void initState() {
    getUserEmail();
    getUserInfo(email);
    super.initState();
  }


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
                child: Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    width: (MediaQuery.of(context).size.width > 800) ? MediaQuery.of(context).size.width * 0.6 : MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0,vertical: 40.0),
                      child: (userInfoLoaded == false) ? Center(child: ColorLoader4(
                        dotOneColor: Colors.pink,
                        dotTwoColor: Colors.amber,
                        dotThreeColor: Colors.deepOrange,
                        duration: Duration(seconds: 1),
                      ),) : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [

                          Image.asset(Assets.netflixLogo1),

                          SizedBox(height: 40.0,),

                          (isAdmin == false) ? SizedBox(height: 10.0,) : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Admin',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 24.0,
                                ),
                              ),
                              SizedBox(width: 5.0,),
                              Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 32.0,
                              )
                            ],
                          ),

                          SizedBox(
                            height: 40.0,
                          ),


                          ProfileFields(heading: 'Name', value: dispName,),
                          SizedBox(height: 10.0,),
                          ProfileFields(heading: 'Email', value: email,),
                          SizedBox(height: 10.0,),
                          ProfileFields(heading: 'Mobile', value: mobileNo,),
                          SizedBox(height: 40,),




                          SizedBox(
                            height: 40.0,
                          ),



                          FlatButton(
                            child: Text('Logout'),
                            color: Colors.white,
                            onPressed: () {
                              AuthClass().signOut();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => LoginScreen()),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                )
            ),

          )
        ],

      ),
    );
  }
}

class ProfileFields extends StatelessWidget {
  final String heading;
  final String? value;

  const ProfileFields({Key? key, required this.heading, this.value}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Text(
            '$heading: ',
            textAlign: TextAlign.left,
            style: TextStyle(

              color: Colors.grey,
              fontSize: 18.0,
            ),
          ),
          // SizedBox(width: 20.0,),

          Flexible(
              child: SelectableText(
                  '$value',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              )
          )
        ],
      ),
    );
  }
}

