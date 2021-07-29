import 'package:flutter/material.dart';
import 'package:netflix_clone/Database/DatabaseManager.dart';
import 'package:netflix_clone/models/content_model.dart';
import 'package:netflix_clone/screens/video_player_screen.dart';

class Previews extends StatefulWidget {
  final String title;
  final List<Content> contentList;

  const Previews({Key? key, required this.title, required this.contentList}) : super(key: key);

  @override
  _PreviewsState createState() => _PreviewsState();
}

class _PreviewsState extends State<Previews> {

  Color inActiveBorderColor = Colors.white;
  Color activeBorderColor = Colors.orange;
  late Color borderColor;
  bool isHovered = false;



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            widget.title,

            style: const TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          height: 200.0,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 8.0,
            ),
            scrollDirection: Axis.horizontal,
              itemCount: widget.contentList.length,
              itemBuilder: (BuildContext context, int index){
                final Content content = widget.contentList[index];

                return InkWell(
                  //Clicking here will take to the video player...
                  onTap: () async{
                    await DatabaseManager().increaseView(content.id);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VideoPlayScreen(
                          videoUrl: content.videoUrl,
                          videoTitle: content.name,
                          views: content.views!,
                          description: content.description,
                          imgUrl: content.imageUrl,
                        id: content.id,
                      )),
                    );
                  },


                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16.0),
                        height: 130.0,
                        width: 130.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(content.imageUrl),
                            fit: BoxFit.cover,
                          ),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 4.0,
                          )
                        ),
                      ),
                      Container(

                        height: 130.0,
                        width: 130.0,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black87,
                                Colors.black45,
                                Colors.transparent,
                              ],
                              stops: [0, 0.25, 1],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: (isHovered) ? Colors.orange : Colors.white,
                              width: 4.0,
                            )
                        ),
                      ),



                      Positioned(
                        bottom: 3,
                          child: Text(
                            content.name,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: (isHovered) ? Colors.white : Colors.grey,


                            ),
                          ),),
                    ],
                  ),
                );
              }
          ),
        )
      ],
    );
  }
}
