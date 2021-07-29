import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/data/data.dart';
import 'package:netflix_clone/models/content_model.dart';
import 'package:netflix_clone/progress_indicators/color_loader_4.dart';
import 'package:netflix_clone/screens/admin_screen.dart';
import 'package:netflix_clone/widgets/content_header.dart';
import 'package:netflix_clone/widgets/content_list.dart';
import 'package:netflix_clone/widgets/custom_app_bar.dart';
import 'package:netflix_clone/widgets/previews.dart';
import 'package:google_fonts/google_fonts.dart';





class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}): super(key: key);



  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;
  double _scrollOffset = 0.0;

  String dispName = "";
  String email = "";
  bool isAdmin = false;
  String mobileNo = "";
  List<Content> firebase_watchList = [];
  List<Content> firebase_previews = [];
  List<Content> firebase_originals = [];
  List<Content> firebase_big_preview = [];
  List<Content> firebase_classics = [];
  List<dynamic> watchListIds = [];






  bool userInfoLoaded = false;
  bool isWatchListLoaded = false;

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
        watchListIds = query.docs[0]['watchList'];
        userInfoLoaded = true;
      });
      print(dispName);
      print(isAdmin);
      print(mobileNo);
      print(watchListIds);

      print(watchListIds);
      if(watchListIds.length > 0){

        for(int j =0; j<watchListIds.length; j++){
          print("Adding to watchlist");
          print(watchListIds[j]);
          QuerySnapshot querySnapshot2 = await FirebaseFirestore.instance.collection(
              'Content').where('id', isEqualTo: watchListIds[j]).get();


          final List allData2 = querySnapshot2.docs.map((doc) => doc.data()).toList();
          for(int i = 0; i < allData2.length; i++){
            Map<String, dynamic> values = Map<String, dynamic>.from(allData2[i]);
            firebase_watchList.add(
                Content(
                  name: values['contentName'],
                  imageUrl: values['imgUrl'],
                  // titleImageUrl: values['titleImgUrl'],
                  description: values['description'],
                  videoUrl: values['videoUrl'],
                  id: values['id'],
                  views: values['views'],
                )
            );


          }





        }
        setState(() {
          isWatchListLoaded = true;
        });
        print(firebase_watchList[0].name);

      } else{
        setState(() {
          isWatchListLoaded = true;
        });
      }


      // var data = snapshot.data();
      // print(data);


    }else{
      print("Data not found");
    }


  }


  getContent() async{
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Content').get();

    final List allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    for(int i = 0; i < allData.length; i++){
      Map<String, dynamic> values = Map<String, dynamic>.from(allData[i]);
      print(values['typeOfContent']);
      if(values['typeOfContent'] == 'Previews'){
        firebase_previews.add(
            Content(
                name: values['contentName'],
                imageUrl: values['imgUrl'],
              // titleImageUrl: values['titleImgUrl'],
              description: values['description'],
              videoUrl: values['videoUrl'],
              id: values['id'],
              views: values['views'],
            )
        );



      }else if(values['typeOfContent'] == 'Originals'){
        firebase_originals.add(
            Content(
              name: values['contentName'],
              imageUrl: values['imgUrl'],
              //titleImageUrl: values['titleImgUrl'],
              description: values['description'],
              videoUrl: values['videoUrl'],
              id: values['id'],
              views: values['views'],
            )
        );

      }else if(values['typeOfContent'] == 'BigPreview'){

        firebase_big_preview.add(
            Content(
              name: values['contentName'],
              imageUrl: values['imgUrl'],
              //titleImageUrl: values['titleImgUrl'],
              description: values['description'],
              videoUrl: values['videoUrl'],
              id: values['id'],
              views: values['views'],
            )
        );

      }else if(values['typeOfContent'] == 'Classics'){
        firebase_classics.add(
            Content(
              name: values['contentName'],
              imageUrl: values['imgUrl'],
              //titleImageUrl: values['titleImgUrl'],
              description: values['description'],
              videoUrl: values['videoUrl'],
              id: values['id'],
              views: values['views'],
            )
        );
      }

    }

    print(firebase_previews[0].name);





    // var snapshot = await FirebaseFirestore.instance.collection('Content').get();
    // snapshot.docs.map((doc) => print(doc.data()));


    // print(snapshot.docs.map((doc) {
    //   doc.data();
    // } ));
      // print(doc.data()['contentName']);
      // contentData.add(Content(name: doc.data()['contentName'], imageUrl: doc.data()['imgUrl']));



    // x.toList();
    // print(x);
    // print(x.runtimeType);
    // return snapshot.docs.map((doc) => doc.data());


    // if(query != null){
    //   var snapshot = query.docs[0]['email'];
    //   setState(() {
    //     dispName = query.docs[0]['dispName'];
    //     isAdmin = query.docs[0]['isAdmin'];
    //     mobileNo = query.docs[0]['mobileNo'];
    //     watchList = query.docs[0]['watchList'];
    //     userInfoLoaded = true;
    //   });
    //   print(dispName);
    //   print(isAdmin);
    //   print(mobileNo);
    //   print(watchList);


    //}


  }

  //get content ids from watchlist
  // getWatchListContentIds(String email) async{
  //   await FirebaseFirestore.instance.collection('Users').doc(email).get().then((value) {
  //     List.from(value.data()!['watchList']).forEach((element) {
  //       String data = element.toString();
  //       watchListIds.add(data);
  //     });
  //   });
  //   print("Watchlist ids fetched");
  //   print(watchListIds);
  //
  // }

  //get content from id
  // getContentFromId(String id) async{
  //   QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection(
  //       'Content').where('id', isEqualTo: id).get();
  //
  //
  //   final List allData = querySnapshot.docs.map((doc) => doc.data()).toList();
  //   for(int i = 0; i < allData.length; i++){
  //     Map<String, dynamic> values = Map<String, dynamic>.from(allData[i]);
  //     firebase_watchList.add(
  //       Content(
  //         name: values['contentName'],
  //         imageUrl: values['imgUrl'],
  //         // titleImageUrl: values['titleImgUrl'],
  //         description: values['description'],
  //         videoUrl: values['videoUrl'],
  //         id: values['id'],
  //         views: values['views'],
  //       )
  //     );
  //
  //
  //   }
  // }
  //
  // //store content in watch list
  // storeContentInWatchList(List watchListIds) async{
  //   for(int i = 0; i < watchListIds.length; i++){
  //     getContentFromId(watchListIds[i]);
  //   }
  //   setState(() {
  //     isWatchListLoaded = true;
  //   });
  //   print(firebase_watchList);
  // }





  @override
  void initState() {
    _scrollController = ScrollController()..addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
    });
    getUserEmail();
    getUserInfo(email);
    getContent();


    // getWatchListContentIds(email);
    // storeContentInWatchList(watchListIds);





    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return (userInfoLoaded == false) ?
    Stack(children: [
      Image.asset(
        "assets/images/background.jpg",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
        body: Center(
          child: ColorLoader4(
        dotOneColor: Colors.pink,
        dotTwoColor: Colors.amber,
        dotThreeColor: Colors.deepOrange,
        duration: Duration(seconds: 1),
      ),
        ),
      )

    ] )
        : Stack(
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
                preferredSize: Size(screenSize.width, 50.0),
                child: (isWatchListLoaded == false) ? SizedBox(width: 1.0,) : CustomAppBar(scrollOffset: _scrollOffset,firebase_classics: firebase_classics, firebase_myList: firebase_watchList, firebase_originals: firebase_originals, firebase_previews: firebase_previews,),

              ),
              body: CustomScrollView(
                controller: _scrollController,
                slivers: [

                  SliverToBoxAdapter(
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: RichText(
                                      text: TextSpan(


                                        children: <TextSpan>[
                                          TextSpan(text: 'Welcome, ' , style: GoogleFonts.quicksand(
                                            textStyle: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 32.0,

                                            ),
                                          )),

                                          TextSpan(text: '$dispName!', style: GoogleFonts.quicksand(
                                            textStyle: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 32.0,
                                            ),
                                          )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),



                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // SliverToBoxAdapter(
                  //   child: ContentHeader(featuredContent: sintelContent),
                  // ),

                  //Admin button
                  (isAdmin == false) ? SliverToBoxAdapter(child: SizedBox(width: 1.0,)) : SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FlatButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AdminScreen()),
                            );
                          },
                          child: Container(
                            width: 160.0,
                            height: 40.0,

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.green,
                            ),
                            child: Center(
                              child: Text(
                                'Admin Panel',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.only(top: 30.0,bottom: 30.0),
                    sliver: SliverToBoxAdapter(
                      child: Previews(
                        key: PageStorageKey('previews'),
                        title: 'Previews',
                        contentList: firebase_previews,
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.only(top: 30.0,bottom: 30.0),
                    sliver: SliverToBoxAdapter(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: 130.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24.0),
                              // child: Text(
                              //   'My list',
                              //   style: const TextStyle(
                              //     color: Colors.white,
                              //     fontSize: 20.0,
                              //     fontWeight: FontWeight.bold,
                              //   ),
                              //
                              // ),
                            ),

                            (isWatchListLoaded == false) ? Padding(
                              padding: const EdgeInsets.only(top: 30.0,bottom: 30.0,left: 24.0, right: 24.0),
                              child: Row(
                                children: [
                                  Text(
                                    'Fetching your watch list',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(width: 20.0,),
                                  ColorLoader4(
                                    dotOneColor: Colors.pink,
                                    dotTwoColor: Colors.amber,
                                    dotThreeColor: Colors.deepOrange,
                                    duration: Duration(seconds: 1),
                                  ),
                                ],
                              ),
                            ) : ContentList(
                              key: PageStorageKey('myList'),
                              title: 'My List',

                              contentList: firebase_watchList,

                            ),
                          ],
                        ),
                      ),

                    ),
                  ),

                  SliverToBoxAdapter(
                    child: ContentList(
                      key: PageStorageKey('originals'),
                      title: 'Netflix Originals',
                      contentList: firebase_originals,
                      isOriginals: true,
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.only(top: 30.0,bottom: 30.0),
                    sliver: SliverToBoxAdapter(
                      child: ContentList(
                        key: PageStorageKey('trending'),
                        title: 'Classics',
                        contentList: firebase_classics,
                      ),
                    ),
                  )

                ],
              ),


            ),
          ],

        );
  }
}
