import 'package:flutter/material.dart';
import 'package:netflix_clone/Database/DatabaseManager.dart';
import 'package:netflix_clone/progress_indicators/color_loader_4.dart';
import 'package:netflix_clone/screens/search_content_screen.dart';
import 'package:netflix_clone/screens/video_player_screen.dart';
import 'package:netflix_clone/widgets/custom_app_bar.dart';

class SearchContentScreenUsers extends StatefulWidget {


  @override
  _SearchContentScreenUsersState createState() => _SearchContentScreenUsersState();
}

class _SearchContentScreenUsersState extends State<SearchContentScreenUsers> {
  @override
  Widget build(BuildContext context) {
    return mobileSearchContentScreen();
  }
}

class mobileSearchContentScreen extends StatefulWidget {


  @override
  _mobileSearchContentScreenState createState() => _mobileSearchContentScreenState();
}

class _mobileSearchContentScreenState extends State<mobileSearchContentScreen>{

  TextEditingController _contentName = TextEditingController();
  List<Widget> foundContent = [];
  String searchWord = "";


  late Future myFuture;









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
                  width: (MediaQuery.of(context).size.width > 800) ? MediaQuery.of(context).size.width * 0.6 : MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 20.0),
                        child: Text(
                          'Type the title of content you want to update.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),


                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 20.0),
                        child: TextField(
                          controller: _contentName,
                          onChanged: (val) {
                            setState(() {
                              searchWord = val;
                              myFuture = DatabaseManager().getContent(val);

                            });
                          },
                          onSubmitted: (val) {
                            setState(() {
                              searchWord = val;
                              myFuture = DatabaseManager().getContent(val);
                            });
                          },


                          style: TextStyle(
                              color: Colors.white
                          ),
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                            filled: true,
                            fillColor: Color(0xFF3A3737),
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(5.0),
                              ),
                            ),
                            labelText: 'Content name',
                            labelStyle: TextStyle(color: Colors.grey),

                          ),
                        ),
                      ),



                      (searchWord == "") ? Center(child: Text('Nothing searched yet', style: TextStyle(color: Colors.grey),)) : FutureBuilder(
                          future: myFuture,
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                            if(snapshot.hasData){
                              print(snapshot.data.length);
                              if (snapshot.data.length == 0) {
                                return Center(
                                    child: Column(
                                      children: [
                                        Text(
                                          'No content found, please type full name.',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                        SizedBox(height: 20.0,),
                                        ColorLoader4(
                                          dotOneColor: Colors.pink,
                                          dotTwoColor: Colors.amber,
                                          dotThreeColor: Colors.deepOrange,
                                          duration: Duration(seconds: 1),
                                        ),
                                      ],
                                    ));
                              }

                              else{
                                for(int i = 0; i < snapshot.data.length; i++){
                                  print(snapshot.data[i]['description']);
                                  foundContent.add(
                                      InkWell(
                                        //pass the data in arguments while navigating
                                        onTap: () async{
                                          await DatabaseManager().increaseView(snapshot.data[i]['id']);
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(builder: (context) => VideoPlayScreen(
                                              videoUrl: snapshot.data[i]['videoUrl'],
                                              videoTitle: snapshot.data[i]['contentName'],
                                              views: snapshot.data[i]['views']!,
                                              description: snapshot.data[i]['description'],
                                              imgUrl: snapshot.data[i]['imgUrl'],
                                              id: snapshot.data[i]['id'],
                                            )),
                                          );

                                          //push to video player page

                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(builder: (context) => UpdateContentScreen(
                                          //     contentName: snapshot.data[i]['contentName'],
                                          //     id: snapshot.data[i]['id'],
                                          //     imgUrl: snapshot.data[i]['imgUrl'],
                                          //     videoUrl: snapshot.data[i]['videoUrl'],
                                          //     description: snapshot.data[i]['description'],
                                          //     gotDropDownValue: snapshot.data[i]['typeOfContent'],
                                          //   )),
                                          // );
                                        },

                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Container(
                                                height: 250.0,
                                                width: 140.0,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage(snapshot.data[i]['imgUrl']),
                                                      fit: BoxFit.cover,
                                                    )
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 5.0,),
                                            Text(
                                              snapshot.data[i]['contentName'],
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            )
                                          ],
                                        ),
                                      )

                                  );

                                }
                                return Column(
                                  children: [

                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                          child: Text(
                                            'Recent searches',
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20.0,),
                                    Wrap(
                                      crossAxisAlignment: WrapCrossAlignment.start,
                                      children: foundContent,),
                                  ],
                                );
                              }
                            } else{
                              return Center(
                                child: ColorLoader4(
                                  dotOneColor: Colors.pink,
                                  dotTwoColor: Colors.amber,
                                  dotThreeColor: Colors.deepOrange,
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            }

                          }
                      )


                    ],
                  ),
                ),
              ),
            ),
          ),

        ],

      ),
    );
  }
}
