import 'package:flutter/material.dart';
import 'package:netflix_clone/Database/DatabaseManager.dart';
import 'package:netflix_clone/models/content_model.dart';
import 'package:netflix_clone/screens/video_player_screen.dart';
import 'package:netflix_clone/widgets/custom_app_bar.dart';

class SeeAllScreen extends StatefulWidget {
  final List<Content> contentList;
  final String heading;

  const SeeAllScreen({Key? key, required this.contentList, required this.heading}) : super(key: key);




  @override
  _SeeAllScreenState createState() => _SeeAllScreenState();
}

class _SeeAllScreenState extends State<SeeAllScreen> {
  bool isLoading = true;
  List<Widget> foundContent = [];

  @override
  void initState() {

    for(int i=0; i<widget.contentList.length;  i++){
      setState(() {
        isLoading = true;
        foundContent.add(
          InkWell(
            onTap: () async{
              await DatabaseManager().increaseView(widget.contentList[i].id);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VideoPlayScreen(
                  videoUrl: widget.contentList[i].videoUrl,
                  videoTitle: widget.contentList[i].name,
                  views: widget.contentList[i].views!,
                  description: widget.contentList[i].description,
                  imgUrl: widget.contentList[i].imageUrl,
                  id: widget.contentList[i].id,
                )),
              );
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(

                    height: 200.0,
                    width: 130.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(widget.contentList[i].imageUrl),
                          fit: BoxFit.cover,
                        )
                    ),
                  ),
                ),
                SizedBox(height: 10.0,),
                Text(
                  widget.contentList[i].name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                )
              ],
            ),
          ),
        );

        isLoading = false;

      });

    }
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final Size screenSize = MediaQuery.of(context).size;
    return Stack(
      children: [
        Image.asset(
          "assets/images/background.jpg",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),

        SafeArea(
          child: Scaffold(
            extendBodyBehindAppBar: false,

            appBar: PreferredSize(
              preferredSize: Size(screenSize.width, 50.0),
              child: CustomAppBar2()

            ),
            body: SingleChildScrollView(
              child: (isLoading == true) ? Center(child: CircularProgressIndicator(),) : Center(
                child: Container(
                  width: (MediaQuery.of(context).size.width > 800) ? MediaQuery.of(context).size.width * 0.6 : MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Text(
                        widget.heading,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,

                        ),
                      ),

                      SizedBox(height: 40.0,),

                      Wrap(
                        alignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        children: foundContent,),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

      ],

    );
  }
}
