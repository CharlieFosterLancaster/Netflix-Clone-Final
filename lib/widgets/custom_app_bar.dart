import 'package:flutter/material.dart';
import 'package:netflix_clone/assets.dart';
import 'package:netflix_clone/models/content_model.dart';
import 'package:netflix_clone/screens/home_screen.dart';
import 'package:netflix_clone/screens/nav_screen.dart';
import 'package:netflix_clone/screens/profile_screen.dart';
import 'package:netflix_clone/screens/search_content_screen_users.dart';
import 'package:netflix_clone/screens/see_all_screen.dart';
import 'package:netflix_clone/widgets/responsive.dart';

class CustomAppBar extends StatelessWidget {
  final double scrollOffset;
  final List<Content> firebase_previews;
  final List<Content> firebase_myList;
  final List<Content> firebase_originals;
  final List<Content> firebase_classics;

  const CustomAppBar({Key? key, required this.scrollOffset, required this.firebase_previews, required this.firebase_myList, required this.firebase_originals, required this.firebase_classics}) : super(key: key);





  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 24.0
      ),
      color: Colors.black.withOpacity(((scrollOffset/350).clamp(0,1)).toDouble()),
      child: Responsive(
        mobile: _CustomAppbarMobile(firebase_classics: firebase_classics, firebase_myList: firebase_myList, firebase_originals: firebase_originals, firebase_previews: firebase_previews,),
        desktop: _CustomAppbarDesktop(firebase_classics: firebase_classics, firebase_myList: firebase_myList, firebase_originals: firebase_originals, firebase_previews: firebase_previews,),
      )
    );
  }
}

class _CustomAppbarMobile extends StatelessWidget {

  final List<Content> firebase_previews;
  final List<Content> firebase_myList;
  final List<Content> firebase_originals;
  final List<Content> firebase_classics;

  const _CustomAppbarMobile({Key? key, required this.firebase_previews, required this.firebase_myList, required this.firebase_originals, required this.firebase_classics}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Image.asset(Assets.netflixLogo0),
          const SizedBox(width: 12.0,),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                _AppBarButton(title: 'ORIGINALS', onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SeeAllScreen(contentList: firebase_originals, heading: 'Originals')),
                  );
                }),
                _AppBarButton(title: 'CLASSICS', onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SeeAllScreen(contentList: firebase_classics, heading: 'Classics')),
                  );
                }),



              ],
            ),
          )
        ],
      ),
    );
  }
}

class _CustomAppbarDesktop extends StatelessWidget {

  final List<Content> firebase_previews;
  final List<Content> firebase_myList;
  final List<Content> firebase_originals;
  final List<Content> firebase_classics;

  const _CustomAppbarDesktop({Key? key, required this.firebase_previews, required this.firebase_myList, required this.firebase_originals, required this.firebase_classics}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Image.asset(Assets.netflixLogo1),
          const SizedBox(width: 36.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _AppBarButton(title: 'Home', onTap: () {Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );}),
              // _AppBarButton(title: 'TV Shows', onTap: () => print('TV shows')),
              // _AppBarButton(title: 'Movies', onTap: () => print('Movies')),
              // _AppBarButton(title: 'Latest', onTap: () => print('Latest')),
              // _AppBarButton(title: 'My List', onTap: () => print('My List')),


            ],
          ),

          const Spacer(),

          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.search),
                  color: Colors.white,
                  iconSize: 28.0,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchContentScreenUsers()),
                    );
                  },
                ),


                _AppBarButton(title: 'ORIGINALS', onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SeeAllScreen(contentList: firebase_originals, heading: 'Originals')),
                  );
                }),
                _AppBarButton(title: 'CLASSICS', onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SeeAllScreen(contentList: firebase_classics, heading: 'Classics')),
                  );
                }),

                // IconButton(
                //   padding: EdgeInsets.zero,
                //   icon: Icon(Icons.card_giftcard),
                //   iconSize: 28.0,
                //   color: Colors.white,
                //   onPressed: () => print("Gift"),
                // ),
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.account_box_outlined),
                  iconSize: 28.0,
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()),
                    );
                  },
                ),


              ],
            ),
          ),
        ],
      ),
    );
  }
}


class _AppBarButton extends StatelessWidget {
  final String title;
  final void Function()? onTap;

  const _AppBarButton({Key? key, required this.title,  this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
          title,
          style: const TextStyle(color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.w600)
      ),
    );
  }
}

class CustomAppBar2 extends StatelessWidget {
  const CustomAppBar2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 64.0,
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => NavScreen()),
                  );
                },
                  child: Image.asset(Assets.netflixLogo0)
              ),
              const SizedBox(width: 24.0,),
              _AppBarButton(title: 'Home', onTap: () {
                Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => NavScreen()),
              );}),
              Spacer(),
              IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(Icons.account_box_outlined),
                iconSize: 28.0,
                color: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                },
              ),




            ],
          ),
        ),
      ),
    );
  }
}



