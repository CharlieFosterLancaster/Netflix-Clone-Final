import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:netflix_clone/models/content_model.dart';
import 'package:netflix_clone/widgets/custom_app_bar.dart';
import 'package:netflix_clone/widgets/responsive.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';




class VideoPlayScreen extends StatefulWidget {

  final String videoUrl;
  final String videoTitle;
  final int views;
  final String description;
  final String? imgUrl;
  final String id;


  const VideoPlayScreen({Key? key, required this.videoUrl, required this.videoTitle, required this.views,required this.id ,required this.description, this.imgUrl}) : super(key: key);





  @override
  _VideoPlayScreenState createState() => _VideoPlayScreenState();
}

class _VideoPlayScreenState extends State<VideoPlayScreen> {
  @override
  Widget build(BuildContext context) {
    return _mobileVideoPlayScreen(
      videoUrl: widget.videoUrl,
      videoTitle: widget.videoTitle,
      views: widget.views,
      description: widget.description,
      imgUrl: widget.imgUrl,
      id: widget.id,


    );
  }
}

class _mobileVideoPlayScreen extends StatefulWidget {

  final String videoUrl;
  final String videoTitle;
  final int views;
  final String description;
  final String? imgUrl;
  final String id;






  const _mobileVideoPlayScreen({Key? key, required this.videoUrl, required this.videoTitle, required this.id, required this.views, required this.description, this.imgUrl}) : super(key: key);

  @override
  __mobileVideoPlayScreenState createState() => __mobileVideoPlayScreenState();
}

class __mobileVideoPlayScreenState extends State<_mobileVideoPlayScreen> {
  
  late String _videoId;
  late String _description;
  late int _views;
  late String _videoTitle;
  late String? _imgUrl;
  List<Content> recommended = [];
  bool isRecommendedLoading = true;
  late int watchListResponse = -1;

  String email = "";

  //get email address
  Future<void> getUserEmail() async{
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    FirebaseAuth auth = FirebaseAuth.instance;
    setState(() {
      email = auth.currentUser!.email.toString();
    });
  }

  //Store content id in user's watch list
  updateWatchList(String email, String contentId) async{
    try{
      CollectionReference collectionReference = FirebaseFirestore.instance.collection('Users');
      await collectionReference.doc(email).update({
        'watchList': FieldValue.arrayUnion([contentId]),


      });
      setState(() {
        watchListResponse = 0;
      });
      print("WatchList updated");
      return 0;

    }catch(e){
      setState(() {
        watchListResponse = 1;
      });
      print(e);
      return 1;
    }
  }


  //get recommended content
  getRecommendedContent() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection(
        'Content').orderBy('views', descending: true).get();

    final List allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    for (int i = 0; i < allData.length; i++) {
      Map<String, dynamic> values = Map<String, dynamic>.from(allData[i]);
      print(values['typeOfContent']);
      recommended.add(
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
    setState(() {
      isRecommendedLoading = false;
    });
  }


  setVideoId(String videoUrl){
    setState(() {
      _videoId = videoUrl.substring(32, 43);
    });
  }


  late YoutubePlayerController _controller;


  @override
  void initState() {
    setVideoId(widget.videoUrl);
    setState(() {
      _description = widget.description;
      _views = widget.views;
      _videoTitle = widget.videoTitle;
      _imgUrl = widget.imgUrl;
    });
    getUserEmail();
    updateWatchList(email, widget.id);


    _controller = YoutubePlayerController(
      initialVideoId: _videoId,
      params: const YoutubePlayerParams(
        autoPlay: true,
        startAt: const Duration(minutes: 0, seconds: 0),
        showControls: true,
        showFullscreenButton: true,
        desktopMode: false,
        privacyEnhanced: true,
        useHybridComposition: true,
      ),
    );
    _controller.onEnterFullscreen = () {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      log('Entered Fullscreen');
    };
    _controller.onExitFullscreen = () {
      log('Exited Fullscreen');
    };
    getRecommendedContent();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
     dynamic player = YoutubePlayerIFrame(
      controller: _controller,

    );
    return (watchListResponse == -1) ? Center(child: CircularProgressIndicator(),) : (watchListResponse == 1) ? Center(child: Text('Some error occurred',style: TextStyle(color: Colors.white),),) : SafeArea(
      child: Scaffold(

            backgroundColor: Colors.black,
          extendBodyBehindAppBar: true,

          appBar: PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width, 50.0),
              child: CustomAppBar2()

          ),


            body: Responsive(
              mobile: _mobileVideoPlayer(player: player, videoTitle: widget.videoTitle, views: widget.views, description: widget.description, isRecommendedLoading: isRecommendedLoading, recommended: recommended),
              desktop: _desktopVideoPlayer(player: player, videoTitle: widget.videoTitle, views: widget.views, description: widget.description, imgUrl: widget.imgUrl, isRecommendedLoading: isRecommendedLoading, recommended: recommended),
            )

          ),
    );
  }

  /*return YoutubePlayerControllerProvider(
      // Passing controller to widgets below.
      controller: _controller,
      child: SafeArea(
        child: Scaffold(

              backgroundColor: Colors.black,


              body: Responsive(
                mobile: _mobileVideoPlayer(player: player, videoTitle: widget.videoTitle, views: widget.views, description: widget.description, isRecommendedLoading: isRecommendedLoading, recommended: recommended),
                desktop: _desktopVideoPlayer(player: player, videoTitle: widget.videoTitle, views: widget.views, description: widget.description, imgUrl: widget.imgUrl, isRecommendedLoading: isRecommendedLoading, recommended: recommended),
              )

            ),
      ),
    );
  *
  *  */

  @override
  void dispose() {


    recommended.clear();
    super.dispose();
  }
}

class _mobileVideoPlayer extends StatelessWidget {
  const _mobileVideoPlayer({
    Key? key,
    required this.player,
    required String videoTitle,
    required int views,
    required String description,
    required this.isRecommendedLoading,
    required this.recommended,


  }) : _videoTitle = videoTitle, _views = views, _description = description, super(key: key);

  final YoutubePlayerIFrame player;
  final String _videoTitle;
  final int _views;
  final String _description;
  final bool isRecommendedLoading;
  final List<Content> recommended;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        player,
      Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            SizedBox(height: 0.01,),
            Text(
              _videoTitle,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 10),

            Text(
              'Views: ${_views}',
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 10),
            const SizedBox(height: 10),

            Text(
              _description,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              child: Text(
                'Most watched content',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),

            RecommendedContentCards(isRecommendedLoading: isRecommendedLoading, recommended: recommended),
            // SourceInputSection(),
            // _space,
            // PlayPauseButtonBar(),
            // _space,
            // VolumeSlider(),
            // _space,
            // PlayerStateSection(),
          ],
        ),
      ),
      ],
    );
  }
}

class _desktopVideoPlayer extends StatelessWidget {
  const _desktopVideoPlayer({
    Key? key,
    required this.player,
    required String videoTitle,
    required int views,
    required String description,
    required String? imgUrl,
    required this.isRecommendedLoading,
    required this.recommended,
  }) : _videoTitle = videoTitle, _views = views, _description = description, _imgUrl = imgUrl, super(key: key);

  final YoutubePlayerIFrame player;
  final String _videoTitle;
  final int _views;
  final String _description;
  final String? _imgUrl;
  final bool isRecommendedLoading;
  final List<Content> recommended;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.92,
            minWidth: MediaQuery.of(context).size.width,
          ),
            child: player),
        // Row(
        //   mainAxisSize: MainAxisSize.max,
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //      Container(
        //
        //          height: MediaQuery.of(context).size.height * 0.96,
        //          child: Column(
        //            children: [
        //              Expanded(child: player),
        //            ],
        //          )),
        //
        //
        //   ],
        // ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height * 0.6,
              maxWidth: double.infinity,
              minWidth: double.infinity,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      _imgUrl!,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [

                  Positioned(
                    left: 0,
                    top: 0,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height * 0.6,
                        maxWidth: MediaQuery.of(context).size.width * 1.4,
                        minWidth: MediaQuery.of(context).size.width * 1.4,
                      ),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.black, Colors.transparent],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          )
                        ),
                      ),

                    )
                  ),

                  Positioned(

                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,

                          children: [
                            SizedBox(height: 40.0,),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Text(
                                _videoTitle,

                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 48.0,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),

                            SizedBox(height: 105.0,),

                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Text(
                                _description,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),

                            SizedBox(height: 100.0,),


                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Row(
                                children: [
                                  Icon(
                                      Icons.bar_chart,
                                    color: Colors.grey,
                                  ),

                                  SizedBox(width: 10.0,),

                                  Text(
                                    'Views: $_views',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),


                          ],
                        ),
                      )
                  )


                ],
              ),
            ),
          )
        ),






        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Text(
            'Most watched content',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
        ),

        RecommendedContentCards(isRecommendedLoading: isRecommendedLoading, recommended: recommended),





      ],

    );
  }
}

class RecommendedContentCards extends StatelessWidget {
  const RecommendedContentCards({
    Key? key,
    required this.isRecommendedLoading,
    required this.recommended,
  }) : super(key: key);

  final bool isRecommendedLoading;
  final List<Content> recommended;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: (isRecommendedLoading) ? Center(child: CircularProgressIndicator(),) : Container(

            height:MediaQuery.of(context).size.height * 0.5,
            child: ListView.builder(
               itemCount: recommended.length,

                scrollDirection: Axis.horizontal,

                itemBuilder: (BuildContext context, int index) {

                  final Content content = recommended[index];
                  print(content);
                  return Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: InkWell(
                      onTap: () {
                        print(content.name);
                        print(content.videoUrl);
                        print(content.description);
                        print(content.views);
                        print(content.imageUrl);
                        print(content.id);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => VideoPlayScreen(videoUrl: content.videoUrl,id: content.id ,videoTitle: content.name, views: content.views!, description: content.description, imgUrl: content.imageUrl)),
                        );
                      },
                      child: Container(
                        child: Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.2,
                              width: MediaQuery.of(context).size.height * 0.13,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(content.imageUrl),
                                    fit: BoxFit.cover,
                                  )
                              ),
                            ),
                            SizedBox(height: 10.0,),
                            Text(
                              content.name,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }
            ),
          )
        ),
        SizedBox(height: 50.0,),
      ],
    );
  }
}



// class Controls extends StatelessWidget {
//
//   final String? videoTitle;
//   final int? views;
//   final String? description;
//
//   const Controls({Key? key, this.videoTitle, this.views,  this.description}) : super(key: key);
//   ///
//
//
//   @override
//   Widget build(BuildContext context) {
//     return
//   }
//
//   Widget get _space => const SizedBox(height: 10);
// }


/* Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                            child: (isRecommendedLoading) ? Center(child: CircularProgressIndicator(),) : Container(
                              height:MediaQuery.of(context).size.height * 0.3,
                              child: ListView.builder(
                                 itemCount: recommended.length,
                                  scrollDirection: Axis.horizontal,

                                  itemBuilder: (BuildContext context, int index) {

                                    final Content content = recommended[index];
                                    print(content);
                                    return Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 200.0,
                                              width: 130.0,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: NetworkImage(content.imageUrl),
                                                    fit: BoxFit.cover,
                                                  )
                                              ),
                                            ),
                                            SizedBox(height: 10.0,),
                                            Text(
                                              content.name,
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
                                  }
                              ),
                            )
                          ),
 */
