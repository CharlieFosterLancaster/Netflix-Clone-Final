import 'package:flutter/material.dart';
import 'package:netflix_clone/Database/DatabaseManager.dart';
import 'package:netflix_clone/models/content_model.dart';
import 'package:netflix_clone/screens/see_all_screen.dart';
import 'package:netflix_clone/screens/video_player_screen.dart';

class ContentList extends StatelessWidget {
  final String title;
  final List<Content> contentList;
  final bool isOriginals;

  const ContentList({Key? key, required this.title, required this.contentList, this.isOriginals = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SeeAllScreen(contentList: contentList, heading: title,)),

                    );
                  },
                  child: Text(
                    'See all',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          (contentList.length == 0) ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
            child: Text('No content in $title',style: TextStyle(color: Colors.grey,fontSize: 16.0),),
          ) : Container(
            height: isOriginals ? 500.0 : 300.0,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                scrollDirection: Axis.horizontal,
                itemCount: contentList.length,
                itemBuilder: (BuildContext context, int index){
                final Content content = contentList[index];

                  return InkWell(
                    onTap: () async{
                      await DatabaseManager().increaseView(content.id);
                      Navigator.pushReplacement(
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
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          height: isOriginals ? 400.0 : 200.0,
                          width: isOriginals ? 200.0 : 130.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(content.imageUrl),
                              fit: BoxFit.cover,
                            )
                          ),
                        ),
                        Text(
                          content.name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  );
                }),
          )
        ],
    );

  }
}
